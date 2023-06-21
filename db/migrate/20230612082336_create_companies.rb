class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :code
      t.string :status
      t.string :name
      t.string :name_kana
      t.string :postal_code
      t.string :address
      t.string :representative_name
      t.string :representative_name_kana
      t.string :phone_number
      t.integer :sales_2022
      t.integer :profit_2022
      t.integer :sales_2021
      t.integer :profit_2021
      t.integer :sales_2020
      t.integer :profit_2020

      t.timestamps
    end
  end
end
