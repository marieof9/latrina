class LatrinasController < ApplicationController
  before_action :set_lock, only: [:show]
  before_action :set_lock!, only: [:lock, :unlock]

  skip_before_action :verify_authenticity_token, only: [:lock, :unlock]

  def index
    @locks = Lock.all
  end

  def show
  end

  def lock
    @lock.lock
    @lock.save
    render :show
  end

  def unlock
    @lock.unlock
    @lock.save
    render :show
  end

  private

    def set_lock
      @lock = Lock.find_by(name: params[:id])
    end

    def set_lock!
      @lock = Lock.find_or_initialize_by(name: params[:id])
    end
end
