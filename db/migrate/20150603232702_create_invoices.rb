class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
    	t.string :title, null: false
    	t.date :due_date, null: false
    	t.text :work_items, null: false
    	t.integer :charge_amount, null: false
      t.timestamps
    end
  end
end
