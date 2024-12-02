ActiveAdmin.register Category do
  permit_params :name, :category_image

  # Customizing the index view
  index do
    selectable_column
    id_column
    column :name
    column :category_image do |category|
      image_tag category.category_image.url,style: "width: 50px; height: 50px;" if category.category_image.attached?
    end
    actions
  end

  # Customizing the form
  form do |f|
    f.inputs do
      f.input :name
      f.input :category_image, as: :file
    end
    f.actions
  end

  # Customizing the show view
  show do
    attributes_table do
      row :id
      row :name
      row :category_image do |category|
        image_tag category.category_image.url,style: "width: 50px; height: 50px;" if category.category_image.attached?
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
