# frozen_string_literal: true

require "providers/openai"

module Zuno
  OPENAI_MODELS = %w[gpt-3.5-turbo gpt-4-turbo gpt-4-turbo-preview gpt-4o gpt-4o-mini].freeze

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
      else
        raise ArgumentError, "Unsupported model: #{model}"
      end
    end

    def model_providers_mapping
      @model_providers_mapping ||= {
        **OPENAI_MODELS.to_h { |model| [model, Providers::OpenAI.new] },
      }
    end
  end
end
