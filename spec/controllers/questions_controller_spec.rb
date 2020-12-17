describe QuestionsController do
  let(:user_for_login) { create(:user) }
  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'expects status 200 the User arrive to #index' do
      expect(response).to have_http_status(:ok)
    end

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'when user GET #show' do
    before do
      get :show, params: { id: question.id }
    end

    it 'expects status 200 the User arrive to #show' do
      expect(response).to have_http_status(:ok)
    end

    it 'assings the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    context 'when User unauthenticated' do
      it 'expected redirect' do
        get :new
        expect(response).to redirect_to user_session_url
      end
    end

    context 'when User authenticated' do
      before do
        sign_in user_for_login
        get :new
      end

      it 'expects status 200 the User arrive to #new' do
        expect(response).to have_http_status(:ok)
      end

      it 'assigns a new Question to @question' do
        expect(assigns(:question)).to be_a_new(Question)
      end

      it 'renders new view' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    context 'when User unauthenticated' do
      it 'expected redirect' do
        get :edit, params: { id: question.id }
        expect(response).to redirect_to user_session_url
      end
    end

    context 'when User authenticated' do
      before do
        sign_in user_for_login
        get :edit, params: { id: question.id }
      end

      it 'expects status 200 the User arrive to #edit' do
        expect(response).to have_http_status(:ok)
      end

      it 'assings the requested question to @question' do
        expect(assigns(:question)).to eq question
      end

      it 'renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'POST #create' do
    context 'when User unauthenticated' do
      it 'expected redirect' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to user_session_url
      end
    end

    context 'when User authenticated' do
      before do
        sign_in user_for_login
      end

      def create_question_with_params
        post :create, params: { question: attributes_for(:question) }
      end

      it 'expects status 302 the User arrive to #create and redirect afrer creating to #show' do
        create_question_with_params
        expect(response).to have_http_status(:found)
      end

      context 'with valid attributes' do
        it 'saves the new question in the database' do
          expect { create_question_with_params }.to change(Question, :count).by(1)
        end

        it 'redirects to show view' do
          create_question_with_params

          expect(response).to redirect_to question_path(assigns(:question))
        end
      end

      context 'with invalid attributes' do
        def create_with_invalid_params
          post :create, params: { question: attributes_for(:invalid_question) }
        end

        it 'expects status :ok the User arrive to #create and redirect after creating to #show' do
          create_with_invalid_params
          expect(response).to have_http_status(:ok)
        end

        it 'does not save the question' do
          expect { create_with_invalid_params }.not_to change(Question, :count)
        end

        it 're-renders new view' do
          create_with_invalid_params
          expect(response).to render_template :new
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'when User unauthenticated' do
      it 'expected redirect' do
        patch :update, params: { question: attributes_for(:question), id: question.id }
        expect(response).to redirect_to user_session_url
      end
    end

    context 'when User authenticated' do
      before do
        sign_in user_for_login
      end

      def question_params_patch
        patch :update, params: { question: attributes_for(:question), id: question.id }
      end

      it 'expected :found when valid attributes' do
        question_params_patch
        expect(response).to have_http_status(:found)
      end

      context 'when valid attributes' do
        it 'assings the requested question to @question' do
          question_params_patch
          expect(assigns(:question)).to eq question
        end

        it 'redirects to the updated question' do
          question_params_patch
          expect(response).to redirect_to question
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when User unregistered' do
      it 'expected redirect' do
        delete :destroy, params: { id: question.id }
        expect(response).to redirect_to user_session_url
      end
    end

    context 'when User authenticated' do
      before do
        sign_in user_for_login
        question
      end

      def delete_question
        delete :destroy, params: { id: question.id }
      end

      it 'expected :found when delete question' do
        delete_question
        expect(response).to have_http_status(:found)
      end

      it 'deletes question' do
        expect { delete_question }.to change(Question, :count).by(-1)
      end

      it 'redirect to index view' do
        delete_question
        expect(response).to redirect_to questions_path
      end
    end
  end
end
