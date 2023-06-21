# app/controllers/api/companies_controller.rb
module Api
    class CompaniesController < ApplicationController
      skip_before_action :verify_authenticity_token
  
      def index
        @companies = Company.all
  
        if params[:name].present?
          @companies = @companies.where('name LIKE ?', "%#{params[:name]}%")
        end
  
        if params[:address].present?
            address_query = params[:address].map { |a| "address LIKE '%#{a}%'" }.join(' OR ')
            @companies = @companies.where(address_query)
        end
  
        if params[:sales].present?
            @companies = @companies.where('sales_2022 >= ?', params[:sales].to_i)
          end
          
        if params[:profit].present?
            @companies = @companies.where('profit_2022 >= ?', params[:profit].to_i)
        end          
  
        render json: @companies
      end
  
      def show
        @company = Company.find(params[:id])
        puts "Found company: #{@company.inspect}"
        render json: @company
      end
  
      def create
        @company = Company.new(company_params)
  
        if @company.save
          render json: @company, status: :created
        else
          render json: @company.errors, status: :unprocessable_entity
        end
      end
  
      def update
        @company = Company.find(params[:id])
  
        if @company.update(company_params)
          render json: @company
        else
          render json: @company.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @company = Company.find(params[:id])
        @company.destroy
  
        render json: { status: 'SUCCESS', message: 'Deleted the company', data: @company }
      end
  
      private
  
      def company_params
        params.require(:company).permit(:code, :name, :status, :name_kana, :postal_code, :address, :representative_name, :representative_name_kana, :phone_number, :sales_2022, :sales_2021, :sales_2020, :profit_2022, :profit_2021, :profit_2020, :memo)
      end 
    end
  end
  