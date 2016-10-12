class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.text :tag_content
      t.string :tag_type
      
      t.belongs_to :url

      t.timestamps
    end
  end
end
