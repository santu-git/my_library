class Api::AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  def index
    @authors = Author.all
  end
  def show
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      render :show, status: :created, location: @author
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  def update
    if @author.update(author_params)
      render :show, status: :ok, location: @author
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @author.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def author_params
      params.require(:author).permit(:first_name, :last_name, :about_author)
    end
end
