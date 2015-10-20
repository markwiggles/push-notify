class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :access_level
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
