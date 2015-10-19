require 'open3'

BIN_PATH = File.join(File.dirname(__FILE__), "../mruby/bin/rcheck-analyzer")
LOG_PATH = File.join(File.dirname(__FILE__), "../test/resource.log")
KEY_OUTPUT = <<'KEYS'
{"module"=>"mod_resource_checker",
 "date"=>"Sat Oct 17 21:35:44 2015",
 "type"=>"RCheckALL",
 "unit"=>nil,
 "location"=>"/",
 "remote_ip"=>"93.159.230.89",
 "filename"=>"/usr/local/apache/htdocs/wiki/lib/exe/js.php",
 "scheme"=>"http",
 "method"=>"GET",
 "hostname"=>"wiki.matsumoto-r.jp",
 "server_ip"=>"127.0.0.1",
 "uri"=>"/lib/exe/js.php",
 "real_server_name"=>"www.matsumoto-r.jp",
 "uid"=>2,
 "size"=>12503,
 "content_length"=>0,
 "status"=>200,
 "pid"=>20047,
 "threshold"=>nil,
 "response_time"=>0,
 "result"=>
  {"RCheckUCPU"=>0.007999, "RCheckSCPU"=>0.003999, "RCheckMEM"=>0.484375}}
KEYS

assert('keys') do
  output, status = Open3.capture2(BIN_PATH, LOG_PATH, "0", "keys")

  assert_true status.success?, "Process did not exit cleanly"
  assert_include output, KEY_OUTPUT
end

assert('keys - no argument') do
  output, status = Open3.capture2(BIN_PATH, LOG_PATH)

  assert_true status.success?, "Process did not exit cleanly"
  assert_include output, KEY_OUTPUT
end

assert('hostname with one-line') do
  output, status = Open3.capture2(BIN_PATH, LOG_PATH, "1", "hostname")

  assert_true status.success?, "Process did not exit cleanly"
  assert_include output, "[\"wiki.matsumoto-r.jp\", 2]\n"
end

assert('hostname') do
  output, status = Open3.capture2(BIN_PATH, LOG_PATH, "100", "hostname")

  assert_true status.success?, "Process did not exit cleanly"
  assert_include output, "[\"blog.matsumoto-r.jp\", 70]\n[\"moblog.matsumoto-r.jp\", 26]\n[\"wiki.matsumoto-r.jp\", 5]\n"
end

assert('big line analyze') do
  output, status = Open3.capture2(BIN_PATH, LOG_PATH, "0", "method")

  assert_true status.success?, "Process did not exit cleanly"
  assert_include output, "[\"get\", 64742]\n[\"post\", 61065]\n[\"options\", 32]\n[\"head\", 5]\n"
end

assert('multipul keys') do
  output, status = Open3.capture2(BIN_PATH, LOG_PATH, "100", "hostname", "status")

  assert_true status.success?, "Process did not exit cleanly"
  assert_include output, "[\"wiki.matsumoto-r.jp\", [[200, 4], [302, 1]]]\n[\"blog.matsumoto-r.jp\", [[200, 63], [404, 4], [500, 2], [301, 1]]]\n[\"moblog.matsumoto-r.jp\", [[404, 15], [301, 6], [200, 5]]]\n"
end

assert('sum with multipul keys') do
  output, status = Open3.capture2(BIN_PATH, LOG_PATH, "100", "hostname", "result.rcheckucpu", "sum")

  assert_true status.success?, "Process did not exit cleanly"
  assert_include output, "[\"wiki.matsumoto-r.jp\", [[\"rcheckucpu\", 0.041994]]]\n[\"blog.matsumoto-r.jp\", [[\"rcheckucpu\", 16.506491]]]\n[\"moblog.matsumoto-r.jp\", [[\"rcheckucpu\", 5.637144]]]\n"
end

assert('sum with multipul keys using stdin') do
  stdin_log, status = Open3.capture2("tail", "-n", "100", LOG_PATH)
  output, status = Open3.capture2(BIN_PATH, "stdin", "0", "hostname", "result.rcheckucpu", "sum", :stdin_data => stdin_log)

  assert_true status.success?, "Process did not exit cleanly"
  assert_include output, "[\"blog.matsumoto-r.jp\", [[\"rcheckucpu\", 16.107551]]]\n[\"moblog.matsumoto-r.jp\", [[\"rcheckucpu\", 5.637144]]]\n[\"wiki.matsumoto-r.jp\", [[\"rcheckucpu\", 0.041994]]]\n"
end
