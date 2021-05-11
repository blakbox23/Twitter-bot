#!/usr/bin/env ruby
require 'dotenv/load'
require 'twitter'
require 'rufus-scheduler'
require_relative './talk.rb'

scheduler = Rufus::Scheduler.new
$client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['consumer_key']
  config.consumer_secret     = ENV['consumer_secret']
  config.access_token        = ENV['access_token']
  config.access_token_secret = ENV['access_token_secret']
end