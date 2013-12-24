class ApplicationController < ActionController::Base
  protect_from_forgery

  def check_authentication  
    #Store Previous url
    #session[:retur_to] = request.url
    
    store_location

     unless session[:user]  
       redirect_to :action => :signin_form  
     end  
   end  
   
   def signin 
    session[:user] = AdminUser.authenticate(params[:Gadget][:name], params[:Gadget][:password])
    #session[:user] = AdminUser.authenticate("","")
    redirect_back_or_default
    #redirect_to :action => session[:intended_action]  
   end  
   
   def signout  
     session[:user] = nil  
     redirect_to home_url  
   end  
   
   def signin_form
      render(:layout => false)     
   end
 def store_location
   session[:return_to] = if request.get?
     request.url
    else
     request.referer
    end
 end
 
 def redirect_back_or_default
    redirect_to(session.delete(:return_to) || request.refer || default)
 end

end
