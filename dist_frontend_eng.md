This document describes how to get the Sparv frontend up and running on your own machine. Begin by downloading the latest source zip from [here](https://spraakbanken.gu.se/pub/sparv.dist/sparv_frontend). The source code is made available under the [MIT license](https://opensource.org/licenses/MIT).

## Requirements

* A web server, such as [Apache](http://httpd.apache.org/download.cgi) or equivalent.

## Installation

The frontend comes pre-compiled in the zip and can be installed by simply dropping the `dist` folder into your web server root. Consult your web server documentation for more details. You will also need to set some configuration variables in `dist/config.js` in order to point your frontend to the correct backend address and to the address of the default JSON schema file.
