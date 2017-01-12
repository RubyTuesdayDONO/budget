require 'budget/drivers/git.rb'

require 'fileutils'

data_dir = File.expand_path('../../../../../../test/ruby/data', __FILE__)

RSpec.describe Budget::Drivers::Git do
  before {
    FileUtils.mkdir_p data_dir
  }

  let(:git) { subject.class.new }

  it('can be instantiated') {
    expect(subject.class.new).not_to be_nil
  }

  it('can initialize a datastore') {
    git.configure repo: data_dir
    git.init
    git.with_repo { |repo|
      expect(repo.bare?).to be_truthy
      expect(repo.empty?).to be_truthy
    }
  }

  it('can journal a transaction') {
    expect(git.journal_txn({foo: 'bar'})).to match /[[:xdigit:]]{40}/
  }
end
