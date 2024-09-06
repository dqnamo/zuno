module Zuno
  class Configuration
    attr_accessor :chat_completion_model, :openai_api_key, :anthropic_api_key, :anthropic_version

    def initialize
      @chat_completion_model = nil
      @openai_api_key = nil
      @anthropic_api_key = nil
      @anthropic_version = nil
    end
  end
end
