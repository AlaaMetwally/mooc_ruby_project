class CommentsController < ApplicationController
    before_action :find_lecture
    before_action :find_comment, only: [:destroy, :edit, :update, :comment_owner]
    before_action :comment_owner, only: [:destroy, :edit, :update]
    def create
        @comment = @lecture.comments.create(params[:comment].permit(:content))
        if current_user
            @comment.user_id = current_user.id
            @comment.save
            if @comment.save
                redirect_to lecture_path(@lecture)
            else
                render 'new'
            end
        else
            flash[:success] = "You aren't logged in"
            redirect_to @lecture
        end
    end
    def destroy
        @comment.destroy
        redirect_to lecture_path(@lecture)
    end
    def edit
    end

    def update
        if @comment.update(params[:comment].permit(:content))
            redirect_to lecture_path(@lecture)
        else
            render 'edit'
        end
    end
    private
    def find_lecture
        @lecture = Lecture.find(params[:lecture_id])
    end
    def find_comment
        @comment = @lecture.comments.find(params[:id])
    end
    def comment_owner
        unless current_user.id == @comment.user_id
            flash[:notice] = "You shall not pass!"
            redirect_to @lecture
        end
    end
end
