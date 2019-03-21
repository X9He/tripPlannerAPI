# spec/requests/trips_spec.rb
require 'rails_helper'

RSpec.describe 'Trips API', type: :request do
  # initialize test data
  let!(:trips) { create_list(:trip, 10) }
  let(:trip_id) { trips.first.id }

  # Test suite for GET /trips
  describe 'GET /trips' do
    # make HTTP get request before each example
    before { get '/trips' }

    it 'returns trips' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /trips/:id
  describe 'GET /trips/:id' do
    before { get "/trips/#{trip_id}" }

    context 'when the record exists' do
      it 'returns the trip' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(trip_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:trip_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Trip/)
      end
    end
  end

  # Test suite for POST /trips
  describe 'POST /trips' do
    # valid payload
    let(:valid_attributes) { { title: 'go to detroit', created_by: '1' } }

    context 'when the request is valid' do
      before { post '/trips', params: valid_attributes }

      it 'creates a trip' do
        expect(json['title']).to eq('go to detroit')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/trips', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /trips/:id
  describe 'PUT /trips/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/trips/#{trip_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /trips/:id
  describe 'DELETE /trips/:id' do
    before { delete "/trips/#{trip_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end