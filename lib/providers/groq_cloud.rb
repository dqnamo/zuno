require 'httparty'
require 'open-uri'
require 'ostruct'

module Providers
  class GroqCloud
    include HTTParty
    base_uri 'https://api.groq.com'

    def initialize
      @api_key = Zuno.configuration.groq_cloud_api_key
      self.class.headers 'Authorization' => "Bearer #{@api_key}"
    end

    def transcribe(audio, language = "en")
      response = self.class.post(
        '/openai/v1/audio/transcriptions',
        multipart: true,
        body: {
          file: audio,
          model: 'whisper-large-v3',
          temperature: 0,
          response_format: 'json',
          language: language
        }
      )

      OpenStruct.new(text: JSON.parse(response.body)["text"])
    end

    def translate(audio)
      response = self.class.post(
        '/openai/v1/audio/translations',
        multipart: true,
        body: {
          file: audio,
          model: 'whisper-large-v3',
          temperature: 0,
          response_format: 'json',
        }
      )

      OpenStruct.new(text: JSON.parse(response.body)["text"])
    end

    def chat_completion(messages, model, options = {})
      response = self.class.post(
        '/openai/v1/chat/completions',
        body: {
          model: model,
          messages: messages
        }.merge(options).to_json
      )
      
      parsed_response = JSON.parse(response.body)

      if parsed_response["error"]
        raise parsed_response["error"]["message"]
      else
        OpenStruct.new(response: parsed_response["choices"][0]["message"]["content"])
      end
    end
  end
end