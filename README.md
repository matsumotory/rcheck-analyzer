# rcheck-analyzer [![Build Status](https://travis-ci.org/matsumoto-r/rcheck-analyzer.svg?branch=master)](https://travis-ci.org/matsumoto-r/rcheck-analyzer)

rcheck-analyzer analyze the log via [mod_resource_checker](https://github.com/matsumoto-r/mod_resource_checker).

 It's simple and powerful.
 
## usage

```
./rcheck-analyzer log-filename read-tail-line key1 (key2) (sum)

 - read-head-line is the number of file-tail-line. `0` read all lines.
 - key1 and key2 are json keys. key2 is optional argument.
 - sum is only used by using key2 option. sum option sum the target json value.
```

```
$ ./rcheck-analyzer resource.log 100 hostname 
["blog.matsumoto-r.jp", 70]
["moblog.matsumoto-r.jp", 26]
["wiki.matsumoto-r.jp", 5]
```

```
$ ./rcheck-analyzer resource.log 100 hostname status
["wiki.matsumoto-r.jp", [[200, 4], [302, 1]]]
["blog.matsumoto-r.jp", [[200, 63], [404, 4], [500, 2], [301, 1]]]
["moblog.matsumoto-r.jp", [[404, 15], [301, 6], [200, 5]]]
```

```
$ ./rcheck-analyzer resource.log 100 hostname result.rcheckucpu sum
["wiki.matsumoto-r.jp", [["rcheckucpu", 0.041994]]]
["blog.matsumoto-r.jp", [["rcheckucpu", 16.506491]]]
["moblog.matsumoto-r.jp", [["rcheckucpu", 5.637144]]]
```

- stdin mode

```
echo log-data | ./rcheck-analyzer stdin read-head-line key1 (key2) (sum)

  - you set `stdin` instead of `log-filename`
  - read-head-line is the number of file-head-line. `0` read all lines.
```

```
$ grep "Sat Oct 17 21" resource.log | ./rcheck-analyzer stdin 0 hostname
["blog.matsumoto-r.jp", 313]
["moblog.matsumoto-r.jp", 139]
["wiki.matsumoto-r.jp", 5]
```

 
## more exmaple
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
 $ ./rcheck-analyzer /usr/local/apache/logs/resource.log 1000 hostname result.rcheckucpu sum
["moblog.matsumoto-r.jp", [["rcheckucpu", 24.030345]]]
["blog.matsumoto-r.jp", [["rcheckucpu", 238.290761]]]
["wiki.matsumoto-r.jp", [["rcheckucpu", 0.043993]]]
```

```
$ ./rcheck-analyzer /usr/local/apache/logs/resource.log 10 filename result.rcheckucpu sum
["/usr/local/apache/htdocs/blog/index.php", [["rcheckucpu", 1.058839]]]
["/usr/local/apache/htdocs/moblog/index.php", [["rcheckucpu", 0.885865]]]
["/usr/local/apache/htdocs/blog/wp-admin/admin-ajax.php",
 [["rcheckucpu", 0.377943]]]
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
```
