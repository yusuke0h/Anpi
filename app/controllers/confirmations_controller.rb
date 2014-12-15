# encoding: utf-8

class ConfirmationsController < ApplicationController
  http_basic_authenticate_with name: 'admin', password: 'hogehoge', only: [:index_for_admin]
  http_basic_authenticate_with name: 'user', password: 'hogehoge', only: [:index_for_user]

  def index_for_admin
    @disaster = disaster
    @confirmations = disaster.confirmations
  end

  def index_for_user
    @disaster = disaster
    @confirmations = disaster.confirmations
  end

  def edit
    @encrypt_user_id = params[:user_id]
    user_id = decrypt params[:user_id]
    @user = User.find user_id
    @disaster = disaster
    @confirmation = disaster.confirmations.where(user_id: user_id).first
  end

  def update
    user_id = decrypt params[:user_id]
    @user = User.find user_id
    @disaster = disaster
    @confirmation = disaster.confirmations.where(user_id: user_id).first
    if @confirmation.update confirmation_params
      redirect_to disaster_confirmations_edit_path(@disaster, user_id: params[:user_id]), notice: '災害情報を更新しました'
    else
      render :edit
    end
  end

  private

  def disaster
    @disaster ||= Disaster.find params[:disaster_id]
  end

  def confirmation_params
    params.require(:confirmation).permit(:locate, :locate_desc, :safely, :safely_desc, :contacted)
  end

end
