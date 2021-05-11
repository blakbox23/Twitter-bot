#!/usr/bin/env ruby
require 'dotenv/load'
require 'twitter'
require 'rufus-scheduler'
require_relative '../lib/talk.rb'

scheduler = Rufus::Scheduler.new
$client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['consumer_key']
  config.consumer_secret     = ENV['consumer_secret']
  config.access_token        = ENV['access_token']
  config.access_token_secret = ENV['access_token_secret']
end

# RETWEETS
class RetweetCls
    $content_repeat = []
    def retweet_mthd
      $client.search("Coding", result_type: "recent", lang: "en").take(1).each do |tweet|
        username = (tweet.user.screen_name).upcase 
        if !($content_repeat.include? tweet.id ) && (tweet.retweeted_status==false) && !(tweet.text.include? "http") then
          puts "#{username} :  #{tweet.text} : USER-id: #{tweet.user.id}"
          $content_repeat.push(tweet.id)
          puts "retweeted"
           $client.retweet(tweet)
          return $client.retweet(tweet)
        else
          puts "bad retweet"   
        end
      end
    end
  end
  retweet_cls = RetweetCls.new
  
  scheduler.every '2m' do
    retweet_cls.retweet_mthd
  end