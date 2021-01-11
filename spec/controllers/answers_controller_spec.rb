describe AnswersController do
  describe 'POST #create' do
    let(:question) { create(:question) }
    let(:user_for_login) { create(:user) }

    def create_answer_with_params
      post :create, params: { answer: attributes_for(:answer), question_id: question.id, format: :js }
    end

    def create_answer_with_invalid_params
      post :create, params: { answer: attributes_for(:invalid_answer), question_id: question, format: :js }
    end

    context 'when Unauthenticated' do
      context 'with valid attributes' do
        it 'saves the new answer in the database' do
          expect { create_answer_with_params }.not_to change(question.answers, :count)
        end

        it 'render create template' do
          create_answer_with_params
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'with invalid attributes' do
        it 'sends empty params' do
          # TODO: flash error empty params => check it here
          create_answer_with_invalid_params
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    context 'when Authenticated' do
      before do
        sign_in user_for_login
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
end
