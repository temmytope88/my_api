class FootballPlayersController < ApplicationController
  before_action :set_football_player, only: %i[ show edit update destroy ]

  # GET /football_players or /football_players.json
  def index
    @football_players = FootballPlayer.all
  end

  # GET /football_players/1 or /football_players/1.json
  def show
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
  end

  # PATCH/PUT /football_players/1 or /football_players/1.json
  def update
    respond_to do |format|
      if @football_player.update(football_player_params)
        format.html { redirect_to football_player_url(@football_player), notice: "Football player was successfully updated." }
        format.json { render :show, status: :ok, location: @football_player }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @football_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /football_players/1 or /football_players/1.json
  def destroy
    @football_player.destroy

    respond_to do |format|
      format.html { redirect_to football_players_url, notice: "Football player was successfully destroyed." }
      format.json { head :no_content }
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
      params.fetch(:football_player, {}).permit(:)
    end
end
