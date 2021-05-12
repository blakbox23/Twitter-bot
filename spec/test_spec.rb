require '../bin/main'

client = Twitter::REST::Client.new do |config|
  config.consumer_key = 'Ii5FCHR6jaFsPZaOWKvjNRqV6'
  config.consumer_secret = '4Hh2o83hOAj07gABIVdpBcPdkzezwEsGUNlre4su8JHfm1WFhy'
  config.access_token = '1390589480487227396-JnSwqwzp9e5vatYKXzR3sK2Ot001EK'
  config.access_token_secret = 'mJhVdDcEyGjtE4csbArgUDQX9h5erWhr6L9kBC7M1PFhu'
end

describe TweetCls do
  let(:rubybenefit) { RubyBenefits.new.benefits_of_ruby }
  let(:tweetcls) { TweetCls.new(client).tweet_mthd }
  describe '#tweet_mthd' do
    context 'checks that a tweet comes from the benefits array' do
      it 'returns true if the tweet is from the benefits array' do
        expect(rubybenefit.include?(tweetcls)).to be true
      end
      it 'returns false if the tweet is from the benefits array' do
        expect(rubybenefit.include?('tweetcls')).to be false
      end
    end
  end
end

describe RetweetCls do
  let(:retweetcls) { RetweetCls.new(client).retweet_mthd }

  describe '#retweet_mthd' do
    it 'checks whether the retweet contains links' do
      expect(retweetcls.include?('http')).to be false
    end
  end
end

describe ReplyCls do
  let(:replycls) { ReplyCls.new(client).reply_mthd }
  let(:salutations) { Talker.new.salutations_mthd }
  let(:purpose) { Talker.new.purpose_quiz_mthd }
  let(:opinion) { Talker.new.opinion_quiz_mthd }

  context 'If mention is a salutation' do
    describe '#reply_mthd' do
      it 'returns true if a word is available as a salutation' do
        expect(salutations.include?('hi')).to be true
      end
    end
    describe '#reply_mthd' do
      it 'returns false if a word is available as a salutation' do
        expect(salutations.include?('ni')).to be false
      end
    end
  end
  context 'If mention is a purpose' do
    describe '#reply_mthd' do
      it 'returns true if a word is available in the purpose question' do
        expect(purpose.include?('what do you do')).to be true
      end
    end
    describe '#reply_mthd' do
      it 'returns false if a word is not available as a purpose quiz' do
        expect(purpose.include?('what do you need')).to be false
      end
    end
  end

  context 'If mention is an opinion' do
    describe '#reply_mthd' do
      it 'returns true if a word is available in the opinion quiz' do
        expect(opinion.include?('about ruby')).to be true
      end
    end
    describe '#reply_mthd' do
      it 'returns false if a word is not available as a purpose quiz' do
        expect(opinion.include?('what do you do')).to be false
      end
    end
  end
end
