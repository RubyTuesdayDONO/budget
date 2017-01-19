require_relative '../orm/transaction_spec_helper'
require 'fileutils'
require 'json'

require 'rugged'

OID_PATT = /^[[:xdigit:]]{40}$/.freeze
data_dir = File.expand_path('../../../../../../test/ruby/data', __FILE__)

RSpec.describe Rugged::Index do
  before {
    FileUtils.rmtree Dir[File.join(data_dir, '*')], secure: true
    FileUtils.mkdir_p data_dir
  }

  let(:repo)       { Rugged::Repository.init_at(data_dir, is_bare:true ) }
  let(:idx)        { Rugged::Index.new }
  let(:json)       {  { foo: 'bar' }.to_json }
  let(:author) {
    { name:  'RSpec',
      email: 'rspec@test',
      time:  Time.now
    }
  }
  let(:commit_opts) {
    {
      committer: author,
      author:    author,
      message:   'test commit',
      parents:   [],
      update_ref: 'HEAD'
    }
  }

  it('can be instantiated') {
    expect(subject.class.new).not_to be_nil
  }

  it('can stage a path') {
    oid = repo.write(json, :blob)
    expect(oid).to match(OID_PATT)
    idx << {
      oid: oid,
      path: 'txn/1/2/3/123.json',
    }
    tree = idx.write_tree(repo)
    expect(tree).to match(OID_PATT)

    _commit_opts = { tree: tree }.merge(commit_opts)

    commit = Rugged::Commit.create(repo, _commit_opts)
    puts(commit)
  }

  after {
    # FileUtils.rmtree Dir[File.join(data_dir, '*')], secure: true
  }
end
