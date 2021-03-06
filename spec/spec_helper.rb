ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../../Gemfile", __FILE__)

require "rubygems"
require "bundler"
Bundler.setup(:default, :test)

$:.unshift(File.expand_path("../../lib", __FILE__))

require "rspec/core"
require "fog/brkt"

require File.expand_path(File.join(File.dirname(__FILE__), 'helpers', 'mock_helper'))

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

Excon.ssl_verify_peer = false
Fog.timeout = 600 # wait for no longer than 10 minutes

def compute
  return @compute if @compute

  @compute = Fog::Compute.new(provider: 'brkt')
end
compute # touch compute service to load models & requests classes

def create_computing_cell(options={})
  compute.computing_cells.create({
    :name             => Fog::Brkt::Mock.name,
    :network          => { :cidr_block => "10.0.0.0/16" },
    :provider_options => { :aws_region => "us-west-2" }
  }.merge(options))
end

def delete_computing_cell(cell)
  cell.destroy
  # wait while computing cell will be deleted completely and API will return 404
  # to prevent hitting the limit
  Fog.wait_for { cell.completely_deleted? }
end

def fast_tests?
  ENV["FAST_TESTS"] == "true" || ENV["FAST_TESTS"] == "1"
end

RSpec.configure do |c|
end
