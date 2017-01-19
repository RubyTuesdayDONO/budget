require 'budget/drivers/storage/git.rb'
require 'budget/orm/transaction'

require_relative '../orm/transaction_spec_helper'

require 'fileutils'

data_dir = File.expand_path('../../../../../../test/ruby/data', __FILE__)

RSpec.describe Budget::Drivers::Storage::Git do
  before {
    FileUtils.mkdir_p data_dir
  }

  let(:git) { subject.class.new(repo: data_dir).init }
  let(:txn) { Budget::ORM::Transaction.new() }

  it('can be instantiated') {
    expect(subject.class.new).not_to be_nil
  }

  it('can initialize a datastore') {
    _git = subject.class.new(repo: data_dir)
    _git.init
    _git.with_repo { |repo|
      expect(repo.bare?).to be_truthy
      expect(repo.empty?).to be_truthy
    }
  }

  it('can determine the storage partition for a transaction') {
    partition = git.storage_partition_for_txn(txn)
    expect(partition).to match(%r{[[:xdigit:]]{2}(/[[:xdigit:]]{2}){15}$})
  }

  it('can journal a transaction') {
    expect(git.journal_txn(txn)).to match /[[:xdigit:]]{40}/
  }

  after {
    FileUtils.rmtree Dir[File.join(data_dir, '*')], secure: true
  }
end
