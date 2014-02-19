class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :content
      t.integer :user_id
      t.integer :status_id, null: false, default: 0
      t.string :admin_comment

      t.timestamps
    end
    add_index :problems, [:user_id, :created_at]
  end
end
