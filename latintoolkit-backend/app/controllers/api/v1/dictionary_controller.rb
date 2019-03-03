require 'json'

class Api::V1::DictionaryController < Api::V1::BaseController
  # skip_before_action :authenticate_user!, only: [:show]

  # GET /dictionary/:lemma
  def show
    @lemma = params[:lemma]
    @entry = Dictionary.find_by key: @lemma
    if @entry.nil?
      render json: JSON.generate({ error: 'not_found', status: '404', id: nil })
    else
      render json: JSON.generate({ description: @entry['description'], id: @entry['id'] })
    end
  end

end
