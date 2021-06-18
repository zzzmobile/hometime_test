require 'rails_helper'

RSpec.describe 'Reservations', type: :request do

  describe 'POST /create' do
    subject(:request) { post '/reservations', params: params }

    context 'with invalid params' do
      let(:params) do
        {
          "wrong_key": "wrong-value"
        }
      end

      it 'returns 400' do
        request
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with valid params' do
      context 'when Payload1 format' do
        let(:params) do
          {
              "start_date": "2021-03-12",
              "end_date": "2021-03-16",
              "nights": 4,
              "guests": 4,
              "adults": 2,
              "children": 2,
              "infants": 0,
              "status": "accepted",
              "guest": {
                  "id": 1,
                  "first_name": "Wayne",
                  "last_name": "Woodbridge",
                  "phone": "639123456789",
                  "email": "wayne_woodbridge@bnb.com"
              },
              "currency": "AUD",
              "payout_price": "3800.00",
              "security_price": "500",
              "total_price": "4500.00"
          }
        end

        it 'creates reservation' do
          expect { request }.to change(Reservation, :count).by(1)
        end
      end

      context 'when Payload2 format' do
        let(:params) do
          {
              "reservation": {
                  "start_date": "2021-03-12",
                  "end_date": "2021-03-16",
                  "expected_payout_amount": "3800.00",
                  "guest_details": {
                      "localized_description": "4 guests",
                      "number_of_adults": 2,
                      "number_of_children": 2,
                      "number_of_infants": 0
                  },
                  "guest_email": "wayne_woodbridge@bnb.com",
                  "guest_first_name": "Wayne",
                  "guest_id": 1,
                  "guest_last_name": "Woodbridge",
                  "guest_phone_numbers": [
                      "639123456789",
                      "639123456789"
                  ],
                  "listing_security_price_accurate": "500.00",
                  "host_currency": "AUD",
                  "nights": 4,
                  "number_of_guests": 4,
                  "status_type": "accepted",
                  "total_paid_amount_accurate": "4500.00"
              }
          }
        end

        it 'creates reservation' do
          expect { request }.to change(Reservation, :count).by(1)
        end
      end
    end
  end
end
