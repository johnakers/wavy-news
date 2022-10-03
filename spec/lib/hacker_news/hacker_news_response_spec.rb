require 'rails_helper'

describe HackerNews::HackerNewsResponse do
  let(:params) do
    {
      'id' => 123,
      'by' => 'john',
      'descendants' => 10,
      'kids' => [456, 789],
      'score' => 99,
      'title' => 'Hello, world',
      'url' => 'https://johnakers.net/crypt',
      'time' => 1_664_781_280,
      'parent' => [987]
    }
  end

  describe '#invalid_type?' do
    context 'when type is not Story or Comment' do
      it 'returns true' do
        params.merge!({ 'type' => 'banana' })

        hnr = described_class.new(params)

        expect(hnr.invalid_type?).to eq(true)
      end
    end

    context 'when type is Story or Comment' do
      it 'returns false' do
        params.merge!({ 'type' => 'story' })

        hnr = described_class.new(params)

        expect(hnr.invalid_type?).to eq(false)
      end
    end
  end

  describe '#parsed_body' do
    it 'only keeps the keys which are valid' do
      expected_keys = %w[
        by
        descendants
        id
        kids
        score
        time
        title
        url
      ].sort

      params.merge!({
        'banana' => 'true',
        'apple' => 'yes',
        'type' => 'story'
      })
      hnr = described_class.new(params)

      expect(hnr.parsed_body.keys.sort).to eq(expected_keys)
    end

    it 'changes the time from epoch to DateTime' do
      params.merge!({ 'type' => 'story' })

      hnr = described_class.new(params)

      expect(hnr.parsed_body['time']).to be_a(DateTime)
    end

    context 'when type is a Comment' do
      it 'renames the parent key, to parent_id' do
        params.merge!({ 'type' => 'comment' })
        hnr = described_class.new(params)

        pb = hnr.parsed_body

        expect(pb['parent']).to be_nil
        expect(pb['parent_id']).not_to be_nil
      end
    end
  end
end
