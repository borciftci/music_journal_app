require "prawn"
require "prawn/table"

class MusicLogsController < ApplicationController
  # Only authenticated users can access actions in the controller
  before_action :authenticate_user!
  # loads a musiclog for the specified actions
  before_action :set_music_log, only: [ :show, :edit, :update, :destroy ]

  # GET /music_logs
  # Lists all music logs belonging to current user in descending order
  def index
    @music_logs = current_user.music_logs.order(date: :desc)
    @genre_distribution = current_user.music_logs.group(:genre).count

    if params[:filter].present?
      case params[:filter]
      when "today"
        @music_logs = @music_logs.where(date: Date.today)
      when "last_week"
        @music_logs = @music_logs.where(date: Date.today.beginning_of_week..Date.today.end_of_week)
      when "last_month"
        @music_logs = @music_logs.where(date: Date.today.beginning_of_month..Date.today.end_of_month)
      else
        flash[:alert] = "Invalid filter"
        redirect_to music_logs_path
      end
    end
  end

  def favorite
    @music_log = current_user.music_logs.find(params[:id])

    current_user.music_logs.update_all(favorite: false)

    @music_log.update(favorite: true)
    redirect_to music_logs_path, notice: "Favorite song updated!"

  end

  # GET /music_logs/:id
  def show
    redirect_to music_logs_path
  end

  # GET /music_logs/new
  # Presents a form for creating a new music log
  def new
    @music_log = current_user.music_logs.new
  end

  # POST /music_logs
  def create
    @music_log = current_user.music_logs.new(music_log_params)
    if @music_log.save
      redirect_to music_logs_path, notice: "Music Log was successfully created."
    else
      render :index
    end
  end

  # GET /music_logs/:id/edit
  def edit
  end

  # PATCH/PUT /music_logs/:id
  def update
    if @music_log.update(music_log_params)
      redirect_to music_logs_path, notice: "Music Log was successfully updated."
    else
      render :index
    end
  end

  def export_pdf
    @music_logs = current_user.music_logs.order(date: :desc)

    pdf = Prawn::Document.new
    pdf.text "Music Logs", size: 24, style: :bold, align: :center
    pdf.move_down 20

    # Define table headers
    table_data = [ %w[Song Artist Genre Mood Notes Date] ]

    # Populate table rows
    @music_logs.each do |log|
      table_data << [ log.song_name, log.artist, log.genre, log.mood, log.notes, log.date.to_s ]
    end

    # Draw table with styling
    pdf.table(table_data,
              header: true,
              width: pdf.bounds.width,
              row_colors: %w[F0F0F0 FFFFFF], # Alternating row colors
              cell_style: { border_width: 1, padding: 8, size: 12, align: :left }
    )

    send_data pdf.render,
              filename: "music_logs.pdf",
              type: "application/pdf",
              disposition: "inline"
  end


  # DELETE /music_logs/:id
  def destroy
    if @music_log.destroy
      redirect_to music_logs_path, notice: "Music Log was successfully destroyed."
    else
      redirect_to music_logs_path, alert: "Music Log could not be deleted."
    end
  end



  private

  # Find music log based on ID
  def set_music_log
    @music_log = current_user.music_logs.find(params[:id])
  end

  # Only allowed fields can be set via assignment
  def music_log_params
    params.require(:music_log).permit(:date, :song_name, :artist, :mood, :notes, :status, :genre)
  end
end
