class TestRcheckAnalyzer < MTest::Unit::TestCase
  LOG_PATH = File.join(File.dirname(__FILE__), "./resource.log")
  DATA_SET = [{"module"=>"mod_resource_checker", "date"=>"sat oct 17 21:35:44 2015", "type"=>"rcheckall", "unit"=>nil, "location"=>"/", "remote_ip"=>"93.159.230.89", "filename"=>"/usr/local/apache/htdocs/wiki/lib/exe/js.php", "scheme"=>"http", "method"=>"get", "hostname"=>"wiki.matsumoto-r.jp", "server_ip"=>"127.0.0.1", "uri"=>"/lib/exe/js.php", "real_server_name"=>"www.matsumoto-r.jp", "uid"=>2, "size"=>12503, "content_length"=>0, "status"=>200, "pid"=>20047, "threshold"=>nil, "response_time"=>0, "result"=>{"rcheckucpu"=>0.007999, "rcheckscpu"=>0.003999, "rcheckmem"=>0.484375}}, {"module"=>"mod_resource_checker", "date"=>"sat oct 17 21:35:44 2015", "type"=>"rcheckall", "unit"=>nil, "location"=>"/", "remote_ip"=>"93.159.230.89", "filename"=>"/usr/local/apache/htdocs/wiki/lib/exe/js.php", "scheme"=>"http", "method"=>"get", "hostname"=>"wiki.matsumoto-r.jp", "server_ip"=>"127.0.0.1", "uri"=>"/lib/exe/js.php", "real_server_name"=>"www.matsumoto-r.jp", "uid"=>2, "size"=>12503, "content_length"=>0, "status"=>200, "pid"=>20044, "threshold"=>nil, "response_time"=>0, "result"=>{"rcheckucpu"=>0.006999, "rcheckscpu"=>0.003, "rcheckmem"=>0.480469}}]
  DATA_SET_1_HOSTNAME = {"wiki.matsumoto-r.jp"=>2}
  DATA_SET_100_HOSTNAME_STATUS = {"wiki.matsumoto-r.jp"=>{200=>4, 302=>1}, "blog.matsumoto-r.jp"=>{404=>4, 200=>63, 301=>1, 500=>2}, "moblog.matsumoto-r.jp"=>{200=>5, 301=>6, 404=>15}}

  def test_main
    assert_equal(DATA_SET_1_HOSTNAME,  __main__(["dummy", LOG_PATH, "1", "hostname"]))
    assert_equal(DATA_SET_100_HOSTNAME_STATUS,  __main__(["dummy", LOG_PATH, "100", "hostname", "status"]))
  end
  def test_analyze_data
    a = RcheckAnalyzer::Analyze.new(["dummy", LOG_PATH, "1", "hostname"])
    assert_equal(DATA_SET_1_HOSTNAME, a.analyze_data(DATA_SET))
  end
  def test_data_from_log
    assert_equal(DATA_SET, RcheckAnalyzer::Data.data_from_log(LOG_PATH, "hostname", 1))
  end
end

MTest::Unit.new.run
