require 'app/modules/GenerateTrip'

class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :update, :destroy]

  # GET /trips
  def index
    @trips = Trip.all
    json_response(@trips)
  end

  # POST /trips
  def create
    @trip = Trip.create!(trip_params)
    json_response(@trip, :created)
  end

  # GET /trips/:id
  def show
    json_response(@trip)
  end

  # PUT /trips/:id
  def update
    @trip.update(trip_params)
    head :no_content
  end

  # DELETE /trips/:id
  def destroy
    @trip.destroy
    head :no_content
  end

  private

  def trip_params
    # whitelist params
    params.permit(:title, :created_by)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end
end
