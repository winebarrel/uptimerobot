class UptimeRobot::Client
  ENDPOINT = "https://api.uptimerobot.com/v2/"
  USER_AGENT = "Ruby UptimeRobot Client #{UptimeRobot::GEM_VERSION}"

  METHODS = [
    :getAccountDetails,
    :getMonitors,
    :newMonitor,
    :editMonitor,
    :deleteMonitor,
    :getAlertContacts,
    :newAlertContact,
    :deleteAlertContact
  ]

  DEFAULT_ADAPTERS = [
    Faraday::Adapter::NetHttp,
    Faraday::Adapter::Test
  ]

  OPTIONS = [
    :api_key,
    :raise_no_monitors_error,
    :skip_unescape_monitor,
    :debug
  ]

  def initialize(options)
    @options = {}

    OPTIONS.each do |key|
      @options[key] = options.delete(key)
    end

    raise ArgumentError, ':api_key is required' unless @options[:api_key]

    options[:url] ||= ENDPOINT

    @conn = Faraday.new(options) do |faraday|
      faraday.request  :url_encoded
      faraday.response :json, :content_type => /\bjson$/
      faraday.response :raise_error
      faraday.response :logger, ::Logger.new(STDOUT), bodies: true if @options[:debug]

      yield(faraday) if block_given?

      unless DEFAULT_ADAPTERS.any? {|i| faraday.builder.handlers.include?(i) }
        faraday.adapter Faraday.default_adapter
      end
    end

    @conn.headers[:user_agent] = USER_AGENT
  end

  private

  def method_missing(method_name, *args, &block)
    unless METHODS.include?(method_name)
      raise NoMethodError, "undefined method: #{method_name}"
    end

    len = args.length
    params = args.first

    unless len.zero? or (len == 1 and params.kind_of?(Hash))
      raise ArgumentError, "invalid argument: #{args}"
    end

    request(method_name, params || {}, &block)
  end

  def request(method_name, params = {})
    params.update(
      :api_key => @options[:api_key],
      :format => 'json',
      :noJsonCallback => 1
    )

    response = @conn.post do |req|
      req.url "/#{UptimeRobot::API_VERSION}/#{method_name}"
      req.body = URI.encode_www_form(params)
      yield(req) if block_given?
    end

    json = response.body
    validate_response!(json)

    if method_name == :getMonitors and not @options[:skip_unescape_monitor]
      unescape_monitor!(json)
    end

    json
  end

  def validate_response!(json)
    if json['stat'] != 'ok'
      if json['id'] == '212'
        if @options[:raise_no_monitors_error]
          raise UptimeRobot::Error.new(json)
        else
          json.update(
            'total' => '0',
            'monitors' => []
          )
        end
      else
        raise UptimeRobot::Error.new(json)
      end
    end
  end

  def unescape_monitor!(json)
    json['monitors'].each do |monitor|
      %w(friendly_name keyword_value http_username http_password).each do |key|
        value = monitor[key] || ''
        next if value.empty?
        monitor[key] = CGI.unescapeHTML(value)
      end
    end
  end
end
