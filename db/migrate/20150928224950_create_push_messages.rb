class CreatePushMessages < ActiveRecord::Migration
  def change
    create_table :push_messages do |t|
      t.string :title
      t.string :message
      t.string :response
      t.string :additional

      t.timestamps null: false
    end
  end
end
