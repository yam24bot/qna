class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)

      if @answer.errors.present?
        flash[:danger] = @answer.errors.full_messages.last
      else
        flash[:success] = "Answer successfully placed"
      end

    respond_to do |format|
      format.js
    end
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
    @question = @answer.question

    if @answer.errors.present?
      flash[:danger] = @answer.errors.full_messages.last
    else
      flash[:success] = "Answer successfully placed"
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy

    if @answer.errors.present?
      flash[:danger] = @answer.errors.full_messages.last
    else
      flash[:success] = "Answer successfully deleted"
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
