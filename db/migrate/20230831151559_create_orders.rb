class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :customer, :null => false
      t.integer :employee_id, :null => false
      t.date :order_date
      t.date :required_date
      t.date :shipped_date
      t.integer :shipped_id, :null => false
      t.float :freight, :null => false
      t.timestamps
    end
  end
end
