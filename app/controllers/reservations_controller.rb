class ReservationsController < ApplicationController
  wrap_parameters false

  def create
    guest_attrs = guest_attributes
    if guest_attrs.blank?
      render json: { success: false, message: 'Guest information is missing' }, status: 400
      return
    end

    ActiveRecord::Base.transaction do
      guest = Guest.find_or_create_by!(email: guest_attrs[:email]) do |guest|
        guest.attributes = guest_attrs.except(:id)
      end
      @reservation = guest.reservations.create!(reservation_attributes)
    end

    if @reservation.persisted?
      render json: { success: true }, status: 200
    else
      render json: { success: false, message: @reservation.errors.full_messages }, status: 400
    end
  end

  private

  def guest_attributes
    if params[:reservation].present?
      {
        id: params[:reservation][:guest_id],
        email: params[:reservation][:guest_email],
        first_name: params[:reservation][:guest_first_name],
        last_name: params[:reservation][:guest_last_name],
        phone_numbers: params[:reservation][:guest_phone_numbers]
      }
    elsif params[:guest].present?
      {
        id: params[:guest][:id],
        email: params[:guest][:email],
        first_name: params[:guest][:first_name],
        last_name: params[:guest][:last_name],
        phone_numbers: [params[:guest][:phone]]
      }
    end
  end

  def reservation_attributes
    if params[:reservation].present?
      {
        start_date: params[:reservation][:start_date],
        end_date: params[:reservation][:end_date],
        nights: params[:reservation][:nights],
        number_of_guests: params[:reservation][:number_of_guests],
        number_of_adults: params[:reservation][:guest_details][:number_of_adults],
        number_of_children: params[:reservation][:guest_details][:number_of_children],
        number_of_infants: params[:reservation][:guest_details][:number_of_infants],
        status: params[:reservation][:status_type],
        host_currency: params[:reservation][:host_currency],
        payout_price: params[:reservation][:expected_payout_amount],
        security_price: params[:reservation][:listing_security_price_accurate],
        total_price: params[:reservation][:total_paid_amount_accurate]
      }
    elsif params[:guest].present?
      {
        start_date: params[:start_date],
        end_date: params[:end_date],
        nights: params[:nights],
        number_of_guests: params[:guests],
        number_of_adults: params[:adults],
        number_of_children: params[:children],
        number_of_infants: params[:infants],
        status: params[:status],
        host_currency: params[:currency],
        payout_price: params[:payout_price],
        security_price: params[:security_price],
        total_price: params[:total_price]
      }
    end
  end
end
