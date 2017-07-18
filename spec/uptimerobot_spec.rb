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
        stub.post('/v2/getAccountDetails') do |env|
          expect(decoded_request_body(env.body)).to eq DEFAULT_PARAMS
          [200, {'Content-Type' => 'application/json'}, JSON.dump(response)]
        end
      end


      expect(client.getAccountDetails).to eq response
    end
  end

  describe '#getMonitors' do
    let(:params) do
      {
        :logs => 1,
        :alert_contacts => 1,
        :response_times => 1,
        :response_times_average => 180,
        :monitors => '15830-32696'
      }
    end

    let(:response) do
      {"stat"=>"ok",
       "pagination"=>{
         "offset"=>"0",
         "limit"=>"50",
         "total"=>"2"
       },
       "monitors"=>
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
            {"datetime"=>"02/04/2014 12:48:41", "value"=>"780"}]}]}
    end

    it do
      client = uptime_robot do |stub|
        stub.post('/v2/getMonitors') do |env|
          expect(decoded_request_body(env.body)).to eq DEFAULT_PARAMS.merge(stringify_hash(params))
          [200, {'Content-Type' => 'application/json'}, JSON.dump(response)]
        end
      end

      expect(client.getMonitors(params)).to eq response
    end

    context 'when include escaped string' do
      let(:response_with_escaped_string) do
        res = response.dup
        monitor = res['monitors'][0]
        monitor['friendly_name'] = 'http monitor &#40;basic auth&#41;'
        monitor['keyword_value'] = '&#40;keyword_value&#41;'
        monitor['http_username'] = '&#40;http_username&#41;'
        monitor['http_password'] = '&#40;http_password&#41;'
        res
      end

      let(:response_with_unescaped_string) do
        res = response.dup
        monitor = res['monitors'][0]
        monitor['friendly_name'] = 'http monitor (basic auth)'
        monitor['keyword_value'] = '(keyword_value)'
        monitor['http_username'] = '(http_username)'
        monitor['http_password'] = '(http_password)'
        res
      end

      it do
        client = uptime_robot do |stub|
          stub.post('/v2/getMonitors') do |env|
            expect(decoded_request_body(env.body)).to eq DEFAULT_PARAMS.merge(stringify_hash(params))
            [200, {'Content-Type' => 'application/json'}, JSON.dump(response_with_escaped_string)]
          end
        end

        expect(client.getMonitors(params)).to eq response_with_unescaped_string
      end

      it do
        client = uptime_robot(:skip_unescape_monitor => true) do |stub|
          stub.post('/v2/getMonitors') do |env|
            expect(decoded_request_body(env.body)).to eq DEFAULT_PARAMS.merge(stringify_hash(params))
            [200, {'Content-Type' => 'application/json'}, JSON.dump(response_with_escaped_string)]
          end
        end

        expect(client.getMonitors(params)).to eq response_with_escaped_string
      end
    end
  end

  describe '#newMonitor' do
    let(:params) do
      {
        :friendly_name => 'Google',
        :url => 'http://www.google.com',
        :type => UptimeRobot::Monitor::Type::HTTP,
        :alert_contacts => '448-716'
      }
    end

    let(:response) do
      {"stat"=>"ok", "monitor"=>{"id"=>"128798"}}
    end

    it do
      client = uptime_robot do |stub|
        stub.post('/v2/newMonitor') do |env|
          expect(decoded_request_body(env.body)).to eq DEFAULT_PARAMS.merge(stringify_hash(params))
          [200, {'Content-Type' => 'application/json'}, JSON.dump(response)]
        end
      end

      expect(client.newMonitor(params)).to eq response
    end
  end

  describe '#editMonitor' do
    let(:params) do
      {
        :id => 128798,
        :friendly_name => 'GoogleHomepage'
      }
    end

    let(:response) do
      {"stat"=>"ok", "monitor"=>{"id"=>"128798"}}
    end

    it do
      client = uptime_robot do |stub|
        stub.post('/v2/editMonitor') do |env|
          expect(decoded_request_body(env.body)).to eq DEFAULT_PARAMS.merge(stringify_hash(params))
          [200, {'Content-Type' => 'application/json'}, JSON.dump(response)]
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
        stub.post('/v2/deleteMonitor') do |env|
          expect(decoded_request_body(env.body)).to eq DEFAULT_PARAMS.merge(stringify_hash(params))
          [200, {'Content-Type' => 'application/json'}, JSON.dump(response)]
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
        stub.post('/v2/getAlertContacts') do |env|
          expect(decoded_request_body(env.body)).to eq DEFAULT_PARAMS.merge(stringify_hash(params))
          [200, {'Content-Type' => 'application/json'}, JSON.dump(response)]
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
        stub.post('/v2/newAlertContact') do |env|
          expect(decoded_request_body(env.body)).to eq DEFAULT_PARAMS.merge(stringify_hash(params))
          [200, {'Content-Type' => 'application/json'}, JSON.dump(response)]
        end
      end

      expect(client.newAlertContact(params)).to eq response
    end
  end

  describe '#deleteAlertContact' do
    let(:params) do
      {
        :alertContactID => 236
      }
    end

    let(:response) do
      {"stat"=>"ok", "alertcontact"=>{"id"=>"236"}}
    end

    it do
      client = uptime_robot do |stub|
        stub.post('/v2/deleteAlertContact') do |env|
          expect(decoded_request_body(env.body)).to eq DEFAULT_PARAMS.merge(stringify_hash(params))
          [200, {'Content-Type' => 'application/json'}, JSON.dump(response)]
        end
      end

      expect(client.deleteAlertContact(params)).to eq response
    end
  end

  context 'when stat is fail' do
    let(:response) do
      {"stat"=>"fail", "id"=>"101", "message"=>"api_key is wrong"}
    end

    it do
      client = uptime_robot do |stub|
        stub.post('/v2/getAccountDetails') do |env|
          expect(decoded_request_body(env.body)).to eq DEFAULT_PARAMS
          [200, {'Content-Type' => 'application/json'}, JSON.dump(response)]
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
        stub.post('/v2/getAccountDetails') do |env|
          expect(decoded_request_body(env.body)).to eq DEFAULT_PARAMS
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

  context 'when api_key is not passed' do
    it do
      expect {
        uptime_robot(:api_key => nil)
      }.to raise_error(ArgumentError, ':api_key is required')
    end
  end

  context 'when account has no monitors' do
    let(:response) {
      {"stat"=>"fail", "id"=>"212", "message"=>"The account has no monitors"}
    }

    it do
      client = uptime_robot do |stub|
        stub.post('/v2/getAccountDetails') do |env|
          expect(decoded_request_body(env.body)).to eq DEFAULT_PARAMS
          [200, {'Content-Type' => 'application/json'}, JSON.dump(response)]
        end
      end

      expect(client.getAccountDetails).to eq(
        {"stat"=>"fail",
         "id"=>"212",
         "message"=>"The account has no monitors",
         "total"=>"0",
         "monitors"=>[]}
      )
    end

    it do
      client = uptime_robot(:raise_no_monitors_error => true) do |stub|
        stub.post('/v2/getAccountDetails') do |env|
          expect(decoded_request_body(env.body)).to eq DEFAULT_PARAMS
          [200, {'Content-Type' => 'application/json'}, JSON.dump(response)]
        end
      end

      expect {
        client.getAccountDetails
      }.to raise_error(UptimeRobot::Error, '{"stat"=>"fail", "id"=>"212", "message"=>"The account has no monitors"}')
    end
  end
end
