require 'net/http'
require 'sina_handler'

class Gadget < ActiveRecord::Base
  has_many :comments
  belongs_to :author

  attr_accessor :address_of_other_website

  attr_accessible :title, :content, :categoryid, :creatdatetime, :lastupdatetime, :author_id

  def self.retrieve_from_website(uri)
    uriURI = URI(uri)
    response = Net::HTTP.get_response(uriURI)

    @content = SinaHandler.filter(response.body)
  end
end
