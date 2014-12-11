class DisastersController < ApplicationController
  def index
    @disasters = Disaster.all
  end

  def new
    @disaster = Disaster.new
  end

  def create
    @disaster = Disaster.new disaster_params
    if @disaster.save
      redirect_to disasters
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

private

  def disaster_params
    params.require(:disaster).permit(:name, :description)
  end

end
