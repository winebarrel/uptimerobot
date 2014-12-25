class UptimeRobot::Error < StandardError
  attr_reader :json

  def initialize(json)
    @json = json
    super(json.inspect)
  end
end
