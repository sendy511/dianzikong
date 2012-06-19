require 'test_helper'

class GadgetsHelperTest < ActionView::TestCase
  test "cleanup_html" do
    org="<div with=\"20\"><image>asdf</image></div>"
    expect = "<image>asdf</image>"
    processed = cleanup_html(org)
    Rails::logger.debug processed
    assert expect == processed
  end
  test "cleanup_html_1" do
    org="abcd<div with=\"20\"><image>asdf"
    expect = "abcd"
    processed = cleanup_html(org)
    Rails::logger.debug processed
    assert expect == processed
  end
end
