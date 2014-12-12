class ConfirmationsController < ApplicationController
  def index_for_admin
    @disaster = disaster
    @confirmations = disaster.confirmations
  end

  def index_for_user
  end

  def edit
  end

  def update
  end

  private

  def disaster
    @disaster ||= Disaster.find params[:disaster_id]
  end
end
