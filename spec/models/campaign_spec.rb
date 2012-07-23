require 'spec_helper'

describe Campaign do
  describe "associations" do
    it{ should belong_to :user }
    it{ should belong_to :category }
    it{ should have_many :pokes }
    it{ should have_many :influencers }
  end

  describe "validations" do
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :description }
    it{ should validate_presence_of :user_id }
    it{ should validate_presence_of :image }
    it{ should validate_presence_of :category }
  end

  describe "Maps integration" do
    let(:campaign) { Campaign.make! }

    it "should throw an error if embed code is wrong" do
      campaign.update_attribute(:map_embed, "wrong")
      campaign.should_not be_valid
      campaign.should have(1).error_on(:map_embed)
    end

    it "should not throw errors when embed code is right" do
      campaign.update_attribute(:map_embed, '<iframe width="425" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://www.google.com/maps?ie=UTF8&amp;hq=&amp;hnear=Laranjeiras,+Rio+de+Janeiro,+Brazil&amp;ll=-22.9333,-43.1869&amp;spn=0.0232,0.038366&amp;t=m&amp;z=15&amp;output=embed"></iframe><br /><small><a href="https://www.google.com/maps?ie=UTF8&amp;hq=&amp;hnear=Laranjeiras,+Rio+de+Janeiro,+Brazil&amp;ll=-22.9333,-43.1869&amp;spn=0.0232,0.038366&amp;t=m&amp;z=15&amp;source=embed" style="color:#0000FF;text-align:left">View Larger Map</a></small>')
      campaign.should be_valid
      campaign.should have(0).error_on(:map_embed)
    end
  end
end
