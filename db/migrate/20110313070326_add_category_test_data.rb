class AddCategoryTestData < ActiveRecord::Migration
  def self.up
    Category.create(:name => "民族产业雄起")
    Category.create(:name => "外国东西")
    Category.create(:name => "Just 电子")    
  end

  def self.down
    Category.delete_all
  end
end
