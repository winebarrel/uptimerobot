class UptimeRobot::Client
  ENDPOINT = 'http://api.uptimerobot.com'
  USER_AGENT = "Ruby UptimeRobot Client #{UptimeRobot::VERSION}"

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

  def initialize(options)
    @apiKey = options.delete(:apiKey)

    raise ':apiKey is required' unless @apiKey

    options[:url] ||= ENDPOINT

    @conn = Faraday.new(options) do |faraday|
      faraday.request  :url_encoded
      faraday.response :json, :content_type => /\bjson$/
      faraday.response :raise_error

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
      :apiKey => @apiKey,
      :format => 'json',
      :noJsonCallback => 1
    )

    response = @conn.get do |req|
      req.url "/#{method_name}"
      req.params = params
      yield(req) if block_given?
    end

    json = response.body

    if json['stat'] != 'ok'
      raise UptimeRobot::Error.new(json)
    end

    json
  end
end
