<img src="https://www.zunogem.com/assets/simple-b9367a2e7e777c867890fc80a16a0de19675d3acac00bdcb4da76e1a3b8242ed.png" width="200">

> [!CAUTION]
> Not recommended to use in production. Still in development.

# Zuno - AI Toolkit for Ruby

Zuno is a Ruby gem that provides a simple interface for interacting with AI language models, focusing on OpenAI's GPT models and Anthropic's Claude models.

## Features

- Easy-to-use `chat` method for AI interactions
- Support for multiple OpenAI and Anthropic models
- Streaming responses for real-time updates
- Flexible configuration options for API keys and models
- Audio transcription and translation (OpenAI only)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zuno'
```

Then run:

```
bundle install
```

Or install the gem directly:

```
gem install zuno
```

## Usage

### 1. Configuration

First, configure the gem with your API keys:

```ruby
Zuno.configure do |config|
  config.openai_api_key = "your_openai_api_key"
  config.anthropic_api_key = "your_anthropic_api_key"
  config.anthropic_version = "2023-06-01" # Optional, defaults to this version if not set
  config.chat_completion_model = "gpt-3.5-turbo" # Optional, set a default model
end
```

### 2. Basic Chat

Use the `chat` method to interact with the AI:

```ruby
response = Zuno.chat(
  messages: [{ role: "user", content: "Hello, AI!" }],
  model: "gpt-3.5-turbo"
)
puts response.content
```

### 3. Streaming Responses

For real-time updates:

```ruby
Zuno.chat(
  messages: [{ role: "user", content: "Count to 3." }],
  model: "gpt-3.5-turbo",
  stream: true
) do |chunk|
  print chunk.content
end
```

### 4. Raw Responses

To get the raw API response:

```ruby
raw_response = Zuno.chat(
  messages: [{ role: "user", content: "Hello, AI!" }],
  model: "gpt-3.5-turbo",
  raw_response: true
)
puts raw_response
```

## Supported Models

### OpenAI

- gpt-3.5-turbo
- gpt-4
- gpt-4-turbo
- gpt-4-turbo-preview
- gpt-4-preview

### Anthropic

- claude-3-opus-20240229
- claude-3-sonnet-20240229
- claude-3-haiku-20240307
- claude-3-5-sonnet-20240620
- claude-3-5-sonnet-20240607
- claude-3-5-sonnet-20240529
- claude-3-5-sonnet-20240513
- claude-3-5-sonnet-20240424
- claude-3-5-sonnet-20240419

## Contributing

We welcome contributions to Zuno! Please read our [contributing guidelines](CONTRIBUTING.md) for more details.

## License

Zuno is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Version

The current version of Zuno is 0.1.4.

For more information and updates, visit: [https://github.com/dqnamo](https://github.com/dqnamo)
