module Providers
  class OpenAI
    def initialize
      @connection = Faraday.new(url: "https://api.openai.com") do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end

      @api_key = Zuno.configuration.openai_api_key
    end

    def chat_completion(messages, model, options = {})
      response = @connection.post("/v1/chat/completions") do |req|
        req.headers["Content-Type"] = "application/json"
        req.headers["Authorization"] = "Bearer #{@api_key}"
        req.body = {
          model: model,
          messages: messages
        }.merge(options).to_json
      end

      { response: response.body["choices"][0]["message"]["content"] }
    end
  end
end
