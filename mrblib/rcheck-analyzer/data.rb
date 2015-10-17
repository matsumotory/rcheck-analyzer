module RcheckAnalyzer
  module Data
    def self.data_from_log log, key, total_line
      data = []
      File.open(log, "r") do |file|
        unless log == "/proc/self/fd/0"
          fp = Tail.new file
        else
          fp = file
        end
        fp.each do |line|
          data << JSON.parse(line.downcase)
          if key == "keys"
            pp data[0]
            exit 0
          end
          break if total_line != 0 and data.size > total_line
        end
      end
      data
    end
  end
end

