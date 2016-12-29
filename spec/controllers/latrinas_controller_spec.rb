require 'rails_helper'

RSpec.describe LatrinasController, type: :controller do

  let(:lock) { create(:lock) }
  let(:params) { {id: lock.name } }
  let(:params_new) { {id: 'foobar' } }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: params
      expect(response).to have_http_status(:success)
    end

    it 'assigns the requested lock as @lock' do
      get :show, params: params
      expect(assigns(:lock)).to eq(lock)
    end

    it 'renders :show' do
      get :show, params: params
      expect(response).to render_template(:show)
    end
  end

  describe 'LOCK #lock' do
    let(:lock) { create(:lock, locked: false) }

    it 'returns http success' do
      process_with_kwargs 'LOCK', :lock, params: params
      expect(response).to have_http_status(:success)
    end

    it 'to lock the lock' do
      process_with_kwargs 'LOCK', :lock, params: params
      lock.reload
      expect(lock.locked?).to be true
    end

    it 'renders :show' do
      process_with_kwargs 'LOCK', :lock, params: params
      expect(response).to render_template(:show)
    end

    it 'creates a new lock if necessary' do
      process_with_kwargs 'LOCK', :lock, params: params_new
      expect(assigns(:lock)).to be_a(Lock)
      expect(assigns(:lock)).to be_persisted
    end
  end

  describe 'UNLOCK #unlock' do
    let(:lock) { create(:lock, locked: true) }

    it 'returns http success' do
      process_with_kwargs 'UNLOCK', :unlock, params: params
      expect(response).to have_http_status(:success)
    end

    it 'to unlock the lock' do
      process_with_kwargs 'UNLOCK', :unlock, params: params
      lock.reload
      expect(lock.locked?).to be false
    end

    it 'renders :show' do
      process_with_kwargs 'UNLOCK', :lock, params: params
      expect(response).to render_template(:show)
    end

    it 'creates a new lock if necessary' do
      process_with_kwargs 'UNLOCK', :lock, params: params_new
      expect(assigns(:lock)).to be_a(Lock)
      expect(assigns(:lock)).to be_persisted
    end
  end

end
