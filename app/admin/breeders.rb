ActiveAdmin.register Breeder do

  filter :name
  filter :city
  filter :state

  index do
    column :id
    column :name do |p|
      auto_link p
    end
    column :city
    column :state
    column :removed_reviews
  end

  form do |f|
    f.inputs 'Name' do
      f.input :name
    end
    f.inputs 'City' do
      f.input :name
    end
    f.inputs 'State' do
      f.input :name
    end
  end

  show do
    attributes_table do
      row :name
      row :city
      row :state
      panel "Dogs" do
        table_for breeder.pups do
          column :dog_name do |p|
            link_to p.pup_name, admin_dog_path(p)
          end
          column :comment do |p|
            p.comment.content
          end
          column :breeder_responsibility
          column :overall_health
          column :trainability
          column :social_behavior
          column :dog_behavior
          column :energy_level
          column :simpatico_rating
          column :hashtag_1
          column :hashtag_2
          column :hashtag_3
          column :created_at
        end
      end
    end
  end
end
