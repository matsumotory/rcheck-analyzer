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

can use other keys like the following log key:

```json
{
  "result": {
    "RCheckMEM": 39.023438,
    "RCheckSCPU": 0.055992,
    "RCheckUCPU": 0.481926
  },
  "response_time": 0,
  "threshold": null,
  "pid": 22533,
  "status": 200,
  "scheme": "http",
  "filename": "/usr/local/apache244/htdocs/blog/index.php",
  "remote_ip": "127.0.0.1",
  "location": "/",
  "unit": null,
  "type": "RCheckALL",
  "date": "Sun Oct 11 18:08:12 2015",
  "module": "mod_resource_checker",
  "method": "GET",
  "hostname": "blog.matsumoto-r.jp",
  "server_ip": "127.0.0.1",
  "uri": "/index.php",
  "real_server_name": "www.matsumoto-r.jp",
  "uid": 2,
  "size": 418,
  "content_length": 2498
}
```
