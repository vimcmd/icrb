class AddIndexToInvitesCode < ActiveRecord::Migration
  def change
    add_index :invites, :code, unique: true
  end
end
