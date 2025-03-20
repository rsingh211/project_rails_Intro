def index
  if params[:search].present?
    @characters = Character.where("name LIKE ?", "%#{params[:search]}%")
  else
    @characters = Character.all
  end
end
