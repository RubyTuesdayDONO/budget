require 'securerandom'
require 'bigdecimal'
require 'date'

require_relative 'transaction_segments'

module Budget
  module ORM
    class Transaction
      def initialize
        @id = SecureRandom.uuid
        @date = nil
        @segments = TransactionSegments.new
      end

      def id
        @id
      end

      def date
        @date
      end

      def segments
        @segments
      end
    end
  end
end
