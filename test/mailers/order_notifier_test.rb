require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal I18n.t('mails.order_notifier.received.subject'), mail.subject
    assert_equal ["dave1@example.org"], mail.to
    assert_equal ["vyshnevska.n@gmail.com"], mail.from
    assert_match /1 x Programming Ruby/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal I18n.t('mails.order_notifier.shipped.subject'), mail.subject
    assert_equal ["dave1@example.org"], mail.to
    assert_equal ["vyshnevska.n@gmail.com"], mail.from
    assert_match /<td>1&times;<\/td>\s*<td>Programming Ruby<\/td>/, mail.body.encoded
  end

end
