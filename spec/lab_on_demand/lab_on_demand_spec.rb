RSpec.describe LabOnDemand do
  it "has a version number" do
    expect(LabOnDemand::VERSION).not_to be nil
  end

  it "has defined a secrets file" do
    expect(Secrets.get).not_to be nil
    expect(Secrets.get).to be_a(Hash)
  end

  it "has defined an api key in secrets file" do
    expect(Secrets.get["api_key"]).to be_a(String)
  end
  it "has defined an endpoint in secrets file" do
    expect(Secrets.get["endpoint"]).to be_a(String)
  end

end
