class SinaHandler
 def self.filter(content)
    correct_encode_content = content.to_s.force_encoding("GB2312").encode("UTF-8")
    content_index = correct_encode_content.index("<div class=\"blkContainerSblkCon")
    sub_content = correct_encode_content.slice(content_index..-1)
    content_end_index = sub_content.index("<!-- publish_helper_end -->")
    sub_content_removed_end = sub_content.slice(0..(content_end_index-1))
    cleaned_html_content = ApplicationController.helpers.cleanup_html(sub_content_removed_end)
    #Rails.logger.debug "32111ttttttttttttttttttttttttttttttttt"
    #Rails.logger.debug "#{b}"
    #Rails.logger.debug "ttt4ttttttttttttttttttttttttttttt"
    return cleaned_html_content
 end
end
