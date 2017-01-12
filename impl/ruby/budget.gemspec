Gem::Specification.new do |s|
  s.name        = 'budget'
  s.version     = '0.0.1'
  s.licenses    = ['0BSD']
  s.summary     = 'personal finance tracker'
  s.description = 'Budget helps track personal finances, ' \
                  'including cash and credit accounts, ' \
                  'and can forecast expenses into the future.'
  s.authors     = ['Reuben Garrett']
  s.email       = 'ruby@rubydono.net'
  s.homepage    = 'https://github.com/RubyTuesdayDONO/budget'

  s.files       = %w(
                       lib/budget.rb
                       lib/drivers/file.rb
                       lib/drivers/git.rb
                    )
end
