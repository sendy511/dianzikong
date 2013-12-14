class ChangeAuthorColumnOfGadget < ActiveRecord::Migration
  def self.up
    change_table :gadgets do |t|
      t.rename :author, :author_id
    end
  end

  def self.down
  end
end
