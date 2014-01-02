module GadgetsHelper
  def cleanup_html(src)

    #remove all html tags except the image
    src = src.gsub(/<.*?>/) do |matched|
      #Test: print matched
      #p matched

      # Keep the img tags
      if matched.downcase.include?("</img>") || matched.downcase.include?("<img") then
        matched
      else
        ""
      end
    end

    #remove \n
    src = src.gsub(/\n/, "")

    #Remove the image, if there is no end image tag
    indx = src.downcase.rindex("<img")
    # No Img tag
    if indx == nil then
      rtn =  src
    else
      afterImgSrc = src.slice(indx, src.length - indx)
      # Have complete <img /> or <img> </img>
      if /<img[^>]*?\/>/ =~ afterImgSrc.downcase || afterImgSrc.downcase.include?("</img>") then
        rtn = src
      else
        rtn = src.slice(0, indx)
      end
    end

    #p "----------------"
    #p rtn 
    #p "----------------"
    return rtn 
  end
end

