describe AnswersController do
  describe 'POST #create' do
    let(:question) { create(:question) }

    context 'with valid attributes' do
      def create_answer_with_params
        post :create, params: { answer: attributes_for(:answer), question_id: question.id }
      end
      it 'saves the new answer in the database' do
        expect { create_answer_with_params }.to change(question.answers, :count).by(1)
      end

      it 'redirects to question show view' do
        create_answer_with_params
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      def create_answer_with_invalid_params
        post :create, params: { answer: attributes_for(:invalid_answer), question_id: question }
      end

      it 'does not save the question' do
        expect { create_answer_with_invalid_params }.not_to change(Answer, :count)
      end

      it 'redirects to question show view' do
        create_answer_with_invalid_params
        expect(response).to redirect_to question_path(question)
      end
    end
  end
end
