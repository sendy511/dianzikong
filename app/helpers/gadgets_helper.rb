module GadgetsHelper
  def cleanup_html(src)

    #remove all html tags except the image
    src = src.gsub(/<.*?>/) do |matched|
      #Test: print matched
      p matched
      # Keep the img tags
      if matched.downcase.include?("</img>") || matched.downcase.include?("<img") then
        matched
      else
        ""
      end
    end

    #Remove the image, if there is no end image tag
    indx = src.downcase.rindex("<img")
    # No Img tag
    if indx == nil then
      rtn =  src
    else
      p indx
      afterImgSrc = src.slice(indx, src.length - indx)
      p afterImgSrc
      # Have complete <img /> or <img> </img>
      p /<img[^>]*?\/>/ =~ afterImgSrc.downcase 
      if /<img[^>]*?\/>/ =~ afterImgSrc.downcase || afterImgSrc.downcase.include?("</img>") then
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

