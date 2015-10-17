def __main__(argv)
  if argv[1] == "version"
    puts "v#{RcheckAnalyzer::VERSION}"
  else
    RcheckAnalyzer::Analyze.new(argv).run
  end
end
