class CreateDeliveries < ActiveRecord::Migration[8.0]
  def change
    create_table :deliveries do |t|
      t.string :pickup_address, null: false
      t.string :delivery_address, null: false
      t.decimal :weight, null: false
      t.decimal :distance
      t.datetime :scheduled_time, null: false
      t.decimal :cost
      t.string :driver_name

      t.timestamps
    end
  end
end
