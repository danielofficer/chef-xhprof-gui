# Description

Installs and configures XHProf and a XHGui by Paul Reinheimer. This can be used to profile your PHP application during development and is lightweight enough to be used in production for live profiling of request samples.

# Requirements

Chef 0.10.0 or higher required (for Chef environment use).

## Platform

* Debian, Ubuntu
* CentOS, Red Hat, Fedora

## Cookbooks

The following Opscode cookbooks are dependencies:

* php
* git (XHGui only)
* mysql (XHGui only)
* database (XHGui only)
* apache2 (XHGui only)

In order to install XHProf you will also need to install `php_dev` using the `chef-php-extra` cookbook.

* chef-php-extra

## Chef-Solo

If your using this cookbook with chef-solo you will need to define a `[:mysql][:server_root_password]` as this value will be re-generated each time chef is executed. Chef-solo does not have any storage mechanism for the attribute so it will be generated as new each time.

# Attributes

* `node["xhprof"]["db"]["database"]` = The name of the database used to store profiling data, defaults to `xhprof`.
* `node["xhprof"]["db"]["username"]` = The user that can connect to the database, defaults to `xhprof`.
* `node["xhprof"]["db"]["password"]` = The password to connect to the database, if left empty a secure password will be generated.
* `node["xhprof"]["install_path"]` = The path on the system where the XHGui code will be installed, defaults to `/opt/xhprof`.
* `node["xhprof"]["hostname"]` = "The hostname at which you can access the XHGui, defaults to `xhprof`."
* `node["xhprof"]["servername"]` = "The name of the server that is generating the profiling data, defaults to `myserver`."
* `node["xhprof"]["namespace"]` = "The namespace for the application being profiled, defaults to `myapp`."
* `node["xhprof"]["serializer"]` = "Method used to serialize data. MySQL/MySQLi/PDO ONLY Switch to JSON for better performance and support for larger profiler data sets. WARNING: Will break with existing profile data, you will need to TRUNCATE the profile data table."
* `node["xhprof"]["control_ips"]` = "IP address that are granted access to XHGui, defaults to `"localhost"` and IP V6 `"::1"`, you'll want to add your own IP"

# Recipes

## default

## xhprof

Installs XHProf using PECL.

## xhgui

Installs and configures XHGui from [GitHub](https://github.com/preinheimer/xhprof) and sets up a MySql database to store data from profile runs. An apache vhost is also created to allow you to view the test run data.

# Usage

Add the following configuration line to your Apache vhost configuration or to .htaccess file:

    php_value auto_prepend_file “/opt/xhprof/external/header.php”
    php_value auto_append_file “/opt/xhprof/external/footer.php”

# License and Author

Author:: Alistair Stead (alistair@inviqa.com)

Copyright 2012, Inviqa

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
