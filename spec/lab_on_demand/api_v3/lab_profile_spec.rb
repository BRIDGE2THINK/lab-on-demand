require "json"
RSpec.describe LabOnDemand::ApiV3::LabProfile do
  let(:mock_lab_profile){
    JSON.parse('{"Id":1,"Name":"Demo Lab 1","Number":" Module 1","PlatformId":2,"CloudPlatformId":null,"SeriesId":1,"Enabled":true,"ReasonDisabled":null,"DevelopmentStatusId":10,"Description":"A demo lab","Objective":"This is the HTML-formatted objective of the lab","Scenario":" This is the HTML-formatted scenario of the lab","DurationMinutes":360,"ExpectedDurationMinutes":60,"RAM":512,"HasIntegratedContent":true,"ContentVersion":2,"IsExam":false,"LabManualUrl":"http://labondemand.com/LabLabProfile/Manual/1","PremiumPrice":10.00,"BasicPrice":8.00,"Status":1,"Error":null,"ExamPages":[{"Id":23,"LabProfileId":12345,"Name":"Example Lab","SortIndex":0,"Questions":[{"Id":0,"Type":"MultipleChoiceSingleAnswer","Text":"What does LOD offer?","SortIndex":0,"ScoreValue":1,"IsRequired":false,"AnswerExplanation":"LOD offers learning experiences on demand and does not offer cupcakes on demand.","AnswerReferenceUrl":"www.learnondemandsystems.com","Answers":[{"Id":0,"Text":"On demand labs and learning experiences.","IsCorrect":true,"SortIndex":0},{"Id":1,"Text":"Cupcakes","IsCorrect":false,"SortIndex":1}]}]}],"Tags":["Tag1","Tag2"]}')
  }
  let(:lab_profile){ described_class.new(mock_lab_profile) }
  it "correctly assigns raw variables" do
    expect(lab_profile.id).to eq(1)
    expect(lab_profile.name).to eq("Demo Lab 1")
    expect(lab_profile.enabled).to be true
  end

  it "correctly converts enums" do
    expect(lab_profile.development_status).to eq("Complete")
    expect(lab_profile.platform).to eq("Hyper-V")
  end
end
