require 'budget/orm/transaction'
require 'budget/orm/transaction_segments'

require_relative 'transaction_spec_helper'

require 'date'

RSpec.describe Budget::ORM::Transaction do
  before {

  }

  let(:txn) { subject.class.new }

  it('can be instantiated') {
    expect(subject.class.new).not_to be_nil
  }

  it('has an ID') {
    expect(txn.id).to match(TRANSACTION_UUID_PATTERN)
  }

  it('has a date') {
    expect(txn.date).to be_a(Date).or(be_nil)
  }

  it('has segments') {
    expect(txn.segments)
      .to be_a(Budget::ORM::TransactionSegments)
  }

  after {

  }
end
