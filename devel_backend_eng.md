
This document describes the internal structure of the Sparv backend
and its usage of the catapult and can be used as a developer's guide.

## <a name="backend"></a>Backend

The backend is run through the WSGI script `backend.wsgi`.
It is available at [https://spraakbanken.gu.se/ws/sparv/v1/](https://spraakbanken.gu.se/ws/sparv/v1/).

### Requirements

* the Korp corpus pipeline (see [here](https://spraakbanken.gu.se/eng/research/infrastructure/sparv/distribution/pipeline) for installation instructions)
* [Python 2.6](https://www.python.org/) or newer (but not 3.x)
* A WSGI server

### Backend Configuration

The configuration variables are stored in `config.py`:

 * `backend`: the address where the backend is hosted
 * `sb_python`: the python path to the `sb` pipeline python directory
 * `al_backend`: the path to the backend directory
 * `builds_dir`: the directory that hosts running and completed builds
 * `log_file`: location of the log. It can be set to `None` to log to stdout.
 * `sb_models`: location of the `sb` pipeline models
 * `processes`: number of processes that `make` will run while annotating

### Running the Backend

The backend can either be started manually by running `index.wsgi` with the python interpreter
or if the backend directory is loaded via the Apache Web Server the WSGI script will be loaded
automatically by Apache (due to the existence of the `.htaccess` file).

If the backend is run with the python interpreter directly, it will try to use
the eventlet WSGI implementation if it exists. Otherwise it falls back on the
reference implementation. Eventlet is preferred because it handles concurrent
requests.

When making changes in the backend the WSGI script must be restarted (e.g.
by running `touch index.wsgi`) in order for the changes to take effect.

### Makefile and Settings JSON Schema

The makefile for each corpus is created from a JSON object that must satisfy one of the
JSON schemas stored in the backend (the default schema being `backend/settings_schema_sv.json`).
The frontend builds its form based on the requested schema. New entries can be added
and the frontend should render them automatically. The file that creates the makefile is
`backend/make_makefile.py`.

## <a name="catapult"></a>Catapult

The catapult runs a python instance that shares the loaded lexicons, keeps
malt processes running and lowers the python interpreter startup time.
Scripts are run on the catapult with the tiny c program `catalaunch`.

### Requirements

* [GCC](http://gcc.gnu.org/install) for compiling the `catapult` C extension
* [Python 2.6](https://www.python.org/) or newer (but not 3.x)

### Catapult Configuration

The configuration variables are stored in `config.sh`:

 * `SB_PYTHON`: the path to the `sb` pipeline python directory
 * `SB_MODELS`: location of the `sb` pipeline models
 * `SB_BIN`: location of the `sb` pipeline binaries
 * `SB_MAKEFILES`: location of the pipeline makefiles
 * `CATAPULT_DIR`: location of the catapult directory
 * `BUILDS_DIR`: the directory that hosts running and completed builds

### Running the Catapult

  * Run `make` to build `catalaunch`.
  * Run `./start-server.sh` to start the catapult.
  * Set up the [cron jobs](#cronjobs) listed in `catapult/cronjobs` for the automatic
  maintenance of Sparv.

### <a name="cronjobs"></a>Cron jobs

The following cron jobs are used in Sparv:

  * *Cleanup*: Builds that have not been accessed for 24 hours are removed every midnight by
  issuing `https://ws/spraakbanken.gu.se/ws/sparv/v1/cleanup`.
  * *Keep-alive*: The script `catapult/keep-alive.sh` is run every five minutes and restarts
 the catapult with `catapult/start-server.sh` if it does not respond to ping.
  * *Update-saldo*: The Saldo lexicon is updated daily with the script `catapult/update-saldo.sh`.
  This takes some time, and is therefore run during the night. The catapult is restarted
  afterwards by the `keep-alive.sh` script.
