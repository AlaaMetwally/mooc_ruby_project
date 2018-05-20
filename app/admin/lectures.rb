require 'pathname'
ActiveAdmin.register Lecture do
    permit_params :content, :upload_file, :user_id, :course_id
        index do
          selectable_column
          id_column
          column :content do |f|
            raw(f.content)
          end
          column "spam" do |f|
            Flag.where(:lecture_id => f.id ,:action => 1 ).count
          end
          column "likes" do |f|
            Lecture.where(:id => f.id).first.cached_votes_total
          end
          column :upload_file do |upload|
            Pathname.new(upload.upload_file.to_s).basename unless upload.upload_file == nil
          end
          column :user 
          column :course 
          column :created_at
          column :updated_at
          actions
      end
        filter :upload_file
        filter :user
        filter :course
        filter :created_at
        filter :updated_at
        form do |f|
          f.inputs do
            f.input :content, as: :html_editor
            f.input :upload_file
            f.input :user
            f.input :course
          end
          f.actions
        end
        show do
          comment = Comment.where(:lecture_id => params[:id])
          count = Comment.where(:lecture_id => params[:id]).count
          attributes_table do
            row :content do |f|
                    raw(f.content)
                 end
            row :upload_file do |upload|
               Pathname.new(upload.upload_file.to_s).basename unless upload.upload_file == nil   
            end
            row :user
            row :course
            row "comments" do
              if comment.exists?
                comment.each do |x|
                  li  x.content 
                  ol User.where(:id => x.user_id).first.name
                end
                nil
              end   
            end                
            row :created_at
            row :updated_at
          end
        end 
    end
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

