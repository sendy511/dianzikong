module GadgetsHelper
  def cleanup_html(src)
    #remove all html tags except the image
    src = src.gsub(/<.*?>/) do |matched|
      p matched
      if matched.downcase.include?("/image") then
        "</image>"
      elsif matched.downcase.include?("image") then
        "<image>"
      else
        ""
      end
    end
    #Remove the image, if there is no end image tag
    if src.downcase.include?("image") && !src.downcase.include?("/image")
      src = src.slice(0, src.downcase.index("<image>"))
    end
    return src
  end
end

