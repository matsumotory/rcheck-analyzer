def gem_config(conf)
  conf.gembox 'default'
  conf.gem :mgem => 'mruby-json'
  conf.gem :mgem => 'mruby-io'
  conf.gem :github => "kou/mruby-pp"

  # be sure to include this gem (the cli app)
  conf.gem File.expand_path(File.dirname(__FILE__))
end

MRuby::Build.new do |conf|
  toolchain :gcc

  conf.enable_bintest
  conf.enable_test
  conf.cc do |cc|
    cc.flags << ' -DMRB_INT64'
  end


  gem_config(conf)
end
