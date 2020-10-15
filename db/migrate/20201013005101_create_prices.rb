class CreatePrices < ActiveRecord::Migration[5.1]
  def change
    create_table :prices do |t|
      t.string :name
      t.integer :average
      t.integer :max
      t.integer :min

      t.timestamps
    end
  end
end
