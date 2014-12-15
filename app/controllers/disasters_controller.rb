# encoding: utf-8

class DisastersController < ApplicationController
  before_action :set_disaster, only: [:show, :edit, :update, :destroy]
  http_basic_authenticate_with name: 'admin', password: 'hogehoge'

  # GET /disasters
  # GET /disasters.json
  def index
    @disasters = Disaster.all.page params[:page]
  end

  def api_check
    Disaster.api_check
    redirect_to disasters_path, notice: 'APIを確認しました'
  end

  def reminder_mail
    Disaster.atuo_send_mail_to_unanswered_users
    redirect_to disasters_path, notice: '未返信者へメールを送信しました'
  end

  # GET /disasters/1
  # GET /disasters/1.json
  def show
  end

  # GET /disasters/new
  def new
    @disaster = Disaster.new
  end

  # GET /disasters/1/edit
  def edit
  end

  # POST /disasters
  # POST /disasters.json
  def create
    @disaster = Disaster.new(disaster_params)

    respond_to do |format|
      if @disaster.save
        User.outside_update
        Confirmation.auto_create(@disaster.id)
        @disaster.send_mail_to_unanswered_users
        format.html { redirect_to @disaster, notice: 'メールを送信しました' }
        format.json { render :show, status: :created, location: @disaster }
      else
        format.html { render :new }
        format.json { render json: @disaster.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disasters/1
  # PATCH/PUT /disasters/1.json
  def update
    respond_to do |format|
      if @disaster.update(disaster_params)
        format.html { redirect_to @disaster, notice: '災害情報を更新しました。' }
        format.json { render :show, status: :ok, location: @disaster }
      else
        format.html { render :edit }
        format.json { render json: @disaster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disasters/1
  # DELETE /disasters/1.json
  def destroy
    @disaster.destroy
    respond_to do |format|
      format.html { redirect_to disasters_url, notice: '災害情報を削除しました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disaster
      @disaster = Disaster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def disaster_params
      params.require(:disaster).permit(:name, :description)
    end
end
