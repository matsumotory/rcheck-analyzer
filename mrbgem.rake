MRuby::Gem::Specification.new('rcheck-analyzer') do |spec|
  spec.license = 'MIT'
  spec.author  = 'MRuby Developer'
  spec.summary = 'rcheck-analyzer'
  spec.bins    = ['rcheck-analyzer']

  spec.add_test_dependency 'mruby-print', :core => 'mruby-print'
  spec.add_test_dependency 'mruby-enum-ext', :core => 'mruby-enum-ext'
  spec.add_test_dependency 'mruby-mtest', :mgem => 'mruby-mtest'
  spec.add_test_dependency 'mruby-dir', :mgem => 'mruby-dir'
  spec.add_test_dependency 'mruby-json', :mgem => 'mruby-json'
  spec.add_test_dependency 'mruby-io', :mgem => 'mruby-io'
  spec.add_test_dependency 'mruby-process', :mgem => 'mruby-process'
  spec.add_test_dependency 'mruby-env', :mgem => 'mruby-env'
  spec.add_test_dependency 'mruby-mutex', :mgem => 'mruby-mutex'
  spec.add_test_dependency 'mruby-regexp-pcre', :mgem => 'mruby-regexp-pcre'
  spec.add_test_dependency 'mruby-pp', :github => "kou/mruby-pp"

end
