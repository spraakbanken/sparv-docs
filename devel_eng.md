
This document describes the internal structure of the Annotation Laboratory
and can be used as a developer's guide.
The Annotation Laboratory is split into three parts, the [WSGI backend](#backend),
the [web frontend](#frontend), and the [catapult](#catapult).

## <a name="backend"></a>Backend

The backend is run through the WSGI script `backend.wsgi`.
It is available at [http://spraakbanken.gu.se/ws/korp/annotate](http://spraakbanken.gu.se/ws/korp/annotate).

### Requirements

* the Korp corpus pipeline (see [here](http://spraakbanken.gu.se/eng/research/infrastructure/korp/distribution/corpuspipeline) for installation instructions)
* [Python 2.6](https://www.python.org/) or newer (but not 3.x)
* A WSGI server

### Backend Configuration

The configuration variables are stored in `config.py`:

 * `backend`: the address where the backend is hosted
 * `sb_python`: the python path to the `sb` pipeline python directory
 * `al_backend`: the path to the backend directory
 * `builds_dir`: the directory that hosts running and completed builds
 * `log_file_location`: location of the log. It can be set to `None` to log to
   stdout.
 * `sb_models`: location of the `sb` pipeline models

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

## <a name="frontend"></a>Frontend

 The frontend is available at
 [http://spraakbanken.gu.se/korp/annoteringslabbet](http://spraakbanken.gu.se/korp/annoteringslabb).

### Requirements

 * Node v0.10.x, which should be installed through you package manager. This should by default include NPM, the node package manager.
 * [Grunt](http://gruntjs.com/), install using `npm install -g grunt-cli`.
 * CoffeeScript, install using `npm install -g coffeescript`.
 * Sass, install using `npm install sass`.

### Frontend Configuration

 The `app/config.js` file contains the configuration of the backend address, the
 address to the default settings JSON schema and also the address to [Karp](http://spraakbanken.gu.se/karp/).

### Running the Frontend

 For running the frontend locally (while developing) run `grunt serve`.
 In you browser, open `http://localhost:9002` to launch the Annotation Laboratory.
 While running `grunt serve` so the CoffeeScript and Sass files will automatically
 be compiled upon edit, additionally causing the browser window to be reloaded to
 reflect the new changes.

 Before releasing a new version, the scripts are compiled by running `grunt` in the frontend directory.
 This will create a directory called `dist` which contains all the files necessary
 to run the frontend.

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
 * `CATAPULT_DIR`: location of the catapult directory
 * `BUILDS_DIR`: the directory that hosts running and completed builds

### Running the Catapult

  * Run `./setup-server.sh` to fetch the makefiles needed to run the pipeline
  and to build `catalaunch`.
  * Run `./start-server.sh` to start the catapult.
  * Set up the [cron jobs](#cronjobs) listed in `catapult/cronjobs` for the automatic
  maintenance of Annotation Laboratory.

### <a name="cronjobs"></a>Cron jobs

The following cron jobs are used in the Annotation Laboratory:

  * *Cleanup*: Builds that have not been accessed for 24 hours are removed every midnight by
  issuing `http://spraakbanken.gu.se/ws/korp/annotate/cleanup`.
  * *Keep-alive*: The script `catapult/keep-alive.sh` is run every five minutes and restarts
 the catapult with `catapult/start-server.sh` if it does not respond to ping.
  * *Update-saldo*: The Saldo lexicon is updated daily with the script `catapult/update-saldo.sh`.
  This takes some time, and is therefore run during the night. The catapult is restarted
  afterwards by the `keep-alive.sh` script.
