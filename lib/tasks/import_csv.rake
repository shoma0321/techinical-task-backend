# lib/tasks/import_csv.rake
require 'csv'

namespace :import_csv do
  desc "Import companies data from csv file"
  task companies: :environment do
    file_path = 'db/csv_data/companies.csv' # CSVファイルのパスを指定します

    CSV.foreach(file_path, headers: true) do |row|
      puts "Reading row: #{row.to_hash}" # 追加
      company = Company.find_or_initialize_by(code: row['企業コード'])
      company.assign_attributes(
        status: row['上場状況'],
        name: row['企業名'],
        name_kana: row['企業名（カナ）'],
        postal_code: row['郵便番号'],
        address: row['所在地'],
        representative_name: row['代表者名'],
        representative_name_kana: row['代表者名（カナ）'],
        phone_number: row['電話番号'],
        sales_2020: row['売上（2020）'].gsub(',', '').to_f,
        profit_2020: row['利益（2020）'].gsub(',', '').to_f,
        sales_2021: row['売上（2021）'].gsub(',', '').to_f,
        profit_2021: row['利益（2021）'].gsub(',', '').to_f,
        sales_2022: row['売上（2022）'].gsub(',', '').to_f,
        profit_2022: row['利益（2022）'].gsub(',', '').to_f,
        profit_rate_2020: (row['利益（2020）'].gsub(',', '').to_f / row['売上（2020）'].gsub(',', '').to_f) * 100,
        profit_rate_2021: (row['利益（2021）'].gsub(',', '').to_f / row['売上（2021）'].gsub(',', '').to_f) * 100,
        profit_rate_2022: (row['利益（2022）'].gsub(',', '').to_f / row['売上（2022）'].gsub(',', '').to_f) * 100
      )
      if company.save
        puts "Saved company: #{company.id}" # 追加
      else
        puts "Failed to save company: #{company.errors.full_messages.join(", ")}"
      end
    end
  end
end

