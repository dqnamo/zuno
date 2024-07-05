# frozen_string_literal: true

require "providers/openai"
require "providers/anthropic"

module Zuno
  OPENAI_MODELS = %w[gpt-3.5-turbo gpt-4-turbo gpt-4-turbo-preview].freeze
  ANTHROPIC_MODELS = %w[claude-3-5-sonnet-20240620 claude-3-opus-20240229 claude-3-sonnet-20240229 claude-3-haiku-20240307].freeze

  class << self
    def chat(messages:, model:, **options)
      model ||= Zuno.configuration.chat_completion_model
      provider = provider_for_model(model)
      provider.chat_completion(messages, model, options)
    end

    private

    def provider_for_model(model)
      case model
      when *OPENAI_MODELS then Providers::OpenAI.new
      when *ANTHROPIC_MODELS then Providers::Anthropic.new
      else
        raise ArgumentError, "Unsupported model: #{model}"
      end
    end

    def model_providers_mapping
      @model_providers_mapping ||= {
        **OPENAI_MODELS.to_h { |model| [model, Providers::OpenAI.new] },
        **ANTHROPIC_MODELS.to_h { |model| [model, Providers::Anthropic.new] }
      }
    end
  end
end
