RSpec.describe LabOnDemand::ApiV3::Base do
  let(:base_connection) {described_class.new("key","endpoint")}
  context 'at setup' do
    it "assigns the api key correctly" do
      expect(base_connection.api_key).to eq("key")
    end
    it "assigns the api endpoint correctly" do
      expect(base_connection.endpoint).to eq("endpoint")
    end
  end

  context 'connection creation' do
    let(:connection){ base_connection.conn }
    it "returns a faraday connection" do
      expect(connection).to be_a(Faraday::Connection)
    end

    it "uses the correct endpoint" do
      conn = described_class.new("key","https://my_endpoint.com").conn
      expect(conn.url_prefix.to_s).to eq("https://my_endpoint.com/")
    end
  end

  context 'authentication' do

    before do
      allow(base_connection).to receive(:conn) {
        Faraday::Connection.new('http://example.net/') do |builder|
          if block_given?
            yield(builder)
          end
          builder.adapter :test do |stub|
            stub.get('/header-echo') do |env|
              [200, {}, env[:request_headers]]
            end
          end
        end
      }
    end

    it "uses correct header" do
      echo_call = base_connection.get("/header-echo")
      expect(echo_call).to be_a(Faraday::Response)
      expect(echo_call.body["api_key"]).to eq("key")
    end
  end

  context 'webservice calls' do
    let(:live_connection) do
      secrets = Secrets.get
      described_class.new(secrets["api_key"],secrets["endpoint"])
    end

    it "has a launch method" do
      expect(live_connection).to respond_to(:launch)
    end

    it "launch method returns URL" do
      #https://labondemand.com/api/v3/65b2aa20-e9ea-4b73-9a89-71d1be379415/launch?labid=40458&userid=555&firstname=Jane&lastname=Booth&email=jane.booth@aicpa-cima.com
      #=>{"Result"=>1, "Url"=>"https://labondemand.com/console/setup/8408ad81-7e40-4ec4-a8ef-361aaf5c7dcc", "LabInstanceId"=>6707539, "Expires"=>1527508596, "ExpiresTime"=>"/Date(1527508596000)/", "Error"=>nil, "Status"=>1}
      call = live_connection.launch("40458","1337","Stefan","Kahlert","sk@bridge2think.com")
      puts call.to_json
      expect(call).to be_a(LabOnDemand::ApiV3::Launch)
      expect(call.url).to be_a(String)
    end

    it "has a result method" do
      expect(live_connection).to respond_to(:result)
    end

    it "result method returns CompletionStatus" do
      #=>{"LabProfileId"=>40458, "Start"=>1527505697, "StartTime"=>"/Date(1527505697000)/", "End"=>1527506190, "EndTime"=>"/Date(1527506190000)/", "UserId"=>"1337", "ClassId"=>nil, "CompletionStatus"=>4, "Tag"=>nil, "TotalRunTimeSeconds"=>492, "TaskCompletePercent"=>100, "ExamDetails"=>{"ExamPages"=>[], "ExamAnswerResponses"=>[], "TextAnswerResponses"=>[]}, "ExamScore"=>nil, "ExamPassed"=>nil, "ExamMaxPossibleScore"=>nil, "ExamPassingScore"=>nil, "IsExam"=>false, "IpAddress"=>nil, "Country"=>nil, "Region"=>nil, "City"=>nil, "Latitude"=>nil, "Longitude"=>nil, "LabHostId"=>105, "DatacenterId"=>1, "DeliveryRegionId"=>1, "Error"=>nil, "Status"=>1}
      call = live_connection.result("6707522")
      puts call.to_json
      expect(call).to be_a(LabOnDemand::ApiV3::Result)
      expect(call).to respond_to(:completion_status)
    end


    it "can load a list of lab_profiles" do
      call = live_connection.catalog()
      puts call.to_json
      expect(call).to be_a(Hash)
      expect(call[:lab_profiles].first).to be_a(LabOnDemand::ApiV3::LabProfile)
    end
  end



end
