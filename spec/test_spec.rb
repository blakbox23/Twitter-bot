require '../bin/main.rb'

describe TweetCls do
  let (:rubybenefit) {RubyBenefits.new.benefits_of_ruby}
  let (:tweetcls) {TweetCls.new.tweet_mthd}
    describe '#tweet_mthd' do
      context 'checks that a twet comes from the benefits array'do
      it 'returns true if the tweet is from the benefits array' do
        expect(rubybenefit.include? tweetcls).to be true
      end
      it 'returns false if the tweet is from the benefits array' do
        expect(rubybenefit.include? "tweetcls").to be false
      end
    end
  end
end

describe RetweetCls do
    let (:retweetcls) {RetweetCls.new.retweet_mthd}

      describe '#retweet_mthd' do
        it 'checks whether the retweet contains links' do
          expect(retweetcls.include? "http").to be false
        end 
    end
  end

  describe ReplyCls do
    let (:replycls) {ReplyCls.new.reply_mthd}
    let (:salutations) {Talker.new.salutations_mthd}
    let (:purpose) {Talker.new.purpose_quiz_mthd}
    let (:opinion) {Talker.new.opinion_quiz_mthd}

    context 'If mention is a salutation' do
      describe '#reply_mthd' do
        it 'returns true if a word is available as a salutation' do
          expect(salutations.include? "hi").to be true
        end
      end
      describe '#reply_mthd' do
        it 'returns false if a word is available as a salutation' do
          expect(salutations.include? "ni").to be false
        end
      end
    end
    context 'If mention is a purpose' do
        describe '#reply_mthd' do
          it 'returns true if a word is available in the purpose question' do
            expect(purpose.include? "what do you do").to be true
          end
        end
        describe '#reply_mthd' do
          it 'returns false if a word is not available as a purpose quiz' do
            expect(purpose.include? "what do you need").to be false
          end
        end
      end

      context 'If mention is an opinion' do
        describe '#reply_mthd' do
          it 'returns true if a word is available in the opinion quiz' do
            expect(opinion.include? "about ruby").to be true
          end
        end
        describe '#reply_mthd' do
          it 'returns false if a word is not available as a purpose quiz' do
            expect(opinion.include? "what do you do").to be false
          end
        end
      end
      
  end

