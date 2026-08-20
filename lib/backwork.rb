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

# Deprecated alias for the pre-rename module name, so code written against
# `Verity::Client` keeps running unchanged after the gem became backwork-sdk.
# Remove in the next major version, once no consumer references `Verity`.
Verity = Backwork
