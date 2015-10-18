module RcheckAnalyzer
  module Data
    def self.each_data_from_log log, key, total_line
      read_line = 0
      data_line = nil
      File.open(log, "r") do |file|
        unless log == "/proc/self/fd/0"
          fp = Tail.new file
        else
          fp = file
        end
        fp.each do |line|
          if key == "keys"
            pp JSON.parse(line)
            exit 0
          end
          data_line = JSON.parse(line.downcase)
          yield data_line
          read_line += 1
          break if total_line != 0 and read_line > total_line
        end
      end
    end
    def self.data_from_log log, key, total_line
      data = []
      File.open(log, "r") do |file|
        unless log == "/proc/self/fd/0"
          fp = Tail.new file
        else
          fp = file
        end
        fp.each do |line|
          if key == "keys"
            data << JSON.parse(line)
            pp data[0]
            exit 0
          end
          data << JSON.parse(line.downcase)
          break if total_line != 0 and data.size > total_line
        end
      end
      data
    end
  end
end

