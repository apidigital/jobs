require 'test_helper'

class ForgottenTest < ActionMailer::TestCase
  tests Forgotten
  def test_confirm
    @expected.subject = 'Forgotten#confirm'
    @expected.body    = read_fixture('confirm')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Forgotten.create_confirm(@expected.date).encoded
  end

  def test_sent
    @expected.subject = 'Forgotten#sent'
    @expected.body    = read_fixture('sent')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Forgotten.create_sent(@expected.date).encoded
  end

end
