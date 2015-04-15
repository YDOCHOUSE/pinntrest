class PinsController < ApplicationController
  before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:query].present?
      @pins = Pin.search(params[:query])
    else
    @pins = Pin.all.order(created_at: :desc)
    end
  end

  def new
  	@pin = current_user.pins.build
  end

  def create
  	@pin = current_user.pins.build(pin_params)
    if @pin.save
      redirect_to @pin, notice: "Pin Created!"
    else
      render :new
    end
  end

  def show
  end

  def edit
    
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: "Your Pin has been updated!"
    else
      render :edit
    end
  end

  def destroy 
    @pin.destroy
    redirect_to root_path
  end

  def upvote
    @pin.upvote_by current_user
    redirect_to :back
  end

  def tagged
    if params[:tag].present?
      @pins = Pin.tagged_with(params[:tag])
    else
      @pins = Pin.postall
    end   
  end

  def autocomplete
    render json: Pin.search(params[:query], autocomplete: true, limit: 10).map(&:title)
  end

  private

  def pin_params
  	params.require(:pin).permit(:title, :description, :image, :tag_list)
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end
end
