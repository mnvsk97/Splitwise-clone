class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.integer :paid_by
      t.integer :amount
      t.integer :paid_for
      t.integer :distribution_type
      t.integer :created_by

      t.timestamps
    end
  end
end
