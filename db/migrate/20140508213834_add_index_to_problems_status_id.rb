class AddIndexToProblemsStatusId < ActiveRecord::Migration
  def change
    add_index :problems, :status_id
  end
end
