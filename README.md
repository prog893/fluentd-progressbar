# fluentd-progressbar

A small bash script that shows Fluentd log parse/upload progress with ASCII Art.


## Usage

```
$ fluentd_progressbar logfile.log posfile.pos
```

## Demo
```
$ ./fluentd_progressbar.sh /var/log/httpd-access.log /var/log/td-agent/httpd-access.pos 
Progress:  [###_______________________________________________] 6.08% ETA: 02:54:23 
```

## Prerequisites

This script calculates upload progress using position file, thus, you must have pos_file argument set in your td-agent configuration. Here is an example.

```
<source>
  @type tail
  format apache
  path /var/log/httpd-access.log
  tag apache.access
  pos_file /var/log/td-agent/httpd-access.pos
</source>
```

## Installing

Grab this script and fix permissions if needed.

```
$ chmod +x fluentd_progressbar.sh
```

## Authors

* **pseudobeer**

See also the list of [contributors](https://github.com/pseudobeer/fluentd-progressbar/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
