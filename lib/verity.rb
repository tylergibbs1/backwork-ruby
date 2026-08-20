# frozen_string_literal: true

# Deprecated entry point. The gem was renamed from verity-sdk to backwork-sdk;
# this file keeps `require "verity"` working for consumers that have not moved
# to `require "backwork"` yet. Remove in the next major version.
require_relative "backwork"
