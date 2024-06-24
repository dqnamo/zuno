# frozen_string_literal: true

require_relative "zuno/version"
require_relative "zuno/configuration"
require "zuno/chat"
require "faraday"

module Zuno
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
