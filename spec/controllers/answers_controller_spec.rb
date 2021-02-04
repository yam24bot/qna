require 'pry'

describe AnswersController do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }
  let(:user_for_login) { create(:user) }
  let(:valid_attributes) { attributes_for(:answer) }
  let(:invalid_attributes) { attributes_for(:invalid_answer) }

  describe 'POST #create' do
    def create_post_with(attributes)
      post :create, params: { answer: attributes, question_id: question.id, format: :js }
    end

    context 'when has status unauthorized' do
      context 'with valid attributes' do
        it 'doesn`t save the answer' do
          expect { create_post_with(valid_attributes) }.not_to change(question.answers, :count)
        end

        it 'has status unauthorized' do
          create_post_with(invalid_attributes)
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'with invalid attributes' do
        it 'has status unauthorized' do
          # TODO: flash error empty params => check it here
          create_post_with(invalid_attributes)
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
          expect { create_post_with(valid_attributes) }.to change(question.answers, :count).by(1)
        end

        it 'has status success' do
          create_post_with(valid_attributes)
          expect(response).to have_http_status(:success)
        end
      end

      context 'with invalid attributes' do
        it 'does not create answer' do
          expect { create_post_with(invalid_attributes) }.not_to change(Answer, :count)
        end

        it 'has status success' do
          # TODO: flash error empty params => check it here
          create_post_with(invalid_attributes)
          expect(response).to have_http_status(:success)
        end
      end
    end
  end

  describe 'PATCH #update' do
    def answers_params_patch
      patch :update, params: { id: answer, question_id: question, answer: attributes_for(:answer), format: :js }
    end

    context 'when User unauthenticated' do
      it 'expected rejection of update' do
        answers_params_patch
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
