class FilmsController < ApplicationController
  def index
    @films = Film.all

    # Filter by Episode Number
    if params[:episode].present?
      @films = @films.where(episode: params[:episode])
    end

    # Paginate results (Using Kaminari)
    @films = @films.page(params[:page]).per(5)
  end

  def show
    @film = Film.find(params[:id])
    @characters = @film.characters  # Fetch all characters that appear in this film
  end
end
