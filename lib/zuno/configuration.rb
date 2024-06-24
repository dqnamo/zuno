module Zuno
  class Configuration
    attr_accessor :chat_completion_model, :openai_api_key, :anthropic_api_key

    def initialize
      @openai_api_key = nil
    end
  end
end
