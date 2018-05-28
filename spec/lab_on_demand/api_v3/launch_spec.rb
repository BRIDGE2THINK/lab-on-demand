require "json"
RSpec.describe LabOnDemand::ApiV3::Launch do
  let(:mock_launch){
    JSON.parse('{
        "Result":1,
        "Url":"https://labondemand.com/console/setup/1b4909d6-0dbe-43db-9ab9-74ee4f913c4e",
        "LabInstanceId":3896477,
        "Expires": 1337977153,
        "Status": 1,
        "Error": null
    }')
  }
  let(:launch){ described_class.new(mock_launch) }
  it "correctly assigns raw variables" do
    expect(launch.result_raw).to eq(1)
    expect(launch.url).to eq("https://labondemand.com/console/setup/1b4909d6-0dbe-43db-9ab9-74ee4f913c4e")
    expect(launch.lab_instance_id).to eq(3896477)
  end

  it "correctly converts enums" do
    expect(launch.result).to eq("Success")
  end
end
