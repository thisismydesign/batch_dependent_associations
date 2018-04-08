class CreateBankAccount < ActiveRecord::Migration[5.1]
  def change
    create_table :bank_accounts do |t|
      t.integer :person_id
    end
  end
end
