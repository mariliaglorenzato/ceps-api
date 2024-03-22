class ZipcodesController < ApplicationController
  DEFAULT_PER_PAGE = 20

  attr_accessor :zipcodes

  def index
    if permitted_params[:neighbourhood].present? 
        @zipcodes = Zipcode.where("neighbourhood LIKE ?", "%#{permitted_params[:neighbourhood]}%")
    else 
      @zipcodes = Zipcode.where(permitted_params)
    end

    render json: { data: paginated_collection, meta: }
  end

  private

  def permitted_params
    params.permit(:city, :neighbourhood, :zipcode)
  end
end