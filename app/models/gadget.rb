class Gadget < ActiveRecord::Base
  has_many :comments
  belongs_to :author
  attr_accessible :title, :content, :categoryid, :creatdatetime, :lastupdatetime, :author_id
end
