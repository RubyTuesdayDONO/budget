module Budget
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :user_name
    attr_accessor :user_email

    def initialize
      @repo_path = nil
    end
  end
end
