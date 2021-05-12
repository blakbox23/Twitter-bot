#!/usr/bin/env ruby

require 'dotenv'
require 'twitter'
require_relative '../tokens'
require 'rufus-scheduler'
require_relative '../lib/talk'
require_relative '../lib/tweet'
require_relative '../lib/retweet'
require_relative '../lib/reply'

scheduler = Rufus::Scheduler.new

client = Twitter::REST::Client.new do |config|
  config.consumer_key = CONSUMER_KEY
  config.consumer_secret = CONSUMER_SECRET
  config.access_token = ACCESS_TOKEN
  config.access_token_secret = ACCESS_TOKEN_SECRET
end

tweet_cls = TweetCls.new(client)
retweet_cls = RetweetCls.new(client)
reply_cls = ReplyCls.new(client)

scheduler.every '2m' do
  retweet_cls.retweet_mthd
end
scheduler.every '31' do
  reply_cls.reply_mthd
end
scheduler.every '5m' do
  tweet_cls.tweet_mthd
end

scheduler.join
