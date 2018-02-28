require 'rails_helper'

describe TicketsController do
  let(:ticket) {
    FactoryGirl.create(:ticket)
  }

  describe "GET index" do
    it "renders the template when there are no tickets" do
      get :index
      expect(response.status).to eql(200)
      expect(response).to render_template("tickets/index")
    end

    it "lists tickets" do
      tickets = FactoryGirl.create_list(:ticket, 5)
      get :index
      expect(response.status).to eql(200)
      expect(assigns(:tickets)).to be_present
      expect(assigns(:tickets)[0]).to be_a(Ticket)
    end

    it "paginate tickets" do
      tickets = FactoryGirl.create_list(:ticket, 5)
      per_page = 2
      get :index, params: {per_page: per_page}
      expect(response.status).to eql(200)
      expect(assigns(:tickets)).to be_present
      expect(assigns(:tickets).length).to eql(per_page)
      expect(assigns(:tickets)).to be_respond_to(:total_entries)
    end
  end

  describe "GET show" do
    it "renders the template" do
      get :show, params: {id: ticket.id}
      expect(response.status).to eql(200)
      expect(response).to render_template("tickets/show")
    end

    it "gets the correct ticket" do
      tickets = FactoryGirl.create_list(:ticket, 2)
      ticket = tickets.last
      get :show, params: {id: ticket.id}
      expect(response.status).to eql(200)

      expect(assigns(:ticket)).to be_present
      expect(assigns(:ticket).id).to eql(ticket.id)
    end
  end
end
