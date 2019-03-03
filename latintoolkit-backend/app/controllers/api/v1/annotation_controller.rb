class Api::V1::AnnotationController < Api::V1::BaseController
  before_action :set_annotation, only: [:update, :destroy]

  # POST /annotation
  def create
    @annotation = Annotation.new(annotation_params)
    @annotation.user_id = current_user.id
    @annotation.username = current_user.username
    if @annotation.save
      render json: { :response => 'success' }
    else
      render json: { :response => 'failure' }
    end
  end

  # PUT /annotation/:id
  def update
    if @annotation.update(content: params[:payload][:value])
      render json: { :response => 'success' }
    else
      render json: { :response => 'failure' }
    end
  end

  # DELETE /annotation/:id
  def destroy
    if @annotation.user_id == current_user.id
      @annotation.destroy
      render json: {}, status: :no_content
    end
  end

  private

    def set_annotation
      @annotation = Annotation.find(params[:id])
    end

    def annotation_params
      params.require(:payload).permit(:line_id, :section_id, :content, :lemma, :start_index)
    end

end
