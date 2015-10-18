class TestRcheckAnalyzer < MTest::Unit::TestCase
  LOG_PATH = File.join(File.dirname(__FILE__), "./resource.log")
  def test_main
    assert_equal({"wiki.matsumoto-r.jp"=>2},  __main__(["dummy", LOG_PATH, "1", "hostname"]))
    assert_equal({"wiki.matsumoto-r.jp"=>{200=>4, 302=>1}, "blog.matsumoto-r.jp"=>{404=>4, 200=>63, 301=>1, 500=>2}, "moblog.matsumoto-r.jp"=>{200=>5, 301=>6, 404=>15}},  __main__(["dummy", LOG_PATH, "100", "hostname", "status"]))
  end
end

MTest::Unit.new.run
