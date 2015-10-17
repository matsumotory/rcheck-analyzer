def __main__(argv)
  if argv[1] == "version"
    puts "v#{RcheckAnalyzer::VERSION}"
  else
    RcheckAnalyzer::Analyze.new(argv[1], argv[2].to_i, argv[3], argv[4], argv[5]).run
  end
end
