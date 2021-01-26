class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)

    respond_to do |format|
      if @answer.persisted?
        format.js { flash.now[:notice] = 'Successfully created' }
      else
        format.js { flash.now[:notice] = 'Error' }
      end
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
