module GadgetsHelper
  def cleanup_html(src)
    #remove all html tags except the image
    src = src.gsub(/<.*?>/) do |matched|
      p matched
      if matched.downcase.include?("</img>") || matched.downcase.include?("<img") then
        matched.downcase
      else
        ""
      end
    end
    #Remove the image, if there is no end image tag
    if src.downcase.include?("<img") && !src.downcase.include?("</img>")
      src = src.slice(0, src.downcase.index("<img"))
    end
    return src
  end
end

