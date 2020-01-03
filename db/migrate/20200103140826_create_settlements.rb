class CreateSettlements < ActiveRecord::Migration[5.2]
  def change
    create_table :settlements do |t|
      t.integer :owed_by
      t.integer :owed_to
      t.integer :amount

      t.timestamps
    end
  end
end
