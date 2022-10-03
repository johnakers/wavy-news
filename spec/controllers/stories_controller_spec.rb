# frozen_string_literal: true

require 'rails_helper'

# Spec for StoriesController
RSpec.describe StoriesController, type: :controller do
  describe '#index' do
    it 'renders the asssociated template' do
      get :index

      expect(response).to render_template('index')
    end
  end

  describe '#show' do
    let!(:story) { FactoryBot.create(:story) }

    context 'when Story exists' do
      context 'when Comments have not been fetched previously' do
        before do
          allow_any_instance_of(Story).to receive(:fetch_comments!)
        end

        it 'fetches the associated Comemnts' do
          expect_any_instance_of(Story).to receive(:fetch_comments!)

          get :show, params: { id: story.id }
        end

        it 'renders the associated template' do
          expect_any_instance_of(Story).to receive(:fetch_comments!)

          get :show, params: { id: story.id }

          expect(response).to render_template('show')
        end
      end

      context 'when Comments have been fetched previously' do
        before do
          FactoryBot.create(:comment, story_id: story.id, parent_id: nil)
        end

        it 'renders the associated template' do
          get :show, params: { id: story.id }

          expect(response).to render_template('show')
        end
      end
    end

    context 'when Story does not exist' do
      it 'redirects to root path' do
        get :show, params: { id: 999 }

        expect(response).to redirect_to(root_path)
      end
    end
  end
end
