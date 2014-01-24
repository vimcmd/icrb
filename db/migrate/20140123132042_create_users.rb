class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.integer :filial_id
      t.string :cabinet
      t.string :phone
      t.boolean :admin
      t.string :password_digest
      t.string :remember_token

      t.timestamps
    end
  end
end
