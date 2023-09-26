class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :google_id
      t.string :name
      t.text :token
      t.datetime :expires_at

      t.timestamps
    end
  end
end
