require "minitest/autorun"
require_relative "../lib/testzed.rb"

module Testzed
  def test_that_it_has_a_version_number
    refute_nil ::Testzed::VERSION
  end

  def test_that_it_has_a_client
    refute_nil ::Testzed::Client
  end
end
