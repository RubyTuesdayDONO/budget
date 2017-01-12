require 'rugged'

require_relative 'file'

module Budget
  module Drivers
    class Git < Budget::Drivers::File
      attr_reader :repo_path, :tree_path

      def initialize(opts={})
        configure opts
      end

      def configure(opts={})
        @repo_path = opts[:repo]
      end

      def repo
        @repo ||= Rugged::Repository.new(repo_path)
      end
      private :repo

      def init(opts={})
        Rugged::Repository.init_at(repo_path, :bare)
      end

      def with_repo
        yield repo
      end
    end
  end
end
