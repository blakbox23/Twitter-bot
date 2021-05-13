class Talker
  def opinion_quiz_mthd
    ['about ruby']
  end

  def opinions
    [
      'Everything in Ruby is an expression even statements',
      'has an option of code embedding ie interpolation',
      'has four level of variables ie global, class, instance & local',
      'is highly object oriented programming language with mixins & metaclasses',
      'has a use of dynamic typing & duck typing'
    ]
  end

  def byes_mthd
    ['thanks', 'thank you', 'bye']
  end

  def salutations_mthd
    %w[hey hello hi howdy]
  end

  def multi_salutations_mthd
    ['how are you', 'how is it going', 'good morning']
  end

  def purpose_quiz_mthd
    ['what do you do', 'who made you', 'what can you do']
  end

  def purpose_ans_mthd
    ["I'm learning Ruby", 'I say random fact about Ruby', 'Ruby']
  end
end

class RubyBenefits
  def benefits_of_ruby
    [
      'Everything in Ruby is an expression even statements',
      'Ruby has an option of code embedding ie interpolation',
      'Ruby has four level of variables ie global, class, instance & local',
      'Ruby is highly object oriented programming language with mixins & metaclasses',
      'Ruby has a use of dynamic typing & duck typing'
    ]
  end
end
