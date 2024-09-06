require "faraday"
require "event_stream_parser"

module Providers
  class Anthropic
    def initialize
      @connection = Faraday.new(url: "https://api.anthropic.com") do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end

      @api_key = Zuno.configuration.anthropic_api_key
      @anthropic_version = Zuno.configuration.anthropic_version
    end

    def chat_completion(messages, model, options = {}, raw_response)
      response = @connection.post("/v1/messages") do |req|
        req.headers["x-api-key"] = @api_key
        req.headers["Content-Type"] = "application/json"
        req.headers["anthropic-version"] = @anthropic_version || "2023-06-01"
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
                parsed_data = JSON.parse(data)
                next unless parsed_data["type"] == "content_block_delta"
                
                content = parsed_data["delta"]["text"]
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
          elsif response.body["content"][0]["type"] == "text"
            OpenStruct.new(content: response.body["content"][0]["text"])
          elsif response.body["content"][0]["type"] == "tool_call"
            OpenStruct.new(content: response.body["content"][0]["text"])
          else
            raise "Unknown response format"
          end
        end
      end
    end
  end
end