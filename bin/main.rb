#!/usr/bin/env ruby

# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/CyclomaticComplexity

require 'dotenv/load'
require 'twitter'
require 'rufus-scheduler'
require_relative '../lib/talk'

scheduler = Rufus::Scheduler.new

client = Twitter::REST::Client.new do |config|
  config.consumer_key = 'C-K'
  config.consumer_secret = 'C-S'
  config.access_token = 'A-T'
  config.access_token_secret = 'A-T-S'
end

# TWEETS
class TweetCls
  def initialize(client)
    @client = client
  end

  def tweet_mthd
    benefits = RubyBenefits.new
    puts 'tweeted'
    @client.update(benefits.benefits_of_ruby.sample.to_s)
    benefits.benefits_of_ruby.sample.to_s
  end
end

tweet_cls = TweetCls.new(client)

# RETWEETS
class RetweetCls
  def initialize(client)
    @client = client
    @content_repeat = []
  end

  def retweet_mthd
    @client.search('Coding', result_type: 'recent', lang: 'en').take(1).each do |tweet|
      username = tweet.user.screen_name.upcase
      if !(@content_repeat.include? tweet.id) && (tweet.retweeted_status == false) && !(tweet.text.include? 'http')
        puts "#{username} :  #{tweet.text} : USER-id: #{tweet.user.id}"
        @content_repeat.push(tweet.id)
        puts 'retweeted'

        @client.retweet(tweet)
        return @client.retweet(tweet)
      else
        puts 'bad retweet'
      end
    end
  end
end
retweet_cls = RetweetCls.new(client)

# REPLY
class ReplyCls
  def initialize(client)
    @client = client
    @already_replied = []
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/BlockLength

  def reply_mthd
    talker = Talker.new
    @client.search('@blakbot23', result_type: 'recent').take(1).each do |tweet|
      # puts tweet.user.screen_name

      next if @already_replied.include? tweet.id

      tweet_text = tweet.text
      puts "replied to: #{tweet.user.screen_name}"

      puts tweet.retweeted_status.text
      @already_replied.push(tweet.id)
      if talker.salutations_mthd.any? { |item| tweet_text.downcase.split.include?(item) }
        puts 'right : #replied to salutation'
        @client.update(
          "@#{tweet.user.screen_name}  #{talker.multi_salutations_mthd.sample.capitalize} human, I'm a bot",
          in_reply_to_status_id: tweet.id
        )
        return @client.update(
          "@#{tweet.user.screen_name}  #{talker.multi_salutations_mthd.sample.capitalize} human, I'm a bot",
          in_reply_to_status_id: tweet.id
        )
      elsif talker.multi_salutations_mthd.any? { |item| tweet_text.downcase.include?(item) }
        @client.update("@#{tweet.user.screen_name} #{talker.salutations_mthd.sample.capitalize}",
                       in_reply_to_status_id: tweet.id)
        return @client.update("@#{tweet.user.screen_name} #{talker.salutations_mthd.sample.capitalize}",
                              in_reply_to_status_id: tweet.id)
        # puts 'right : replied to multi_salutation'
      elsif talker.purpose_quiz_mthd.any? { |item| tweet_text.downcase.include?(item) }
        @client.update("@#{tweet.user.screen_name} #{talker.purpose_ans_mthd.sample.capitalize}",
                       in_reply_to_status_id: tweet.id)
        return @client.update("@#{tweet.user.screen_name} #{talker.purpose_ans_mthd.sample.capitalize}",
                              in_reply_to_status_id: tweet.id)
        # puts 'right : replied to purpose'
      elsif talker.opinion_quiz_mthd.any? { |item| tweet_text.downcase.include?(item) }
        puts 'right : replied to opinion'
        @client.update("@#{tweet.user.screen_name}  #{talker.opinions.sample.capitalize}",
                       in_reply_to_status_id: tweet.id)
        return @client.update("@#{tweet.user.screen_name}  #{talker.opinions.sample.capitalize}",
                              in_reply_to_status_id: tweet.id)
      elsif talker.byes_mthd.any? { |item| tweet_text.downcase.include?(item) }
        puts 'right: replied to thanks/byes'
        @client.update("@#{tweet.user.screen_name} #{talker.byes_mthd.sample.capitalize} see you later",
                       in_reply_to_status_id: tweet.id)
        return @client.update("@#{tweet.user.screen_name} #{talker.byes_mthd.sample.capitalize} see you later",
                              in_reply_to_status_id: tweet.id)
      else
        @client.update("@#{tweet.user.screen_name} Sorry I didn't get that", in_reply_to_status_id: tweet.id)
        puts 'stopped'
        return @client.update("@#{tweet.user.screen_name} Sorry I didn't get that",
                              in_reply_to_status_id: tweet.id)
      end
    end
  end
end
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/BlockLength

reply_cls = ReplyCls.new(client)

scheduler.every '3m' do
  retweet_cls.retweet_mthd
end

scheduler.every '31' do
  reply_cls.reply_mthd
end

scheduler.every '2m' do
  tweet_cls.tweet_mthd
end

# scheduler.join

# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
