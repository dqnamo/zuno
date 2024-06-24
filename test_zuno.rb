require "zuno"

# Set the configuration
Zuno.configure do |config|
  config.openai_api_key = "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"
end

p Zuno.chat(messages: [{ role: "user", content: "Hello!" }], model: "gpt-3.5-turbo")
