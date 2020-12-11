require 'spec_helper'

RSpec.describe "PlanPage", type: :request do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "GET /plans/1" do
  	it "render plan1" do
  		get '/plans/1'
  		expect(response).to have_http_status(200)
  	end
  end

end
