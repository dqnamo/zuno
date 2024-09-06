module Zuno
  class Configuration
    attr_accessor :chat_completion_model, :openai_api_key, :anthropic_api_key, :groq_cloud_api_key

    def initialize
      @chat_completion_model = nil
      @openai_api_key = nil
      @anthropic_api_key = nil
    end
  end
end
