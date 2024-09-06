require 'ostruct'
require 'faraday'
require 'byebug'
require 'event_stream_parser'

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

    def chat_completion(messages, model, options = {}, raw_response)
      response = @connection.post("/v1/chat/completions") do |req|
        req.headers["Content-Type"] = "application/json"
        req.headers["Authorization"] = "Bearer #{@api_key}"
        req.body = {
          model: model,
          messages: messages,
        }.merge(options).to_json

        if options[:stream]
          parser = EventStreamParser::Parser.new
          req.options.on_data = Proc.new do |chunk, size|
            if raw_response
              yield chunk
            else
              parser.feed(chunk) do |type, data, id, reconnection_time|
                return if data == "[DONE]"
                content = JSON.parse(data)["choices"][0]["delta"]["content"]
                yield OpenStruct.new(content: content) if content
              end
            end
          end
        end
      end

      unless options[:stream]
        if raw_response
          return response.body
        else
          if response.body["error"]
            raise response.body["error"]["message"]
          elsif response.body["choices"][0]["message"]["content"]
            OpenStruct.new(content: response.body["choices"][0]["message"]["content"])
          elsif response.body["choices"][0]["message"]["tool_calls"]
            OpenStruct.new(tool_calls: response.body["choices"][0]["message"]["tool_calls"])
          end
        end
      end
    end
  end
end
