require "json"
RSpec.describe LabOnDemand::ApiV3::Result do
  let(:mock_result){
    JSON.parse('{"LabProfileId":1,"Start":1338224609,"End":1338224624,"UserId":"555","ClassId":null,"CompletionStatus":4,"TotalRunTimeSeconds":4168,"TaskCompletePercent":100,"IsExam":false,"ExamPassed":null,"ExamScore":null,"ExamMaxPossibleScore":null,"ExamPassingScore":null,"ExamDetails":{"ExamPages":[{"Id":12345,"LabProfileId":1,"Name":"Example Lab","SortIndex":0,"Questions":[{"Id":0,"Type":"MultipleChoiceSingleAnswer","Text":"What does LOD offer?","SortIndex":0,"ScoreValue":1,"IsRequired":false,"AnswerExplanation":"LOD offers learning experiences on demand and does not offer cupcakes on demand.","AnswerReferenceUrl":"www.learnondemandsystems.com","Answers":[{"Id":0,"Text":"On demand labs and learning experiences.","IsCorrect":true,"SortIndex":0},{"Id":1,"Text":"Cupcakes","IsCorrect":false,"SortIndex":1}]}]}],"ExamAnswerResponses":[0],"TextAnswerResponses":[{"Id":12345,"ResponseText":"Response Text Example","IsCorrect":true,"AnswerId":0}]},"IpAddress":null,"Country":null,"Region":null,"City":null,"Latitude":null,"Longitude":null,"LabHostId":49,"DatacenterId":3,"DeliveryRegionId":2,"Status":1,"Error":null}')
  }
  let(:result){ described_class.new(mock_result) }
  it "correctly assigns raw variables" do
    expect(result.lab_profile_id).to eq(1)
    expect(result.user_id).to eq("555")

  end

  it "correctly converts launch times" do
    expect(result.start_time).to eq(Time.new(2012, 5, 28, 19,03,29, "+02:00"))
    expect(result.end_time).to eq(Time.new(2012, 5, 28, 19,3,44, "+02:00"))
  end
end
