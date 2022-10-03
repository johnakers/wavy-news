# frozen_string_literal: true

require 'rails_helper'

# Spec for CommentsController
RSpec.describe CommentsController, type: :controller do
  describe '#show' do
    let!(:story) { FactoryBot.create(:story) }
    let!(:comment) { FactoryBot.create(:comment, story_id: story.id, parent_id: nil) }

    context 'when associated Story does not exist' do
      it 'redirects to root_path' do
        get :show, params: { story_id: 123, id: comment.id }

        expect(response).to redirect_to(root_path)
      end
    end

    context 'when Comment does not exist' do
      it 'redirects to root_path' do
        get :show, params: { story_id: story.id, id: 123 }

        expect(response).to redirect_to(root_path)
      end
    end

    context 'when child-Comments have not been previously fetched' do
      it 'fetches the child-Comments' do
      end

      it 'renders the associated template' do
      end
    end

    it 'renders the associated template' do
      get :show, params: { story_id: story.id, id: comment.id }

      expect(response).to render_template('show')
    end
  end
end
