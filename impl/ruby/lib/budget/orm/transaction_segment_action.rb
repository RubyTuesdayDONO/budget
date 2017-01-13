module Budget
  module ORM
    class TransactionSegmentAction
      def initialize(code=nil, operand=nil)
        @code = code
        @operand = operand
      end

      attr_reader :code, :operand
    end
  end
end
