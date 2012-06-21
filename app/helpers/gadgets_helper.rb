module GadgetsHelper
  def cleanup_html(src)
    src = src.downcase

    #remove all html tags except the image
    src = src.gsub(/<.*?>/) do |matched|
      #Test: print matched
      p matched
      # Keep the img tags
      if matched.include?("</img>") || matched.include?("<img") then
        matched
      else
        ""
      end
    end

    #Remove the image, if there is no end image tag
    indx = src.rindex("<img")
    # No Img tag
    if indx == -1 then
      rtn =  src
    else
      p indx
      afterImgSrc = src.slice(indx, src.length - indx)
      p afterImgSrc
      # Have complete <img /> or <img> </img>
      p /<img[^>]*\/>/ =~ afterImgSrc 
      if /<img[^>]*\/>/ =~ afterImgSrc || afterImgSrc.include?("</img>") then
        rtn = src
      else
        rtn = src.slice(0, indx)
      end
    end

    p "----------------"
    p rtn 
    p "----------------"
    return rtn 
  end
end

