class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :guest, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :nights
      t.integer :number_of_guests
      t.integer :number_of_adults
      t.integer :number_of_children
      t.integer :number_of_infants
      t.string :status
      t.string :host_currency
      t.decimal :payout_price, precision: 8, scale: 2
      t.decimal :security_price, precision: 8, scale: 2
      t.decimal :total_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
