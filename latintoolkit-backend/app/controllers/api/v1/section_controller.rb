class Api::V1::SectionController < Api::V1::BaseController
  # skip_before_action :authenticate_user!, only: :show

  # GET /section/:id
  def show
    section = Section.find(params[:id])
    render json: {
      :lines => section.lines,
      :annotations => section.annotations,
      :identifier => section.identifier,
      :current_user => current_user ? current_user.id: 'guest'
    }
  end

end
