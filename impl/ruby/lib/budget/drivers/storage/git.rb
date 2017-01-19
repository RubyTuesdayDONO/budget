require 'rugged'
require 'json'

require_relative 'file'

module Budget
  module Drivers
    module Storage
      class Git < Budget::Drivers::Storage::File
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

        def storage_partition_for_txn(txn)
          case txn
          when Budget::ORM::Transaction
            txn.id.scan(/\w{2}/).join('/')
          when nil
            raise ArgumentError, 'expected Budget::ORM::Transaction, '\
                                 'not nil'
          else
            raise ArgumentError, 'expected Budget::ORM::Transaction, '\
                                 "not #{txn.class}"
          end
        end

        def build_nested_tree(path)

        end

        def journal_txn(txn)
          oid = repo.write(JSON.generate(txn), :blob)
          path = storage_partition_for_txn(txn)
          builder = Rugged::Tree::Builder.new()
          builder << { :type => :blob, :name => path, :oid => oid, :filemode => 0100644 }

          options = {}
          options[:tree] = builder.write

          options[:author] = { :email => "testuser@github.com", :name => 'Test Author', :time => Time.now }
          options[:committer] = { :email => "testuser@github.com", :name => 'Test Author', :time => Time.now }
          options[:message] ||= "Making a commit via Rugged!"
          options[:parents] = repo.empty? ? [] : [ repo.head.target ].compact
          options[:update_ref] = 'HEAD'

          Rugged::Commit.create(repo, options)
        end
        end
    end
  end
end
