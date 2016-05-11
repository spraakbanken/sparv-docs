This document describes how to get the Annotation Laboratory up and running on your own machine. Begin by downloading the latest source zip from [here](https://spraakbanken.gu.se/pub/annotationlab.dist/). The source code is made available under the [MIT license](https://opensource.org/licenses/MIT).

## Installing the Backend and Catapult
Here follow instructions for installation on a UNIX-like environment.
For more information on the different configuration variables check the [developer's guide](https://spraakbanken.gu.se/eng/research/infrastructure/korp/annotationlab/developersguide).

### Requirements

* The Korp corpus pipeline (see [here](https://spraakbanken.gu.se/eng/research/infrastructure/korp/distribution/corpuspipeline) for installation instructions)
* [Python 2.6](http://python.org/) or newer (but not 3.x)
* A WSGI server (optional but recommended)
* [GCC](http://gcc.gnu.org/install) for compiling the `catapult` C extension

### Installation

* Set the backend configuration variables in `backend/config.py`.
* Set the catapult configuration variables in `catapult/config.sh`.
* From within the `catapult` directory run `./setup-server.sh` to fetch the
makefiles needed to run the pipeline and to build `catalaunch`.
* Start the catapult by running `./start-server.sh` (from within the `catapult` directory).
* Run the script `backend.wsgi` in the `backend` directory.
This can be done by running is directly from the python interpreter or by setting up a
`.htaccess` file such that the WSGI script will automatically loaded by your WSGI server.
* Set up the cron jobs listed in `catapult/cronjobs` for the automatic
maintenance of the Annotation Laboratory.

## Installing the Frontend

### Requirements

* A web server, such as [Apache](http://httpd.apache.org/download.cgi) or equivalent.

### Installation

The frontend comes pre-compiled in the zip and can be installed by simply dropping the `dist` folder into your web server root. Consult your web server documentation for more details. You will also need to set some configuration variables in `dist/config.js` in order to point your frontend to the correct backend address and to the address of the default JSON schema file.
