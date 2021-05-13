class RetweetCls
  attr_accessor :client, :content_repeat

  def initialize(client)
    @client = client
    @content_repeat = []
  end

  def retweet_mthd
    client.search('Coding', result_type: 'recent').take(10).each do |tweet|
      if !(content_repeat.include? tweet.id) && !(tweet.text.include? 'RT') && !(tweet.text.include? 'http')
        content_repeat.push(tweet.id)
        client.retweet(tweet)
      end
    end
  end
end
