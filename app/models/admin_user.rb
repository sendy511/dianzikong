class AdminUser < ActiveRecord::Base  
   
  def self.authenticate(username, password)  
    user = AdminUser.where(:conditions => ["name = ?", username]).first  
    if user == nil || user.blank? || user.password != password  
      raise "Username or password invalid"  
    end  
    user  
  end  
end
