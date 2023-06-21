class AddProfitRateToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :profit_rate_2020, :float
    add_column :companies, :profit_rate_2021, :float
    add_column :companies, :profit_rate_2022, :float
  end
end