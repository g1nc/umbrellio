class CreateRates < ActiveRecord::Migration[5.1]
  def change
    create_table :rates do |t|
      t.references :post
      t.integer    :value, null: false
      t.timestamps
    end
  end
end
