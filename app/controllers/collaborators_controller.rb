class CollaboratorsController < ApplicationController
  before_action :find_wiki

  def new
    @collaborator = Collaborator.new
  end

  def create
    @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: params[:user_id])

    if @collaborator.save
      flash[:notice] = "Collaborator was successfully added."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:alert] = "Error occured. Please try again."
      redirect_to edit_wiki_path(@wiki)
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator was successfully removed."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:alert] = "Error occured. Please try again."
      redirect_to edit_wiki_path(@wiki)
    end
  end

  private

  def find_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end
end
