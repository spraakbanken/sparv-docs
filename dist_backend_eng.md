This document describes how to get the Sparv backend up and running on your own machine. Begin by downloading the latest source zip from [here](https://spraakbanken.gu.se/pub/sparv.dist/sparv_backend). The source code is made available under the [MIT license](https://opensource.org/licenses/MIT).

## Info
Here follow instructions for installation on a UNIX-like environment.
For more information on the different configuration variables check the [developer's guide](https://spraakbanken.gu.se/eng/research/infrastructure/sparv/developersguide).

The Sparv backend is configured to be run in combination with the catapult. The catapult source files are distributed together with the corpus pipeline (see below).

## Requirements

* The Sparv corpus pipeline (see [here](https://spraakbanken.gu.se/eng/research/infrastructure/sparv/distribution/pipeline) for installation instructions)
* [Python 2.6](http://python.org/) or newer (but not 3.x)
* A WSGI server (optional but recommended)
* [GCC](http://gcc.gnu.org/install) for compiling the `catapult` C extension

## Installation

* Set the backend configuration variables in `backend/config.py`.
* Set the catapult configuration variables in `catapult/config.sh`.
* From within the `catapult` directory run `make` to build `catalaunch`.
* Start the catapult by running `./start-server.sh` (from within the `catapult` directory).
* Run the script `backend.wsgi` in the `backend` directory.
This can be done by running it directly from the python interpreter or by setting up a
`.htaccess` file such that the WSGI script will automatically loaded by your WSGI server.
* Set up the cron jobs listed in `catapult/cronjobs` for the automatic
maintenance of Sparv.
