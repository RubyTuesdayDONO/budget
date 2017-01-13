require 'budget/orm/transaction.rb'
require 'budget/orm/transaction_segments.rb'

require 'date'

RSpec.describe Budget::ORM::Transaction do
  before {

  }

  let(:txn) { subject.class.new }

  it('can be instantiated') {
    expect(subject.class.new).not_to be_nil
  }

  it('has an ID') {
    expect(txn.id).to match /[[:xdigit:]]{8}(-[[:xdigit:]]{4}){3}-[[:xdigit:]]{8}/
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
