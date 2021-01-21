describe AnswersController do
  describe 'POST #create' do
    let(:question) { create(:question) }
    let(:user_for_login) { create(:user) }

    context 'when has status unauthorized' do
      context 'with valid attributes' do
        subject(:valid_attributes) do
          post :create, params: { answer: attributes_for(:answer), question_id: question.id, format: :js }
        end

        it 'doesn`t save the answer' do
          expect { valid_attributes }.not_to change(question.answers, :count)
        end

        it 'render create template' do
          valid_attributes
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'with invalid attributes' do
        subject(:invalid_attributes) do
          post :create, params: { answer: attributes_for(:invalid_answer), question_id: question, format: :js }
        end

        it 'has status unauthorized' do
          # TODO: flash error empty params => check it here
          invalid_attributes
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    context 'when has status authorized' do
      before do
        sign_in user_for_login
      end

      context 'with valid attributes' do
        subject(:valid_attributes) do
          post :create, params: { answer: attributes_for(:answer), question_id: question.id, format: :js }
        end

        it 'saves the new answer in the database' do
          expect { valid_attributes }.to change(question.answers, :count).by(1)
        end

        it 'render create template' do
          valid_attributes
          expect(response).to have_http_status(:success)
        end
      end

      context 'with invalid attributes' do
        subject(:invalid_attributes) do
          post :create, params: { answer: attributes_for(:invalid_answer), question_id: question, format: :js }
        end

        it 'does not create answer' do
          expect { invalid_attributes }.not_to change(Answer, :count)
        end

        it 'has status success' do
          # TODO: flash error empty params => check it here
          invalid_attributes
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
