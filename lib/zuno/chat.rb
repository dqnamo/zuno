# frozen_string_literal: true

require "providers/openai"
require "providers/anthropic"

module Zuno
  OPENAI_MODELS = %w[gpt-3.5-turbo gpt-4-turbo gpt-4-turbo-preview gpt-4o].freeze
  ANTHROPIC_MODELS = %w[claude-3-5-sonnet-20240620 claude-3-opus-20240229 claude-3-sonnet-20240229 claude-3-haiku-20240307].freeze
  GROQ_CLOUD_MODELS = %w[llama3-8b-8192 llama3-70b-8192 mixtral-8x7b-32768 gemma-7b-it gemma2-9b-it].freeze

  class << self
    def chat(messages:, model: nil, **options)
      model ||= Zuno.configuration.chat_completion_model
      provider = provider_for_model(model)
      provider.chat_completion(messages, model, options)
    end

    private

    def provider_for_model(model)
      case model
      when *OPENAI_MODELS then Providers::OpenAI.new
      when *ANTHROPIC_MODELS then Providers::Anthropic.new
      when *GROQ_CLOUD_MODELS then Providers::GroqCloud.new
      else
        raise ArgumentError, "Unsupported model: #{model}"
      end
    end

    def model_providers_mapping
      @model_providers_mapping ||= {
        **OPENAI_MODELS.to_h { |model| [model, Providers::OpenAI.new] },
        **ANTHROPIC_MODELS.to_h { |model| [model, Providers::Anthropic.new] },
        **GROQ_CLOUD_MODELS.to_h { |model| [model, Providers::GroqCloud.new] }
      }
    end
  end
end
