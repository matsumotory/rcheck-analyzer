require 'open3'

BIN_PATH = File.join(File.dirname(__FILE__), "../mruby/bin/rcheck-analyzer")
LOG_PATH = File.join(File.dirname(__FILE__), "../resource.log")

assert('keys') do
  output, status = Open3.capture2(BIN_PATH, LOG_PATH, 0, "keys")

  assert_true status.success?, "Process did not exit cleanly"
  assert_include output, <<'KEYS'
{"module"=>"mod_resource_checker",
 "date"=>"sat oct 17 21:35:44 2015",
 "type"=>"rcheckall",
 "unit"=>nil,
 "location"=>"/",
 "remote_ip"=>"93.159.230.89",
 "filename"=>"/usr/local/apache/htdocs/wiki/lib/exe/js.php",
 "scheme"=>"http",
 "method"=>"get",
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
  {"rcheckucpu"=>0.007999, "rcheckscpu"=>0.003999, "rcheckmem"=>0.484375}}
KEYS
end

assert('version') do
  output, status = Open3.capture2(BIN_PATH, "version")

  assert_true status.success?, "Process did not exit cleanly"
  assert_include output, "v0.0.1"
end
