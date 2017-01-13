require 'bigdecimal'
require 'date'

module Budget
  module ORM
    class TransactionSegment
      def initialize(account=nil, action=nil, amount=nil)
        @account = account
        @action  = action
        @amount  = BigDecimal.new(0) + (amount || 0)
      end

      def account
        @account
      end

      def action
        @action
      end

      def amount
        @amount
      end
    end
  end
end
