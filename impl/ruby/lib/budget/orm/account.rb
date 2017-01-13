module Budget
  module ORM
    class Account
      def initialize(name=nil, type=nil, balance=nil)
        @name    = name
        @type    = type
        @balance = BigDecimal.new(0) + (balance || 0)
      end

      def name
        @name
      end

      def type
        @type
      end

      def balance
        @balance
      end
    end
  end
end
