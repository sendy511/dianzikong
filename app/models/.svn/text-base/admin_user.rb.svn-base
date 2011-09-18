class AdminUser < ActiveRecord::Base  
   
  def self.authenticate(username, password)  
    user = AdminUser.find(:first, :conditions => ["name = ?", username])  
    if user == nil || user.blank? || user.password != password  
      raise "Username or password invalid"  
    end  
    user  
  end  
end