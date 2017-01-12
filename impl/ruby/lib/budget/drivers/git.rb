require 'rugged'
require 'json'

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
        return self
      end

      def with_repo
        yield repo
      end

      def journal_txn(txn)
        oid = repo.write(JSON.generate(txn), :blob)
      end
    end
  end
end
