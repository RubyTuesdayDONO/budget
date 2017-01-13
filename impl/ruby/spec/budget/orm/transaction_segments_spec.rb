# coding: utf-8
require 'budget/orm/transaction.rb'
require 'budget/orm/transaction_segments.rb'

RSpec.describe Budget::ORM::TransactionSegments do
  before {

  }

  let(:txn_segs) { subject.class.new }

  it('can be instantiated') {
    _txn_segs = subject.class.new
    expect(_txn_segs).not_to be_nil
    expect(_txn_segs).to be_a(subject.class)
  }

  it('has no segments on init') {
    expect(txn_segs.count).to eq(0)
  }

  it('can accumulate segments') {
    3.times do
      txn_segs << Budget::ORM::TransactionSegment.new
    end

    expect(txn_segs.count).to eq(3)
  }

  it('only contains TransactionSegments') {
    3.times do
      txn_segs.each do |txn_seg|
        expect(txn_seg).to be_a(Budget::ORM::TransactionSegment)
      end
      txn_segs << Budget::ORM::TransactionSegment.new
    end
  }

  after {

  }
end
