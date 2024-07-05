# frozen_string_literal: true

require "providers/groq_cloud"

module Zuno
  class << self
    def translate(audio:)
      Providers::GroqCloud.new.translate(audio)
    end
  end
end
