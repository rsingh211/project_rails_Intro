class CharactersController < ApplicationController
  def index
    @species = Character.distinct.pluck(:species) # Get unique species for filtering
    @films = Film.all # Get all films for film-based filtering

    @characters = Character.all

    # Apply search
    if params[:search].present?
      @characters = @characters.where("name LIKE ?", "%#{params[:search]}%")
    end

    # Apply species filter
    if params[:species].present?
      @characters = @characters.where(species: params[:species])
    end

    # Apply film filter (Find characters appearing in the selected film)
    if params[:film_id].present?
      @characters = Character.joins(:films).where(films: { id: params[:film_id] })
    end

    # Paginate results (Using Kaminari)
    @characters = @characters.page(params[:page]).per(10)
  end

  def show
    @character = Character.find(params[:id])
    @films = @character.films # Fetch related films
  end
end
