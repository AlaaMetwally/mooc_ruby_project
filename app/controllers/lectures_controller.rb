class LecturesController < ApplicationController
  before_action :set_lecture, only: [:show, :edit, :update, :destroy, :vote, :spam]
  before_action :authenticate_user!, except: [:index, :show, :vote, :spam]
  respond_to :js, :json, :html
  # GET /lectures
  # GET /lectures.json
  def index
    @lectures = Lecture.page(params[:page])
  end
  def spam
      @lecture = Lecture.find(params[:id])
      check = Flag.where(:user_id => current_user.id,:lecture_id => @lecture.id).first
      if  Flag.exists?(user_id: current_user.id,lecture_id: @lecture.id)
        if check.action == true
          check.update(:action => 'false')
          respond_to do |format|
            format.html { redirect_to lecture_url, notice: 'Lecture was successfully unspammed.' }
            format.json { head :no_content }
          end
        else
          check.update(:action => 'true')
          @user=@lecture.user
          ApplicationMailer.spam_email(@user,@lecture,current_user).deliver_later
          respond_to do |format|
            format.html { redirect_to lecture_url, alert: 'Lecture was successfully spammed.' }
            format.json { head :no_content }
          end
        end
      else
        @user=@lecture.user
        flag = Flag.new(:action => true,:user_id => current_user.id,:lecture_id => @lecture.id)
        flag.save
        ApplicationMailer.spam_email(@user,@lecture,current_user).deliver_later
        respond_to do |format|
          format.html { redirect_to lecture_url, alert: 'Lecture was successfully spammed.' }
          format.json { head :no_content }
        end
      end
      
end
  # GET /lectures/1
  # GET /lectures/1.json
  def show
    @comments = Comment.where(lecture_id: @lecture).order("created_at Desc")
    @course_id = Lecture.find(params[:id]).course_id
    if @course_id == nil
        @course_title=Course.first.title
    else
        @course_title = Course.find(@course_id).title
    end
  end

  # GET /lectures/new
  def new
    @lecture = current_user.lectures.build
    @course_first = Course.first
    @courses = Course.all
  end

  # GET /lectures/1/edit
  def edit
    @courses = Course.all
    @course_first = Course.first
  end

  # POST /lectures
  # POST /lectures.json
  def download
    @lecture = Lecture.find(params[:id])
    extension = @lecture.content.split('.')
    send_file "#{Rails.root}/public/#{@lecture.upload_file.url}",
    :type => "application/#{extension[1]}",:x_sendfile=>true
  end
  def create
    @lecture = current_user.lectures.build(lecture_params)

    respond_to do |format|
      if @lecture.save
        format.html { redirect_to @lecture, notice: 'Lecture was successfully created.' }
        format.json { render :show, status: :created, location: @lecture }
      else
        format.html { render :new }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lectures/1
  # PATCH/PUT /lectures/1.json
  def update
    respond_to do |format|
      if @lecture.update(lecture_params)
        format.html { redirect_to @lecture, notice: 'Lecture was successfully updated.' }
        format.json { render :show, status: :ok, location: @lecture }
      else
        format.html { render :edit }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lectures/1
  # DELETE /lectures/1.json
  def destroy
    @lecture.destroy
    respond_to do |format|
      format.html { redirect_to lectures_url, notice: 'Lecture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
def vote
  if !current_user.liked? @lecture
    @lecture.liked_by current_user
  elsif current_user.liked? @lecture
    @lecture.unliked_by current_user
  end
end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture
      @lecture = Lecture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lecture_params
      params.require(:lecture).permit(:content, :upload_file, :course_id)
    end
end
