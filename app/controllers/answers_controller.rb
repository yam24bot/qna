class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    if @question.answers.create(answer_params)
    	
    else
    	
	end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
