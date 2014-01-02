require 'uri'

class GadgetsController < ApplicationController

 #Authentication Part
 before_filter :check_authentication, :only => [:new, :edit]  
 
  # GET /gadgets
  # GET /gadgets.xml
  def index
    @gadgets = Gadget.order("updated_at DESC").limit(20)
    
     #initial right column data.
    get_one_gadget_by_one_category

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @gadgets }
    end
  end

  # GET /gadgets/1
  # GET /gadgets/1.xml
  def show
    id = params[:id]
    @gadget = Gadget.find(id)
    @next_gadget = Gadget.where("id > "+id).first
    @previous_gadget = Gadget.where("id < "+id).first

    #initial right column data.
    get_one_gadget_by_one_category
     
    #new a comment
    @comment = Comment.new
     
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gadget }
    end
  end

  # GET /gadgets/new
  # GET /gadgets/new.xml
  def new
    
    # Authenticaiton part.
    
    new_objects
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @gadget }
    end
  end

  # GET /gadgets/1/edit
  def edit
    @gadget = Gadget.find(params[:id])
     
    @allCategories = Category.order(:id => :ASC).all.map{|u| [u.name, u.id]}
        
  end

  # POST /gadgets
  # POST /gadgets.xml
  def create
    @gadget = Gadget.new(params[:gadget])
  
    # set the default datetime value.
    @gadget.creatdatetime = DateTime.now
    @gadget.lastupdatetime = DateTime.now

    respond_to do |format|
      if @gadget.save
        format.html { redirect_to(@gadget, :notice => 'Gadget was successfully created.') }
        format.xml  { render :xml => @gadget, :status => :created, :location => @gadget }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @gadget.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /gadgets/1
  # PUT /gadgets/1.xml
  def update
    @gadget = Gadget.find(params[:id])

    isSuccess = @gadget.update_attributes(params[:gadget])  
    @gadget.lastupdatetime = DateTime.now
    @gadget.save
    
    respond_to do |format|
      if  isSuccess
        format.html { redirect_to(@gadget, :notice => 'Gadget was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gadget.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /gadgets/1
  # DELETE /gadgets/1.xml
  def destroy
    @gadget = Gadget.find(params[:id])
    @gadget.destroy

    respond_to do |format|
      format.html { redirect_to(gadgets_url) }
      format.xml  { head :ok }
    end
  end
  
  # Add a comments to the gadget.
  def add_comment
    @gadget = Gadget.find(params[:id])
    @comment = Comment.new(params[:comment])
    
     @comment.gadget_id = @gadget.id
     
     @comment.save!
     
    redirect_to :action => :show, :id => @gadget
  end

  def download_from_other_website
    address = params[:gadget][:address_of_other_website]
    if address != nil then address.chomp!(" ") end
    if address !~ /^#{URI.regexp}$/ then
      raise Exception.new("the address #{address} is not a valid URI")
    end
    retrieved_content = Gadget.retrieve_from_website address
    new_objects
    @gadget.content = retrieved_content
    #logger.debug retrieved_content
  end
  
  ######## NOTIC PRIVE ZONE ###########
  private
  def get_one_gadget_by_one_category
  # Get the necessary data for right column.
    categories = Category.all
    @category_with_one_gadget = {}
    categories.each do |category|
       gadget = Gadget.where("categoryid=" + category.id.to_s).first 
       @category_with_one_gadget[category] = gadget
    end
  end

  # the actual new function
  def new_objects
    @gadget = Gadget.new
    
    @allCategories = Category.order(:id => :asc).all.map{|u| [u.name, u.id]}
  end
  ######## NOTIC PRIVE ZONE ###########
end
