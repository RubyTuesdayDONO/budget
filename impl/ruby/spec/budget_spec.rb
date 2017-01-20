require 'budget'

RSpec.describe Budget do
  it('can be instantiated') {
    expect(subject.class.new).not_to be_nil
  }

  it('can configure itself') {
    Budget.configure do |config|
      config.user_name  = 'RSpec'
      config.user_email = 'rspec@test'
    end
  }

  it("won't configure unknown options") {
    expect {
      Budget.configure do |config|
        config.non_existent_option  = 'invalid'
      end
    }.to raise_error(NoMethodError)
  }
end
