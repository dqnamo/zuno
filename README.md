
Welcome to Zuno! 👋 This Ruby gem provides a simple interface for interacting with AI language models, focusing on OpenAI's GPT models and Anthropic's Claude models.


- Easy-to-use `chat` method for AI interactions
- Support for multiple OpenAI and Anthropic models
- Streaming responses for real-time updates
- Configuration options for API keys and models

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zuno'
```

Then, run:

```bash
bundle install

or install the gem directly:

```bash
gem install zuno
```

## Usage
First, configure the gem with your API keys:

```ruby
Zuno.configure do |config|
  config.openai_api_key = "your_openai_api_key"
  config.anthropic_api_key = "your_anthropic_api_key"
end
```

Then, you can use the chat method to interact with the AI:

```ruby
response = Zuno.chat(messages: [{ role: "user", content: "Hello, AI!" }], model: "gpt-3.5-turbo")
puts response.content
```

For streaming responses:

```ruby
Zuno.chat(messages: [{ role: "user", content: "Count to 3." }], stream: true) do |chunk|
    puts chunk.content
end
```

## Supported Models


## Supported Models

- OpenAI:
  - `gpt-3.5-turbo`
  - `gpt-4o`
  - `gpt-4-turbo`
  - `gpt-4-turbo-preview`
  - `gpt-4`
  - `gpt-4-preview`