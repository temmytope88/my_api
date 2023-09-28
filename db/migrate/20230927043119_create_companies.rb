class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :organization_id, :null => false
      t.string :name, :null => false
      t.string :website, :null => true
      t.string :country, :null => false
      t.string :description, :null => false
      t.integer :founded, :null => false
      t.string :industry, :null => false
      t.string :number_of_employees, :null => false
      

      #Ex:- :null => false

      t.timestamps
    end
  end
end
