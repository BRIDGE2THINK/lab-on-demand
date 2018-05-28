require "json"

module LabOnDemand::ApiV3
  class Result

    COMPLETION_STATUSES={
      "1" => "Cancelled",
      "2" => "No Show",
      "3" => "Incomplete",
      "4" => "Complete",
      "10" => "Storage Provisioning Failed",
      "20" => "Lab Creation Failed",
      "30" => "Resume Failed",
      "40" => "Save Failed",
      "50" => "Submitted For Grading",
      "60" => "Grading In Progress",
    }
    attr_accessor :lab_profile_id, :start, :end, :user_id, :class_id, :completion_status_code,
                :total_run_time_seconds, :task_complete_percent, :is_exam, :exam_passed,
                :exam_score, :exam_max_possible_score, :exam_passing_score, :ip_address,
                :country, :region, :city, :latitude, :longitude, :lab_host_id, :datacenter_id,
                :delivery_region_id, :examdetails

    def initialize(data)
      @lab_profile_id = data["LabProfileId"]
      @start = data["Start"]
      @end = data["End"]
      @user_id = data["UserId"]
      @class_id = data["ClassId"]
      @completion_status_code = data["CompletionStatus"]
      @total_run_time_seconds = data["TotalRunTimeSeconds"]
      @task_complete_percent = data["TaskCompletePercent"]
      @is_exam = data["IsExam"]
      @exam_passed = data["ExamPassed"]
      @exam_score = data["ExamScore"]
      @exam_max_possible_score = data["ExamMaxPossibleScore"]
      @exam_passing_score = data["ExamPassingScore"]
      @ip_address = data["IpAddress"]
      @country = data["Country"]
      @region = data["Region"]
      @city = data["City"]
      @latitude = data["Latitude"]
      @longitude = data["Longitude"]
      @lab_host_id = data["LabHostId"]
      @datacenter_id = data["DatacenterId"]
      @delivery_region_id = data["DeliveryRegionId"]
      @exam_details = data["Exam Details"]
    end

    def completion_status
      COMPLETION_STATUSES[completion_status_code.to_s]
    end

    def start_time
      Time.at(@start)
    end

    def end_time
      Time.at(@end)
    end

  end
end
