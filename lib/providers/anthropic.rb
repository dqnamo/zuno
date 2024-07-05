require 'ostruct'

module Providers
  class Anthropic
    def initialize
      @connection = Faraday.new(url: "https://api.anthropic.com") do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end

      @api_key = Zuno.configuration.anthropic_api_key
    end

    def chat_completion(messages, model, options = {})
      response = @connection.post("/v1/messages") do |req|
        req.headers["x-api-key"] = @api_key
        req.headers["Content-Type"] = "application/json"
        req.headers["anthropic-version"] = "2023-06-01"
        req.body = {
          model: model,
          messages: messages,
        }.merge(options).to_json
      end
      
      if response.body["error"]
        raise response.body["error"]["message"]
      else
        OpenStruct.new(response: response.body["content"][0]["text"])
      end
    end
  end
end
