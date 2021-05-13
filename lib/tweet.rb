class TweetCls
  attr_reader :client

  def initialize(client)
    @client = client
  end

  def tweet_mthd
    benefits = RubyBenefits.new
    client.update(benefits.benefits_of_ruby.sample.to_s)
    benefits.benefits_of_ruby.sample.to_s
  end
end
