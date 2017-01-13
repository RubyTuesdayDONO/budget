require 'budget/orm/transaction_segment.rb'
require 'budget/orm/account.rb'
require 'budget/orm/transaction_segment_action.rb'

require 'bigdecimal'

RSpec.describe Budget::ORM::TransactionSegment do
  before {

  }

  let(:txn_seg) { subject.class.new }

  it('can be instantiated') {
    expect(subject.class.new).not_to be_nil
  }

  it('has no amount by default') {
    expect(txn_seg.amount).to eq(0)
  }

  it('has an account') {
    expect(txn_seg.account)
      .to be_a(Budget::ORM::Account) |
          be_nil
  }

  it('has an action') {
    expect(txn_seg.action)
      .to be_a(Budget::ORM::TransactionSegmentAction) |
          be_nil
  }

  after {

  }
end
