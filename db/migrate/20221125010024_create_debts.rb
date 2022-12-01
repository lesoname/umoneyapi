class CreateDebts < ActiveRecord::Migration[7.0]
  def change
    create_table :debts do |t|
      t.string :description
      t.string :category
      t.decimal :price
      t.datetime :date
      t.boolean :paid

      t.timestamps
    end
  end
end
