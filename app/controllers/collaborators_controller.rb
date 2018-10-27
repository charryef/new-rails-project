class CollaboratorsController < ApplicationController
  before_action :find_wiki

  def new
    @collaborator = Collaborator.new
  end

  def create
    @user_collaborator = User.find_by_email(params[:collaborator])
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: @user_collaborator.id)

    if @wiki.collaborators.exists?(user_id: @user_collaborator  .id)
      flash[:notice] = "#{@user_collaborator.email} is already a collaborator."
      redirect_to edit_wiki_path(@wiki)
    else
      if @collaborator.save
        flash[:notice] = "#{@user_collaborator.email} was successfully added as a collaborator."
        redirect_to edit_wiki_path(@wiki)
      else
        flash[:alert] = "There was an error adding the collaborator. Please try again."
        redirect_to edit_wiki_path(@wiki)
      end
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])
    @user_collaborator = User.find(@collaborator.user_id)

    if @collaborator.destroy
      flash[:notice] = "#{@user_collaborator.email} was successfully removed as a collaborator."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:alert] = "There was an error deleting the collaborator. Please try again."
      redirect_to edit_wiki_path(@wiki)
    end
  end

  private

  def find_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end
end
