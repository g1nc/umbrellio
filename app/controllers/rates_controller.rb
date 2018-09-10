class RatesController < ApplicationController
  def create
    builder = RateBuilder.new(
      post_id: params[:post_id],
      value: params[:value]
    )
    builder.inspect!
    render json: builder.save, status: 200
  rescue => exc
    render json: { error: exc.message }, status: 422
  end
end
