describe UptimeRobot::Client do
  describe '#get_account_details' do
    let(:account) do
      {"monitorLimit"=>"100",
       "upMonitors"=>"35",
       "downMonitors"=>"9",
       "pausedMonitors"=>"11"}
     end

    let(:response) do
      {"stat"=>"ok",
       "account"=>account}
    end

    it do
      client = uptime_robot do |stub|
        stub.get('getAccountDetails') do |env|
          expect(env.params).to eq DEFAULT_PARAMS
          [200, {'Content-Type' => 'json'}, JSON.dump(response)]
        end
      end

      expect(client.get_account_details).to eq account
    end
  end
end
