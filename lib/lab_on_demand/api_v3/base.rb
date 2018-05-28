require "json"

module LabOnDemand::ApiV3
  class Base
    attr_reader :api_key,:endpoint
    def initialize(api_key,endpoint)
      @api_key = api_key
      @endpoint = endpoint
    end

    def conn
      @conn ||= Faraday.new(:url => @endpoint)
    end

    def get(*params)
      result = conn.get(*params) do |req|
        req.headers["api_key"] = api_key
      end
      result
    end


    def launch(lab_id,user_id,first_name,last_name,email,options={})
      params = options.merge(
        "labId"=>lab_id,
        "userId"=>user_id,
        "firstName"=>first_name,
        "lastName"=>last_name,
        "email"=>email,
      )
      response = get("launch",params)
      return Launch.new(JSON.parse(response.body))
    end


    def result(lab_instance_id)
      response = get("result",{"labInstanceId"=>lab_instance_id})
      return Result.new(JSON.parse(response.body))
    end

    def catalog()
      response = get("catalog",{})
      catalog = JSON.parse(response.body)
      return {lab_series: catalog["LabSeries"],lab_profiles:catalog["LabProfiles"].map{|p| LabProfile.new(p)},deliver_regions:catalog["DeliveryRegions"]}
      return Result.new(JSON.parse(response.body))
    end

  end
end
