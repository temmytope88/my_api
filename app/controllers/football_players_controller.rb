require 'time'
require 'date'
class FootballPlayersController < ApplicationController
  before_action :set_football_player, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found


  def static
    render 'orders/staticpage'
  end

  # GET /football_players or /football_players.json
  def index
    @football_players = FootballPlayer.all
    @football_players = Rails.cache.fetch('orders:index', expires_in: 1.hour) do
      FootballPlayer.all
    end
    @pagy, records = pagy(@football_players, items: 20)

    pagination_links = {
      first: pagy_url_for(@pagy, 1),
      prev: pagy_url_for(@pagy, @pagy.prev),
      next: pagy_url_for(@pagy, @pagy.next),
      last: pagy_url_for(@pagy, @pagy.last)
    }
    
    render json: {
      data: ActiveModelSerializers::SerializableResource.new(records, each_serializer: FootballPlayerSerializer),
      pagination: {
        current_page: @pagy.page,
        total_pages: @pagy.pages,
        per_page: @pagy.items,
        total_count: @pagy.count,
        links: pagination_links
      }
    }
  end

  # GET /football_players/1 or /football_players/1.json
  def show
    if @football_player
      render json: @football_player, each_serializer: FootballPlayerSerializer
    else
      render json: {error: "Player record not found"}, status: :not_found
    end
  end

  # GET /football_players/new
  def new
    @football_player = FootballPlayer.new
  end

  # GET /football_players/1/edit
  def edit
  end

  # POST /football_players or /football_players.json
  def create
    if session[:user_id]
      @football_player = FootballPlayer.new(football_player_params)

      respond_to do |format|
        if @football_player.save
          format.html { redirect_to football_player_url(@football_player), notice: "Football player was successfully created." }
          format.json { render :show, status: :created, location: @football_player }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @football_player.errors, status: :unprocessable_entity }
        end
      end
    else
      render json: {error:  "unauthorised", message: "You need to login"}, status: :unauthorized
    end

  end

  # PATCH/PUT /football_players/1 or /football_players/1.json
  def update
    if session[:user_id]
      respond_to do |format|
        if @football_player.update(football_player_params)
          format.html { redirect_to football_player_url(@football_player), notice: "Football player was successfully updated." }
          format.json { render :show, status: :ok, location: @football_player }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @football_player.errors, status: :unprocessable_entity }
        end
      end
    else
      render json: {error:  "unauthorised", message: "You need to login"}, status: :unauthorized
    end
  end

  # DELETE /football_players/1 or /football_players/1.json
  def destroy

    if session[:user_id]

      @football_player.destroy

      respond_to do |format|
        format.html { redirect_to football_players_url, notice: "Football player was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      render json: {error:  "unauthorised", message: "You need to login"}, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_football_player
      @football_player = FootballPlayer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def football_player_params
      #params.fetch(:earthquake, {})
      if params[:football_player][:dob]
        #puts params[:order][:order_date]
        date_string = [:football_player][:dob]
        puts date_string
        date = Date.parse(params[:football_player][:dob])
        puts date
        params[:football_player][:dob] = date
      end
      if params[:football_player][:club_joined]
        date_string = params[:football_player][:club_joined]
        date = Date.parse(date_string)
        puts date
        params[:football_player][:club_joined] = date
      end
      
     # params.fetch(:order, {}).permit(:customer, :employee_id, :order_date, :required_date, :shipped_date, :shipped_id, :freight)
      params.fetch(:football_player, {}).permit(:short_name, :long_name, :player_positions, :overall, :potential,
      :age, :dob, :height, :club_name, :league_name, :club_position, :club_jersey, :club_joined, :nationality,
      :preferred_foot, :pace, :shooting, :passing, :dribbling, :defending, :physical, :crossing, :finishing, 
      :heading, :short_pass, :volleys, :skills, :control)
    end
end
