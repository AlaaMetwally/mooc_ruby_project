ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :profile_picture, :name, :gender, :date_of_birth, :user_type
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :date_of_birth 
    column :gender 
    column :user_type
    column :image do |f|
      image_tag f.profile_picture, class: 'image'
    end
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :user_type
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|

    f.inputs do
      f.input :name
      f.input :email
      f.input :profile_picture
      f.input :gender, :as => :radio, collection: [
        ['Male', 'm', checked: true],
        ['Female', 'f'],
      ]
      f.input :date_of_birth, start_year: 1990
      f.input :user_type, :as => :select, 
      collection: [
        ['Student', :student, selected: true],
        ['Instructor', :instructor],
        ['Admin', :admin]
      ]
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :date_of_birth
      row :gender
      row :user_type
      row :image do |f|
        image_tag f.profile_picture, class: 'image'
      end
      row :created_at
      row :updated_at
      row :email
      row :current_sign_in_at
      row :last_sign_in_at
    end
  end
end
