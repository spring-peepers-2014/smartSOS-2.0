class PledgesController < ApplicationController

  def create
    # request = Request.find(params[:request_id])
    # new_request_quantity = request.quantity - pledge_params[:quantity].to_i
    # request.update_attribute(:quantity, new_request_quantity)


    # same_item_pledge = Pledge.where(request_id: pledge_params[:request_id]).where(donor_id: pledge_params[:donor_id])

    # if same_item_pledge
    #   new_pledge_quantity = same_item_pledge.quantity + pledge_params[:quantity].to_i
    #   same_item_pledge.update_attribute(:quantity, new_pledge_quantity)
    #   request.update_attribute(:quantity, new_request_quantity)
    #   redirect_to campaign_path(params[:campaign_id])
    # else
    #   pledge = Pledge.new(quantity: pledge_params[:quantity],
    #                       item_id: pledge_params[:item_id],
    #                       request_id: pledge_params[:request_id],
    #                       donor_id: current_donor.id)

    #   if pledge.save
    #     request.update_attribute(:quantity, new_request_quantity)
    #     redirect_to campaign_path(params[:campaign_id])
    #   else
    #     flash[:error] = pledge.errors_full_messages
    #     redirect_to campaign_path(params[:campaign_id])
    #   end
    end


  end


  private

  def pledge_params
    params.require(:pledge).permit(:quantity, :request_id, :item_id)
  end
end
