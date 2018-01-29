# frozen_string_literal: true

require_relative '../spec/spec_helper'

describe 'new spec file' do
  subject(:forecast) do
    Crystalball.foresee(workdir: root, map_path: root.join('execution_map.yml')) do |predictor|
      predictor.use Crystalball::Predictor::ModifiedSpecs.new
    end
  end

  include_context 'simple git repository'

  it 'adds new spec file to map' do
    new_spec_path = spec_path.join('new_spec.rb')
    new_spec_path.open('w') { |f| f.write(<<~RUBY) }
      require 'spec_helper'

      describe 'new spec' do
        specify { expect(Class1.new).not_to be_nil }
      end
    RUBY
    git.add(new_spec_path.to_s)

    is_expected.to match_array(%w[spec/new_spec.rb])
  end
end