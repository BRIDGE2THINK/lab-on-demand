require "json"

module LabOnDemand::ApiV3
  class LabProfile

    PLATFORMS={
      "1"=> "Virtual Server",
      "2"=> "Hyper-V",
      "3"=> "vSphere",
    }
    DEVELOPMENT_STATUSES={
      "1" => "In Development",
      "5" => "AwaitingVerification",
      "7" => "InVerification",
      "8" => "VerificationFailed",
      "10" => "Complete",
    }
    attr_accessor :id, :name, :number, :platform_id, :cloud_platform_id, :series_id, :enabled,
          :reason_disabled, :development_status_id, :description, :objective, :scenario, :expected_duration_minutes,
          :duration_minutes, :ram, :has_integrated_content, :content_version, :is_exam, :premium_price,
          :basic_price, :exam_pages, :tags

    def initialize(data)
      @id = data["Id"]
      @name = data["Name"]
      @number = data["Number"]
      @platform_id = data["PlatformId"]
      @cloud_platform_id = data["CloudPlatformId"]
      @series_id = data["SeriesId"]
      @enabled = data["Enabled"]
      @reason_disabled = data["ReasonDisabled"]
      @development_status_id = data["DevelopmentStatusId"]
      @description = data["Description"]
      @objective = data["Objective"]
      @scenario = data["Scenario"]
      @expected_duration_minutes = data["ExpectedDurationMinutes"]
      @duration_minutes = data["DurationMinutes"]
      @ram = data["RAM"]
      @has_integrated_content = data["HasIntegratedContent"]
      @content_version = data["ContentVersion"]
      @is_exam = data["IsExam"]
      @premium_price = data["PremiumPrice"]
      @basic_price = data["BasicPrice"]
      @exam_pages = data["Exam Pages"]
      @tags = data["Tags"]
    end

    def platform
      PLATFORMS[platform_id.to_s]
    end
    def development_status
      DEVELOPMENT_STATUSES[development_status_id.to_s]
    end

  end
end
