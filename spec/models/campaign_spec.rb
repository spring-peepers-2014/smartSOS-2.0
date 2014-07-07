require 'spec_helper'

describe Campaign do

	let!(:campaign) { create :campaign}
	let!(:donor) { create :donor}

	context "it should belong to organization" do
		it { should belong_to(:organization) }
	end

	context "it should have many requests" do
		it { should have_many(:requests) }
	end

	context "it should have many pledges" do
		it { should have_many(:pledges).through(:requests) }
	end

	context "donor method" do
		it "donors method should return all donors of a campaign" do
			request = Request.create(campaign_id: campaign.id, item_id: 1, quantity: 5)
			pledge = Pledge.create(request_id: request.id, donor_id: donor.id, quantity: 5)
	    expect(campaign.donors).to eq([donor])
	  end
	end

	context "total_requests_price" do
		it "total_requests_price method should return the total price of all requests" do
			item1 = Item.create(asin: "1234", name: "rice", category: "food", img_url: "whatever", price: 250) 
			item2 = Item.create(asin: "17345", name: "bread", category: "food", img_url: "whatever", price: 400) 
			request1 = Request.create(campaign_id: campaign.id, item_id: item1.id, quantity: 1)
			request2 = Request.create(campaign_id: campaign.id, item_id: item2.id, quantity: 1)
	    expect(campaign.total_requests_price).to eq("6.50")
	  end
	end

	context "total_pledges_price" do
		it "total_pledges_price method should return the total price of all pledges" do
			donor1 = create(:donor)
			donor2 = create(:donor)
			item1 = Item.create(asin: "1234", name: "rice", category: "food", img_url: "whatever", price: 250)  
			request1 = Request.create(campaign_id: campaign.id, item_id: item1.id, quantity: 4)
			pledge = Pledge.create(request_id: request1.id, donor_id: donor1.id, quantity: 1)
			pledge = Pledge.create(request_id: request1.id, donor_id: donor2.id, quantity: 1)
	    expect(campaign.total_pledges_price).to eq("5.00")
	  end
	end

	context "percentage_goal_complete" do
  	it "percentage_goal_complete method should return the percentage of received pledges if greater than 0" do
  		donor1 = create(:donor)
  		donor2 = create(:donor)
  		item1 = Item.create(asin: "1234", name: "rice", category: "food", img_url: "whatever", price: 250)  
  		request1 = Request.create(campaign_id: campaign.id, item_id: item1.id, quantity: 4)
  		pledge = Pledge.create(request_id: request1.id, donor_id: donor1.id, quantity: 1)
  		pledge = Pledge.create(request_id: request1.id, donor_id: donor2.id, quantity: 1)
      expect(campaign.percentage_goal_complete).to eq(50)
    end

     it "percentage_goal_complete method should return 0 if no items have been pledged" do
  		donor1 = create(:donor)
  		donor2 = create(:donor)
  		item1 = Item.create(asin: "1234", name: "rice", category: "food", img_url: "whatever", price: 250)  
  		request1 = Request.create(campaign_id: campaign.id, item_id: item1.id, quantity: 4)
      expect(campaign.percentage_goal_complete).to eq(0)
    end
  end


  context "total_request_quantity" do
	  it "total_request_quantity method should return the total number of requests" do
			item1 = Item.create(asin: "1234", name: "rice", category: "food", img_url: "whatever", price: 250)
			item2 = Item.create(asin: "17345", name: "bread", category: "food", img_url: "whatever", price: 400)  
			request1 = Request.create(campaign_id: campaign.id, item_id: item1.id, quantity: 4)
			request2 = Request.create(campaign_id: campaign.id, item_id: item2.id, quantity: 6)
	    expect(campaign.total_request_quantity).to eq(10)
	  end
	end
  
	context "total_pledge_quantity" do
    it "total_pledge_quantity method should return the total number of pledges" do
    	donor1 = create(:donor)
    	donor2 = create(:donor)
    	item1 = Item.create(asin: "1234", name: "rice", category: "food", img_url: "whatever", price: 250)  
    	request1 = Request.create(campaign_id: campaign.id, item_id: item1.id, quantity: 4)
    	pledge = Pledge.create(request_id: request1.id, donor_id: donor1.id, quantity: 1)
    	pledge = Pledge.create(request_id: request1.id, donor_id: donor2.id, quantity: 1)
      expect(campaign.total_pledge_quantity).to eq(2)
    end
  end

end

