require 'test_helper'

class GadgetsHelperTest < ActionView::TestCase
  test "cleanup_html" do
    org="<div with=\"20\"><img with=\"40\">asdf</img></div>"
    expect = "<img with=\"40\">asdf</img>"
    processed = cleanup_html(org)
    Rails::logger.debug processed
    assert expect == processed
  end
  test "cleanup_html_1" do
    org="abcd<div with=\"20\"><img>asdf"
    expect = "abcd"
    processed = cleanup_html(org)
    Rails::logger.debug processed
    assert expect == processed
  end
end
