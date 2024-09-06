# frozen_string_literal: true

require "providers/openai"
require "providers/anthropic"

module Zuno
  OPENAI_MODELS = %w[gpt-3.5-turbo gpt-4-turbo gpt-4-turbo-preview gpt-4o gpt-4o-mini].freeze
  ANTHROPIC_MODELS = %w[claude-3-5-sonnet-20240620 claude-3-sonnet-20240229 claude-3-opus-20240229 claude-3-haiku-20240307 claude-3-sonnet-20240620-v1:0 claude-3-opus-20240620-v1:0 claude-3-haiku-20240620-v1:0].freeze

  class << self
    def chat(messages:, model: nil, **options)
      model ||= Zuno.configuration.chat_completion_model
      provider = provider_for_model(model)
      raw_response = options.delete(:raw_response) || false

      if options[:stream]
        provider.chat_completion(messages, model, options, raw_response) do |chunk|
          yield chunk if block_given?
        end
      else
        provider.chat_completion(messages, model, options, raw_response)
      end
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
        **ANTHROPIC_MODELS.to_h { |model| [model, Providers::Anthropic.new] },
      }
    end
  end
end
