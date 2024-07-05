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
  end
end