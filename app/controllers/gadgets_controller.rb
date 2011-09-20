class GadgetsController < ApplicationController

 #Authentication Part
 before_filter :check_authentication, :only => [:new, :edit]  
   
   def check_authentication  
     unless session[:user]  
       session[:intended_action] = action_name  
       redirect_to :action => :signin_form  
     end  
   end  
   
   def signin 
     session[:user] = AdminUser.authenticate(params[:Gadget][:name], params[:Gadget][:password])
     #session[:user] = AdminUser.authenticate("","")
     redirect_to :action => session[:intended_action]  
   end  
   
   def signout  
     session[:user] = nil  
     redirect_to home_url  
   end  
   
   def signin_form
     
      render(:layout => false)     
   end
 
 
  # GET /gadgets
  # GET /gadgets.xml
  def index
    @gadgets = Gadget.find(
      :all, 
      :order => "updated_at DESC",
      :limit => 20)
    
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
    @gadget = Gadget.find(params[:id])

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
    
    @gadget = Gadget.new
    @allCategories = Category.find(:all, :order => "id").map{|u| [u.name, u.id]}
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @gadget }
    end
  end

  # GET /gadgets/1/edit
  def edit
    @gadget = Gadget.find(params[:id])
     
    @allCategories = Category.find(:all, :order => "id").map{|u| [u.name, u.id]}
        
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
  
  ######## NOTIC PRIVE ZONE ###########
  private
  def get_one_gadget_by_one_category
  # Get the necessary data for right column.
    categories = Category.all
    @category_with_one_gadget = {}
    categories.each do |category|
       gadget = Gadget.find :first, :conditions => "categoryid=" + category.id.to_s 
       @category_with_one_gadget[category] = gadget
    end
  end
  ######## NOTIC PRIVE ZONE ###########
end