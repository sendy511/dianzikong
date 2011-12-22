class ApplicationController < ActionController::Base
  protect_from_forgery

  def check_authentication  
     unless session[:user]  
       session[:intended_action] = action_name  
       redirect_to :action => :signin_form  
     end  
   end  
   
   def signin 
     session[:user] = AdminUser.authenticate(params[:Gadget][:name], params[:Gadget][:password])
     #session[:user] = AdminUser.authenticate("","")
     redirect_to :action => session[:intended_action]  
   end  
   
   def signout  
     session[:user] = nil  
     redirect_to home_url  
   end  
   
   def signin_form
      render(:layout => false)     
   end

end
