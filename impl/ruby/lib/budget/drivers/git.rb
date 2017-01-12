require_relative 'file'

module Budget
  module Drivers
    class Git < Budget::Drivers::File
      attr_reader :repo, :tree

      def initialize(opts={})
        configure opts
      end

      def configure(opts={})
        @repo = opts[:repo]
      end

      def init(opts={})

      end
    end
  end
end
