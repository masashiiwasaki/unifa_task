class PicturesController < ApplicationController
  before_action :require_login

  def index
    @pictures = current_user.pictures.created_order
  end

  def new
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.user = current_user

    if @picture.save
      redirect_to "/"
    else
      @errors = @picture.errors.full_messages
      render '/pictures/new'
    end
  end

  def picture_params
    params.require(:picture).permit(:title, :image)
  end
end
