class PrototypesController < ApplicationController
  before_action :authenticate_user!,except: [:index, :show]
  before_action :set_prototype, only: [:edit, :show, :update, :destroy]
  before_action :move_to_index, only: [:edit]
  
  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end


  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

   def destroy
    prototype.destroy
    redirect_to root_path, notice: 'プロトタイプを削除しました。'
  end
  

  def edit
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype), notice: 'Prototype was successfully updated.'
    else
      render :edit
    end
  end
  

  def show
    @comments = @prototype.comments.includes(:user)
  end

  

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    unless user_signed_in? && current_user == @prototype.user
      redirect_to action: :index
    end
  end
end
