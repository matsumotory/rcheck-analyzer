# rcheck-analyzer


```
$ ./rcheck-analyzer /var/log/httpd/resource.log 1000 status
[404, 31]
[301, 45]
[403, 133]
[500, 147]
[200, 645]
```

```
$ ./rcheck-analyzer /var/log/httpd/resource.log 1000 hostname
["moblog.matsumoto-r.jp", 156]
["blog.matsumoto-r.jp", 845]
```

```
$ ./rcheck-analyzer /var/log/httpd/resource.log 1000 method
["OPTIONS", 1]
["POST", 304]
["GET", 696]
```

## multiple keys

```
$ ./rcheck-analyzer /usr/local/apache/logs/resource.log 100 hostname status
["blog.matsumoto-r.jp", [[200, 85], [500, 5], [404, 4], [301, 2], [403, 1]]]
["moblog.matsumoto-r.jp", [[200, 2], [301, 1]]]
["wiki.matsumoto-r.jp", [[404, 1]]]
```

```
$ ./rcheck-analyzer /usr/local/apache/logs/resource.log 100 status hostname
[403, [["blog.matsumoto-r.jp", 2]]]
[200, [["blog.matsumoto-r.jp", 79], ["moblog.matsumoto-r.jp", 6]]]
[302, [["blog.matsumoto-r.jp", 1]]]
[301, [["moblog.matsumoto-r.jp", 7], ["blog.matsumoto-r.jp", 1]]]
[404, [["blog.matsumoto-r.jp", 3]]]
[500, [["blog.matsumoto-r.jp", 2]]]
```

```
$ ./rcheck-analyzer /usr/local/apache/logs/resource.log 100 filename status
["/usr/local/apache/htdocs/blog/index.php", [[200, 69], [301, 2]]]
["/usr/local/apache/htdocs/blog/wordpress", [[404, 3]]]
["/usr/local/apache/htdocs/blog/wp-content/themes/wp.vicuna.exc/style.php",
 [[200, 4]]]
["/usr/local/apache/htdocs/blog/wp-login.php", [[403, 1]]]
["/usr/local/apache/htdocs/blog/wp-comments-post.php", [[500, 5]]]
["/usr/local/apache/htdocs/moblog/index.php", [[200, 2], [301, 1]]]
["/usr/local/apache/htdocs/blog/2.zip", [[404, 1]]]
["/usr/local/apache/htdocs/blog/wp-admin/admin-ajax.php", [[200, 8]]]
["/usr/local/apache/htdocs/blog/files/IMG_3100.JPG", [[200, 1]]]
["/usr/local/apache/htdocs/blog/files/IMG_3101.JPG", [[200, 1]]]
["/usr/local/apache/htdocs/blog/files/IMG_3102.JPG", [[200, 1]]]
["/usr/local/apache/htdocs/wiki/wp-admin", [[404, 1]]]
["/usr/local/apache/htdocs/blog/wp-content/plugins/wptouch/themes/foundation/modules/wptouch-icons/font/wptouch-icons.woff",
 [[200, 1]]]
```

### sum option
 
 ```
 $ ./rcheck-analyzer /usr/local/apache/logs/resource.log 1000 hostname result.RCheckUCPU sum
["moblog.matsumoto-r.jp", [["RCheckUCPU", 24.030345]]]
["blog.matsumoto-r.jp", [["RCheckUCPU", 238.290761]]]
["wiki.matsumoto-r.jp", [["RCheckUCPU", 0.043993]]]
```

```
$ ./rcheck-analyzer /usr/local/apache/logs/resource.log 10 filename result.RCheckUCPU sum
["/usr/local/apache/htdocs/blog/index.php", [["RCheckUCPU", 1.058839]]]
["/usr/local/apache/htdocs/moblog/index.php", [["RCheckUCPU", 0.885865]]]
["/usr/local/apache/htdocs/blog/wp-admin/admin-ajax.php",
 [["RCheckUCPU", 0.377943]]]
```

## use stdin

- use pipe and the number of `10` lines

```
$ tail -n 100 /usr/local/apache/logs/resource.log | ./rcheck-analyzer stdin 100 hostname status
["blog.matsumoto-r.jp", [[200, 85], [500, 5], [404, 3], [301, 2], [403, 1]]]
["wiki.matsumoto-r.jp", [[404, 1]]]
["moblog.matsumoto-r.jp", [[200, 2], [301, 1]]]
```

- `tail -f` and reache the number of `10` lines and automatically close

```
$ tail -f /usr/local/apache/logs/resource.log | ./rcheck-analyzer stdin 10 hostname status
["moblog.matsumoto-r.jp", [[200, 1]]]
["blog.matsumoto-r.jp", [[200, 8], [403, 1], [500, 1]]]
```

can use other keys like the following log key:

```
$ ./rcheck-analyzer /usr/local/apache/logs/resource.log 10 keys
{"module"=>"mod_resource_checker",
 "date"=>"Sat Oct 17 17:28:35 2015",
 "type"=>"RCheckALL",
 "unit"=>nil,
 "location"=>"/",
 "remote_ip"=>"127.0.0.1",
 "filename"=>
  "/usr/local/apache/htdocs/blog/wp-content/uploads/2009/07/IMG_33491.JPG",
 "scheme"=>"http",
 "method"=>"GET",
 "hostname"=>"blog.matsumoto-r.jp",
 "server_ip"=>"127.0.0.1",
 "uri"=>"/wp-content/uploads/2009/07/IMG_33491.JPG",
 "real_server_name"=>"www.matsumoto-r.jp",
 "uid"=>2,
 "size"=>81210,
 "content_length"=>81210,
 "status"=>200,
 "pid"=>20044,
 "threshold"=>nil,
 "response_time"=>0,
 "result"=>{"RCheckUCPU"=>0, "RCheckSCPU"=>0, "RCheckMEM"=>0.078125}}
```
