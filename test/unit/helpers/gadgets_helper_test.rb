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

  test "cleaup_html_1" do
  org = %q|<p style="text-align:left;">
    <p>&nbsp;</p>
    <div id="artibody" class="blkContainerSblkCon">
    <div class="img_wrapper">&nbsp;</div>
    <div class="img_wrapper">&nbsp;</div>
    <div class="img_wrapper"><a target="_blank" href="http://slide.tech.sina.com.cn/notebook/slide_5_32294_22305.html">微软发布Surface平板电脑</a></div>
    <div class="img_wrapper"><a target="_blank" href="http://slide.tech.sina.com.cn/notebook/slide_5_32294_22305.html"><img title="微软发布Surface平板电脑 再度挑战苹果" src="http://i1.sinaimg.cn/IT/2012/0619/U5388P2DT20120619072418.jpg" alt="微软发布Surface平板电脑 再度挑战苹果" /></a><span class="img_descr">微软发布Surface平板电脑 再度挑战苹果</span></div>
    </div>
    </p>|
expect= %q|
    &nbsp;
    
    &nbsp;
    &nbsp;
    微软发布Surface平板电脑
    <img title="微软发布Surface平板电脑 再度挑战苹果" src="http://i1.sinaimg.cn/IT/2012/0619/U5388P2DT20120619072418.jpg" alt="微软发布Surface平板电脑 再度挑战苹果" />微软发布Surface平板电脑 再度挑战苹果
    
   |
    processed = cleanup_html(org)
    Rails::logger.debug processed
    Rails::logger.debug expect 
    assert expect == processed
  end
end
