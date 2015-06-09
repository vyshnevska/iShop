require 'test_helper'
require 'pry'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:paid_by_check))
    assert_equal I18n.t('mails.order_notifier.received.subject'), mail.subject
    assert_equal ["dave1@example.org"], mail.to
    assert_equal ["vyshnevska.n@gmail.com"], mail.from
    assert_match /1 x Programming Ruby/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:paid_by_check))
    assert_equal I18n.t('mails.order_notifier.shipped.subject'), mail.subject
    assert_equal ["dave1@example.org"], mail.to
    assert_equal ["vyshnevska.n@gmail.com"], mail.from
    assert_match /1 x Programming Ruby/, mail.body.encoded
  end

end
