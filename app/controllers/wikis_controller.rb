class WikisController < ApplicationController

  def index
    #the policy_scope doesn't work for private wikis
    # @wikis = policy_scope(Wiki)
    if current_user.admin? || current_user.premium?
      @wikis = Wiki.all
    else
      @wikis = Wiki.where(private: false)
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    @user = current_user
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @users = User.all
    @find_wikis = Collaborator.where(wiki_id: @wiki.id)
    @collaborators = User.where(id: @find_wikis.pluck(:user_id))
  end

  def update
     @wiki = Wiki.find(params[:id])
     @wiki.assign_attributes(wiki_params)

     if @wiki.save
       flash[:notice] = "Wiki was updated."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :edit
     end
   end

   def destroy
     @wiki = Wiki.find(params[:id])

     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to wikis_path
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end
   end

   private
   def wiki_params
     params.require(:wiki).permit(:title, :body, :private)
   end

end
