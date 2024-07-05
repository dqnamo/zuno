# frozen_string_literal: true

require "providers/groq_cloud"

module Zuno
  class << self
    def transcribe(audio:)
      Providers::GroqCloud.new.transcribe(audio)
    end
  end
end
