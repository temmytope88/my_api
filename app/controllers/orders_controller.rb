require 'time'
require 'date'
class OrdersController < ApplicationController

  before_action :set_order, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  #include Pagy::Frontend
  #include Pagy::Helpers

  def static
    render 'orders/staticpage'
  end

  # GET /earthquakes or /earthquakes.json
  def index
    @orders = Rails.cache.fetch('orders:index', expires_in: 1.hour) do
      Order.all
    end
    @pagy, records = pagy(@orders, items: 20)

    pagination_links = {
      first: pagy_url_for(@pagy, 1),
      prev: pagy_url_for(@pagy, @pagy.prev),
      next: pagy_url_for(@pagy, @pagy.next),
      last: pagy_url_for(@pagy, @pagy.last)
    }
    
    render json: {
      data: ActiveModelSerializers::SerializableResource.new(records, each_serializer: OrderSerializer),
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
    # @earthquake = Earthquake.find(params[:id])
    if @order
      render json: @order, each_serializer: OrderSerializer
    else
      render json: {error: "Order record not found"}, status: :not_found
    end
  end

  # POST /earthquakes or /earthquakes.json
  def create
    if session[:user_id]

      @order = Order.new(order_params)

      respond_to do |format|
        if @order.save
          #format.html { redirect_to earthquake_url(@earthquake), notice: "Earthquake was successfully created." }
          format.json { render :show, status: :created, location: @order}
        else
          #format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @order.errors, status: :unprocessable_entity }
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
        if @order.update(order_params)
          #format.html { redirect_to earthquake_url(@earthquake), notice: "Earthquake was successfully updated." }
          format.json { render :show, status: :ok, location: @order }
        else
          #format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    else
      render json: {error:  "unauthorised", message: "You need to login"}, status: :unauthorized
    end
  end

  # DELETE /earthquakes/1 or /earthquakes/1.json
  def destroy

    if session[:user_id]

      @order.destroy

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
    def set_order
      @order = Order.find(params[:id])
    end

    def record_not_found
      render json: {error: "order record not found"}, status: :not_found
    end
  
    # Only allow a list of trusted parameters through.
    def order_params
      #params.fetch(:earthquake, {})
      if params[:order][:order_date]
        #puts params[:order][:order_date]
        date_string = params[:order][:order_date]
        puts date_string
        date = Date.parse(params[:order][:order_date])
        puts date
        params[:order][:order_date] = date
      end
      if params[:order][:required_date]
        date_string = params[:order][:required_date]
        date = Date.parse(date_string)
        puts date
        params[:order][:required_date] = date
      end
      if params[:order][:shipped_date]
        date_string = params[:order][:shipped_date]
        date = Date.parse(date_string)
        puts date
        params[:order][:shipped_date] = date
      end
      puts "good"
      params.fetch(:order, {}).permit(:customer, :employee_id, :order_date, :required_date, :shipped_date, :shipped_id, :freight)
      
    end
end
