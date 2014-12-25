describe UptimeRobot::Client do
  describe '#getAccountDetails' do
    let(:response) do
      {"stat"=>"ok",
       "account"=>
        {"monitorLimit"=>"100",
         "upMonitors"=>"35",
         "downMonitors"=>"9",
         "pausedMonitors"=>"11"}}
    end

    it do
      client = uptime_robot do |stub|
        stub.get('getAccountDetails') do |env|
          expect(env.params).to eq DEFAULT_PARAMS
          [200, {'Content-Type' => 'json'}, JSON.dump(response)]
        end
      end

      expect(client.getAccountDetails).to eq response
    end
  end

  describe '#getMonitors' do
    let(:params) do
      {
        :logs => 1,
        :alertContacts => 1,
        :responseTimes => 1,
        :responseTimesAverage => 180,
        :monitors => '15830-32696'
      }
    end

    let(:response) do
      {"stat"=>"ok",
       "offset"=>"0",
       "limit"=>"50",
       "total"=>"2",
       "monitors"=>
        {"monitor"=>
          [{"id"=>"128795",
            "friendlyname"=>"Yahoo",
            "url"=>"http://www.yahoo.com/",
            "type"=>"1",
            "subtype"=>"",
            "keywordtype"=>"0",
            "keywordvalue"=>"",
            "httpusername"=>"",
            "httppassword"=>"",
            "port"=>"",
            "interval"=>"300",
            "status"=>"2",
            "alltimeuptimeratio"=>"99.98",
            "customuptimeratio"=>"100.00",
            "alertcontact"=>
             [{"id"=>"4631", "type"=>"2", "value"=>"uptime@webresourcesdepot.com"},
              {"id"=>"2420", "type"=>"3", "value"=>"umutm"}],
            "log"=>
             [{"type"=>"2",
               "datetime"=>"09/25/2011 16:12:44",
               "alertcontact"=>
                [{"type"=>"0", "value"=>"uptime@webresourcesdepot.com"},
                 {"type"=>"3", "value"=>"umutm"}]},
              {"type"=>"1",
               "datetime"=>"09/25/2011 16:11:44",
               "alertcontact"=>
                [{"type"=>"0", "value"=>"uptime@webresourcesdepot.com"},
                 {"type"=>"3", "value"=>"umutm"}]}],
            "responsetime"=>
             [{"datetime"=>"02/04/2014 11:30:41", "value"=>"405"},
              {"datetime"=>"02/04/2014 12:00:41", "value"=>"516"},
              {"datetime"=>"02/04/2014 12:30:41", "value"=>"780"}]},
           {"id"=>"128796",
            "friendlyname"=>"WebResourcesDepot",
            "url"=>"http://www.webresourcesdepot.com/",
            "type"=>"1",
            "subtype"=>"",
            "keywordtype"=>"0",
            "keywordvalue"=>"",
            "httpusername"=>"",
            "httppassword"=>"",
            "port"=>"",
            "interval"=>"300",
            "status"=>"2",
            "alltimeuptimeratio"=>"99.94",
            "customtimeuptimeratio"=>"89.51",
            "alertcontact"=>[{"id"=>"2420", "type"=>"3", "value"=>"umutm"}],
            "log"=>
             [{"type"=>"2",
               "datetime"=>"08/30/2011 16:11:15",
               "alertcontact"=>
                [{"type"=>"0", "value"=>"uptime@webresourcesdepot.com"},
                 {"type"=>"3", "value"=>"umutm"}]},
              {"type"=>"1",
               "datetime"=>"08/30/2011 16:09:30",
               "alertcontact"=>
                [{"type"=>"0", "value"=>"uptime@webresourcesdepot.com"},
                 {"type"=>"3", "value"=>"umutm"}]}],
            "responsetime"=>
             [{"datetime"=>"02/04/2014 11:48:41", "value"=>"405"},
              {"datetime"=>"02/04/2014 12:18:41", "value"=>"516"},
              {"datetime"=>"02/04/2014 12:48:41", "value"=>"780"}]}]}}
    end

    it do
      client = uptime_robot do |stub|
        stub.get('getMonitors') do |env|
          expect(env.params).to eq DEFAULT_PARAMS.merge(stringify_hash(params))
          [200, {'Content-Type' => 'json'}, JSON.dump(response)]
        end
      end

      expect(client.getMonitors(params)).to eq response
    end
  end

  describe '#newMonitor' do
    let(:params) do
      {
        :monitorFriendlyName => 'Google',
        :monitorURL => 'http://www.google.com',
        :monitorType => UptimeRobot::Monitor::Type::HTTP,
        :monitorAlertContacts => '448-716'
      }
    end

    let(:response) do
      {"stat"=>"ok", "monitor"=>{"id"=>"128798"}}
    end

    it do
      client = uptime_robot do |stub|
        stub.get('newMonitor') do |env|
          expect(env.params).to eq DEFAULT_PARAMS.merge(stringify_hash(params))
          [200, {'Content-Type' => 'json'}, JSON.dump(response)]
        end
      end

      expect(client.newMonitor(params)).to eq response
    end
  end

  describe '#editMonitor' do
    let(:params) do
      {
        :monitorID => 128798,
        :monitorFriendlyName => 'GoogleHomepage'
      }
    end

    let(:response) do
      {"stat"=>"ok", "monitor"=>{"id"=>"128798"}}
    end

    it do
      client = uptime_robot do |stub|
        stub.get('editMonitor') do |env|
          expect(env.params).to eq DEFAULT_PARAMS.merge(stringify_hash(params))
          [200, {'Content-Type' => 'json'}, JSON.dump(response)]
        end
      end

      expect(client.editMonitor(params)).to eq response
    end
  end

  describe '#deleteMonitor' do
    let(:params) do
      {
        :monitorID => 128798
      }
    end

    let(:response) do
      {"stat"=>"ok", "monitor"=>{"id"=>"128798"}}
    end

    it do
      client = uptime_robot do |stub|
        stub.get('deleteMonitor') do |env|
          expect(env.params).to eq DEFAULT_PARAMS.merge(stringify_hash(params))
          [200, {'Content-Type' => 'json'}, JSON.dump(response)]
        end
      end

      expect(client.deleteMonitor(params)).to eq response
    end
  end

  describe '#getAlertContacts' do
    let(:params) do
      {
        :alertcontacts => 236
      }
    end

    let(:response) do
      {"stat"=>"ok",
       "offset"=>"0",
       "limit"=>"50",
       "total"=>"1",
       "alertcontacts"=>
        {"alertcontact"=>
          [{"id"=>"236",
            "value"=>"uptime@webresourcesdepot.com",
            "type"=>"2",
            "status"=>"2"}]}}
    end

    it do
      client = uptime_robot do |stub|
        stub.get('getAlertContacts') do |env|
          expect(env.params).to eq DEFAULT_PARAMS.merge(stringify_hash(params))
          [200, {'Content-Type' => 'json'}, JSON.dump(response)]
        end
      end

      expect(client.getAlertContacts(params)).to eq response
    end
  end

  describe '#newAlertContact' do
    let(:params) do
      {
        :alertContactType => UptimeRobot::AlertContact::Type::Email,
        :alertContactValue => 'uptime@webresourcesdepot.com'
      }
    end

    let(:response) do
      {"stat"=>"ok", "alertcontact"=>{"id"=>"4561", "status"=>"0"}}
    end

    it do
      client = uptime_robot do |stub|
        stub.get('newAlertContact') do |env|
          expect(env.params).to eq DEFAULT_PARAMS.merge(stringify_hash(params))
          [200, {'Content-Type' => 'json'}, JSON.dump(response)]
        end
      end

      expect(client.newAlertContact(params)).to eq response
    end
  end

  context 'when stat is fail' do
    let(:response) do
      {"stat"=>"fail", "id"=>"101", "message"=>"apiKey is wrong"}
    end

    it do
      client = uptime_robot do |stub|
        stub.get('getAccountDetails') do |env|
          expect(env.params).to eq DEFAULT_PARAMS
          [200, {'Content-Type' => 'json'}, JSON.dump(response)]
        end
      end

      expect {
        client.getAccountDetails
      }.to raise_error(UptimeRobot::Error, response.inspect)
    end
  end

  context 'when status is not 200' do
    it do
      client = uptime_robot do |stub|
        stub.get('getAccountDetails') do |env|
          expect(env.params).to eq DEFAULT_PARAMS
          [500, {}, 'An error occurred on the server when processing the URL']
        end
      end

      expect {
        client.getAccountDetails
      }.to raise_error
    end
  end

  context 'when undefined method is called' do
    it do
      client = uptime_robot

      expect {
        client.get_account_details
      }.to raise_error(NoMethodError, 'undefined method: get_account_details')
    end
  end

  context 'when invalid params is passed' do
    it do
      client = uptime_robot

      expect {
        client.getAccountDetails(0)
      }.to raise_error(ArgumentError, 'invalid argument: [0]')
    end
  end
end
