describe AnswersController do
  describe 'POST #create' do
    let(:question) { create(:question) }

    def create_answer_with_params
      post :create, params: { answer: attributes_for(:answer), question_id: question.id, format: :js }
    end

    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { create_answer_with_params }.to change(question.answers, :count).by(1)
      end

      it 'render create template' do
        create_answer_with_params
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid attributes' do
      def create_answer_with_invalid_params
        post :create, params: { answer: attributes_for(:invalid_answer), question_id: question, format: :js }
      end

      it 'does not save the question' do
        expect { create_answer_with_invalid_params }.not_to change(Answer, :count)
      end

      it 'sends empty params' do
        # TODO: flash error empty params => check it here

        create_answer_with_invalid_params
        expect(response).to have_http_status(:success)
      end
    end
  end
end
