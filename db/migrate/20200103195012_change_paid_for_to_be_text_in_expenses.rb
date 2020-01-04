class ChangePaidForToBeTextInExpenses < ActiveRecord::Migration[5.2]
  def change
    change_column :expenses, :paid_for, :text
  end
end
