class CreateGadgets < ActiveRecord::Migration
  def self.up
    create_table :gadgets do |t|
      t.string :title
      t.text :content
      t.integer :categoryid
      t.datetime :creatdatetime
      t.datetime :lastupdatetime
      t.string :author

      t.timestamps
    end
  end

  def self.down
    drop_table :gadgets
  end
end
