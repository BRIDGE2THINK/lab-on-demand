require "json"

module LabOnDemand::ApiV3
  class Launch

    RESULT_VALUES={
      "0" => "Error",
      "1" => "Success",
      "2" => "User has too many active labs",
      "3" => "Insufficient host resources",
      "5" => "API integration has too many active labs",
      "6" => "User has a saved instance of this lab",
      "7" => "API integration doesn't have enough available RAM",
      "10" => "User doesn't have enough available RAM",
      "20" => "User's organization has too many active labs",
      "30" => "User's organization doesn't have enough available RAM",
      "40" => "Lab profile has too many active instances",
      "50" => "Lab organization doesn't have enough available RAM",
      "60" => "Lab organization has too many active instances",
      "70" => "Lab series has too many active instances",
      "80" => "Lab series doesn't have enough available RAM",
    }
    attr_accessor :result_raw, :url, :lab_instance_id, :expires, :error

    def initialize(data)
      @result_raw = data["Result"]
      @url = data["Url"]
      @lab_instance_id = data["LabInstanceId"]
      @expires = data["Expires"]
      @error = data["Error"]
    end

    def result
      RESULT_VALUES[result_raw.to_s]
    end

  end
end
