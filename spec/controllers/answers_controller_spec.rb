describe AnswersController do
  describe 'POST #create' do
    let(:question) { create(:question) }
    let(:user_for_login) { create(:user) }
    let(:valid_attributes) { attributes_for(:answer) }
    let(:invalid_attributes) { attributes_for(:invalid_answer) }

    def post_with(attributes)
      post :create, params: { answer: attributes, question_id: question.id, format: :js }
    end

    context 'when has status unauthorized' do
      context 'with valid attributes' do
        it 'doesn`t save the answer' do
          expect { post_with(valid_attributes) }.not_to change(question.answers, :count)
        end

        it 'has status unauthorized' do
          post_with(invalid_attributes)
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'with invalid attributes' do
        it 'has status unauthorized' do
          # TODO: flash error empty params => check it here
          post_with(invalid_attributes)
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    context 'when has status authorized' do
      before do
        sign_in user_for_login
      end

      context 'with valid attributes' do
        it 'saves the new answer in the database' do
          expect { post_with(valid_attributes) }.to change(question.answers, :count).by(1)
        end

        it 'has status success' do
          post_with(valid_attributes)
          expect(response).to have_http_status(:success)
        end
      end

      context 'with invalid attributes' do
        it 'does not create answer' do
          expect { post_with(invalid_attributes) }.not_to change(Answer, :count)
        end

        it 'has status success' do
          # TODO: flash error empty params => check it here
          post_with(invalid_attributes)
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
