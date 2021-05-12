# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity

class ReplyCls
  attr_accessor :client, :already_replied

  def initialize(client)
    @client = client
    @already_replied = []
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength

  def reply_mthd
    talker = Talker.new
    client.search('@blakbot23', result_type: 'recent').take(1).each do |tweet|
      next if already_replied.include? tweet.id

      tweet_text = tweet.text
      already_replied.push(tweet.id)

      if talker.salutations_mthd.any? { |item| tweet_text.downcase.split.include?(item) }
        client.update(
          "@#{tweet.user.screen_name}  #{talker.multi_salutations_mthd.sample.capitalize} human, I'm a bot",
          in_reply_to_status_id: tweet.id
        )
      elsif talker.multi_salutations_mthd.any? { |item| tweet_text.downcase.include?(item) }
        client.update("@#{tweet.user.screen_name} #{talker.salutations_mthd.sample.capitalize}",
                      in_reply_to_status_id: tweet.id)
      elsif talker.purpose_quiz_mthd.any? { |item| tweet_text.downcase.include?(item) }
        client.update("@#{tweet.user.screen_name} #{talker.purpose_ans_mthd.sample.capitalize}",
                      in_reply_to_status_id: tweet.id)
      elsif talker.opinion_quiz_mthd.any? { |item| tweet_text.downcase.include?(item) }
        client.update("@#{tweet.user.screen_name}  #{talker.opinions.sample.capitalize}",
                      in_reply_to_status_id: tweet.id)
      elsif talker.byes_mthd.any? { |item| tweet_text.downcase.include?(item) }
        client.update("@#{tweet.user.screen_name} #{talker.byes_mthd.sample.capitalize} see you later",
                      in_reply_to_status_id: tweet.id)
      else
        client.update("@#{tweet.user.screen_name} Sorry I didn't get that", in_reply_to_status_id: tweet.id)
      end
    end
  end
end

# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
