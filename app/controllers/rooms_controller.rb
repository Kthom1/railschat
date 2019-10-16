class RoomsController < ApplicationController
  before_action :find_room_by_id, only: [:show, :edit, :update, :destroy]
  before_action :return_all_rooms, only: [:index, :show]

  def index
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new permitted_parameters

    if @room.save
      flash[:success] = "Room #{@room.name} was successfully created."
      redirect_to rooms_path
    else
      render :new
    end
  end

  def show
    @room_message = RoomMessage.new room: @room
    @room_messages = @room.room_messages.includes(:user)
  end

  def edit
  end

  def update
    if @room.update_attributes(permitted_parameters)
      flash[:success] = "Room #{@room.name} was successfully updated."
      redirect_to rooms_path
    else
      render :new
    end
  end

  def destroy
    @room.destroy
    flash[:success] = "Room #{@room.name} was successfully deleted."
    redirect_to rooms_path
  end

  protected

  def find_room_by_id
    @room = Room.find(params[:id]) if params[:id]
  end

  def return_all_rooms 
    @rooms = Room.all
  end

  def permitted_parameters
    params.require(:room).permit(:name)
  end
end
