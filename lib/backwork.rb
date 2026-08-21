# frozen_string_literal: true

require 'faraday'
require 'faraday/retry'
require 'json'

require_relative 'backwork/version'
require_relative 'backwork/errors'
require_relative 'backwork/client'
require_relative 'backwork/resources/codes'
require_relative 'backwork/resources/policies'
require_relative 'backwork/resources/coverage'
require_relative 'backwork/resources/prior_auth'
require_relative 'backwork/resources/spending'
require_relative 'backwork/resources/webhooks'
require_relative 'backwork/resources/claims'
require_relative 'backwork/resources/compliance'
require_relative 'backwork/resources/drugs'

module Backwork
  class Error < StandardError; end
end
