module RcheckAnalyzer
  module Error
    def self.usage args
      "#{args[0]} log-filename tail-lines key1 (key2) (type)"
    end
  end
end
