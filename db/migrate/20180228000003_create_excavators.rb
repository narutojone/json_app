class CreateExcavators < ActiveRecord::Migration[5.1]
  def change
    create_table :excavators do |t|
      t.references :ticket
      t.string :company_name, limit: 255
      t.string :street, limit: 255
      t.string :city, limit: 255
      t.string :state, limit: 50
      t.string :zip, limit: 10
      t.boolean :crew_onsite

      t.timestamps
    end
  end
end
