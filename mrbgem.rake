MRuby::Gem::Specification.new('rcheck-analyzer') do |spec|
  spec.license = 'MIT'
  spec.author  = 'MRuby Developer'
  spec.summary = 'rcheck-analyzer'
  spec.bins    = ['rcheck-analyzer']

  spec.add_dependency 'mruby-print', :core => 'mruby-print'
  spec.add_dependency 'mruby-mtest', :mgem => 'mruby-mtest'
end
