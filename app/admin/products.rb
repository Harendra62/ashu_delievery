ActiveAdmin.register Product do
  permit_params :name, :price, :description, :category_id,:product_image

  filter :name
  filter :category

  form do |f|
    f.inputs do
      f.input :name
      f.input :price
      f.input :description
      f.input :product_image,as: :file
      f.input :category, as: :select, collection: Category.all

    end
    f.actions
  end
  show do
    attributes_table do
      row :id
      row :name
      row :price
      row :description
      row :category
      row :product_image do |category|
        image_tag category.product_image.url,style: "width: 50px; height: 50px;" if category.product_image.attached?
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :description
    column :category
    column :product_image do |category|
      image_tag category.product_image.url,style: "width: 50px; height: 50px;" if category.product_image.attached?
    end
    actions
  end
end
