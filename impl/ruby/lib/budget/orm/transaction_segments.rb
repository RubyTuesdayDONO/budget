require_relative 'transaction_segment'

module Budget
  module ORM
    class TransactionSegments
      def initialize(*segments)
        @segments = []
      end

      def accumulate(*segments)
        segments.each {
          |segment|
          case segment
          when Budget::ORM::TransactionSegment
            @segments << segment
          else
            raise TypeError, "expected TransactionSegment, "\
                             "not #{segment.class}"
          end
        }
        self
      end

      def clone
        return Budget::ORM::TransactionSegments.new(*@segments)
      end

      def +(*segments)
        self.clone.accumulate(*segments)
      end

      def <<(*segments)
        accumulate(*segments)
      end

      def count
        @segments.length
      end

      def each
        if block_given?
          @segments.each { |segment|
            yield segment
          }
        else
          @segments.each
        end
      end
    end
  end
end
