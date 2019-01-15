require 'rails_helper'

# `rspec ./spec/controllers/ideas_controller_spec.rb:5`

RSpec.describe IdeasController, type: :controller do
  describe "#new" do
    it "renders a new template" do
      get(:new)
      expect(response).to(render_template(:new))
    end

    it "sets an instance variable with a new idea" do
      get(:new)

      expect(assigns(:idea)).to(be_a_new(Idea))

    end
  end

  describe "#create" do
    context "with valid parameters" do
      def valid_request
        idea(:create, params: { idea: FactoryBot.attributes_for(:idea) })
      end

      it "creates a new idea" do
        count_before = Idea.count
        valid_request
        count_after = Idea.count
        
        expect(count_after).to eq(count_before + 1)
      end
      
      it "redirects to the show page of that idea" do
        valid_request

        idea = Idea.last
        expect(response).to(redirect_to(idea_url(idea.id)))
      end
    end

    context "with invalid parameters" do
      def invalid_request
        idea(
          :create,
          params: { idea: FactoryBot.attributes_for(:idea, title: nil) }
        )
      end

      it "doesn't create a idea" do
        count_before = Idea.count
        invalid_request
        count_after = Idea.count
        
        expect(count_after).to eq(count_before)
      end
      
      it "renders the new template" do
        invalid_request

        expect(response).to render_template(:new)
      end

      it "assigns an invalid job idea as an instance var." do
        invalid_request

        expect(assigns(:idea)).to be_a(Idea)
        expect(assigns(:idea).valid?).to be(false)
      end
    end
  end
end
