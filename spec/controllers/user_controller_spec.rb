require 'rails_helper'

RSpec.describe UserController, type: :controller do
  let!(:user1) { FactoryBot.create(:user, name: "user1") }

  describe 'CREATE USER' do
    context 'create request with valid params' do
      it 'should create a new user' do
        expect do
          post :create, params: { name: "test" }
        end.to change(User, :count).by(1)
        expect(subject).to respond_with(200)
        user = User.find_by(name: "test")
        expect(user).not_to eq(nil)
      end

      it 'should not create a new user if user with given name already exists' do
        expect do
          post :create, params: { name: "user1" }
        end.to change(User, :count).by(0)
        expect(subject).to respond_with(422)
      end

    end
  end
  describe 'GET USER' do
    context 'return user details for a request with valid params' do
      it 'should return user if a user exists with the given user_id or name' do
      end
      it 'should not return user if a user with the given user_id or name does not exist' do
      end
    end
  end
  describe 'UPDATE USER' do

  end
  describe 'DESTROY USER' do
    context 'destroy request with valid params' do
      it 'should destroy the user if user with given user_id exists' do
        put :destroy, params: { id: user1.id }
        expect(response.status).to eq(200)
        user = User.find_by(name: user1.name)
        expect(user).to equal(nil)
      end
      it 'should destroy the user if user with given user_id does not exist' do
        expect do
          put :destroy, params: { id: 1234 }
        end.to change(User, :count).by(0)
        expect(response).to have_http_status(422)
      end
    end
  end
  describe 'GET USER LIST' do

  end
end
