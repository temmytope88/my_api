require 'time'
require 'date'
class CompaniesController < ApplicationController

  before_action :set_company, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  #include Pagy::Frontend
  #include Pagy::Helpers

  def static
    render 'companies/staticpage'
  end

  # GET /earthquakes or /earthquakes.json
  def index
    @companies = Rails.cache.fetch('companies:index', expires_in: 1.hour) do
      Company.all
    end
    @pagy, records = pagy(@companies, items: 20)

    pagination_links = {
      first: pagy_url_for(@pagy, 1),
      prev: pagy_url_for(@pagy, @pagy.prev),
      next: pagy_url_for(@pagy, @pagy.next),
      last: pagy_url_for(@pagy, @pagy.last)
    }
    
    render json: {
      data: ActiveModelSerializers::SerializableResource.new(records, each_serializer: CompanySerializer),
      pagination: {
        current_page: @pagy.page,
        total_pages: @pagy.pages,
        per_page: @pagy.items,
        total_count: @pagy.count,
        links: pagination_links
      }
    }
  end

  # GET /earthquakes/1 or /earthquakes/1.json
  def show
    
    if @company
      render json: @company, each_serializer: CompanySerializer
    else
      render json: {error: "Order record not found"}, status: :not_found
    end
  end

  # POST /earthquakes or /earthquakes.json
  def create
    if session[:user_id]

      @company = Company.new(company_params)

      respond_to do |format|
        if @company.save
          #format.html { redirect_to earthquake_url(@earthquake), notice: "Earthquake was successfully created." }
          format.json { render :show, status: :created, location: @company}
        else
          #format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @company.errors, status: :unprocessable_entity }
        end
      end
    else
      render json: {error:  "unauthorised", message: "You need to login"}, status: :unauthorized
    end
  end

  # PATCH/PUT /earthquakes/1 or /earthquakes/1.json
  def update
    if session[:user_id]
      respond_to do |format|
        if @company.update(company_params)
          #format.html { redirect_to earthquake_url(@earthquake), notice: "Earthquake was successfully updated." }
          format.json { render :show, status: :ok, location: @company }
        else
          #format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @company.errors, status: :unprocessable_entity }
        end
      end
    else
      render json: {error:  "unauthorised", message: "You need to login"}, status: :unauthorized
    end
  end

  # DELETE /earthquakes/1 or /earthquakes/1.json
  def destroy

    if session[:user_id]

      @company.destroy

      respond_to do |format|
        #format.html { redirect_to earthquakes_url, notice: "Earthquake was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      render json: {error:  "unauthorised", message: "You need to login"}, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    def record_not_found
      render json: {error: "Company record not found"}, status: :not_found
    end
  
    # Only allow a list of trusted parameters through.
    def company_params
      #params.fetch(:earthquake, {})
      
      if params[:company][:founded]
        date_string = params[:company][:founded]
        date = Date.parse(date_string)
        #puts date
        params[:company][:founded] = date.year
      end
      puts "good"
      params.fetch(:company, {}).permit(:organization_id, :name, :website, :founded, :country, :description, :number_of_employees, :industry )
      
    end
end
