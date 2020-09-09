
This section describes how to get the Sparv backend up and running on your own machine.
Begin by downloading the latest version from the [GitHub repository](https://github.com/spraakbanken/sparv-backend).


### Info

These instructions are for installation on a UNIX-like environment.
For more information on the different configuration variables check the [developer's guide](https://spraakbanken.gu.se/en/tools/sparv/pipeline/technical-documentation).

The Sparv backend is configured to be run in combination with the catapult which is also available on GitHub (see below).

### Requirements

* The Sparv corpus pipeline (see [here](https://spraakbanken.gu.se/en/tools/sparv/pipeline/installation) for installation instructions)
* The [Sparv catapult](https://github.com/spraakbanken/sparv-catapult)
* [Python 3.4](http://python.org/) or newer
* A WSGI server (optional but recommended)
* [GCC](http://gcc.gnu.org/install) for compiling the `catapult` C extension

### Installation

* Set up a Python virtual environment for the backend and install the requirements from `backend/html/app/requirements.txt`.
* Set the backend configuration variables in `backend/html/app/config.py`.
* When running the backend with gunicorn (recommended) set the gunicorn
  configuration in `backend/html/app/gunicorn_config.py`.
* Set up the catapult, for instance in `backend/data/catapult`.
* Set up a Python virtual environment for the catapult and install the requirements from `catapult/requirements.txt`.
* Set the catapult configuration variables in `catapult/config.sh`.
* From within the `catapult` directory run `make` to build `catalaunch`.
* Set up the Sparv pipeline, for instance in `backend/data/pipeline` and build the pipeline models.
  You will not need to setup a virtual environment for the pipeline. Set the `VENV_PATH` to the
  catapult virtual environment.
* Start the catapult by running `./start-server.sh` (from within the `catapult` directory).
* Run the script `index.py` in the `backend` directory.
  This can be done by running it directly from the python interpreter or by starting a
  WSGI server using gunicorn (recommended): `html/app/venv/bin/gunicorn -c html/app/gunicorn_config.py index`.
* Set up the cron jobs listed in `catapult/cronjobs` for the automatic
maintenance of Sparv.
