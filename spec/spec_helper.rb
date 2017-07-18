require 'uptimerobot'

DEFAULT_PARAMS = {
  'api_key' => 'ZAPZAPZAP',
  'format' => 'json',
  'noJsonCallback' => '1'
}

def decoded_request_body(body)
  Hash[URI.decode_www_form(body)]
end

def uptime_robot(options = {})
  options = {api_key: 'ZAPZAPZAP'}.merge(options)

  stubs = Faraday::Adapter::Test::Stubs.new

  described_class.new(options) do |faraday|
    faraday.adapter :test, stubs do |stub|
      yield(stub)
    end
  end
end

def stringify_hash(hash)
  Hash[*hash.map {|k, v| [k.to_s, v.to_s] }.flatten(1)]
end
