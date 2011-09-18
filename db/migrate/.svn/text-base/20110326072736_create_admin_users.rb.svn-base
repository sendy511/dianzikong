class CreateAdminUsers < ActiveRecord::Migration
  def self.up
    create_table :admin_users do |t|
      t.string :name
      t.string :password
      
      t.timestamps
    end
    
  end

  def self.down
    drop_table :adminusers
  end
end
