require 'pry-byebug'

class ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @lists = current_user.lists
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def edit
    @list = List.find(params[:id])
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    @list.list_type = "private"
    @list.save
    redirect_to list_path(@list.id)
  end

  def update
    @list.update(list_params)
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  private
    def list_params
      params.require(:list).permit(:title)
    end
end