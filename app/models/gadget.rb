class Gadget < ActiveRecord::Base
  has_many :comments
  belongs_to :author
end