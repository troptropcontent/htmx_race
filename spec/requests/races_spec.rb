require 'rails_helper'

RSpec.describe "Races", type: :request do
  include Devise::Test::IntegrationHelpers
  describe "/races" do
    describe "GET" do
      describe "when the user is not signed in" do
        it "redirects to the sign in page" do
          get "/races"
          expect(response).to redirect_to(new_user_session_path)
        end
      end
      describe "when the user is signed in" do
        let(:user){FactoryBot.create(:user)}
        before { sign_in user }
        it "renders the index template" do
          get "/races"
          expect(response).to have_http_status(:success)
          expect(response).to render_template(:index)
        end

        context "when the user neither own a race nor participates to a race" do
          it "returns an empty state" do
            get "/races"
            expect(response).to have_http_status(:success)
            expect(response.body).to include("You currently are not associated to any race yet")
          end
        end

        context "when the user own a race" do
          let!(:owned_race){FactoryBot.create(:race, owners: [user])}
          let!(:not_owned_race){FactoryBot.create(:race)}
          it "returns only the races that he owns" do
            get "/races"
            expect(response).to have_http_status(:success)
            expect(response.body).to include("id=\"race##{owned_race.id}\"")
            expect(response.body).not_to include("id=\"race##{not_owned_race.id}\"")
          end
        end

        context "when the user is participant to a race" do
          let!(:random_race){FactoryBot.create(:race)}
          let!(:participant){FactoryBot.create(:participant, user: user, race: random_race)}
          it "returns only the races that he participates to" do
            get "/races"
            expect(response).to have_http_status(:success)
            expect(response.body).to include("id=\"race##{random_race.id}\"")
          end
        end

        context "when the user is participant to a race that he also owns" do
          let!(:owned_race){FactoryBot.create(:race, owners: [user])}
          let!(:participant){FactoryBot.create(:participant, user: user, race: owned_race)}
          it "returns race only once" do
            get "/races"
            expect(response).to have_http_status(:success)
            expect(response.body).to include("id=\"race##{owned_race.id}\"")
          end
        end
      end
    end
  end
end
