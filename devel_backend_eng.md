
This document describes the internal structure of the Sparv backend
and its usage of the catapult and can be used as a developer's guide.

## <a name="backend"></a>Backend

The backend is run through the WSGI script `index.py`.
It is available at [https://spraakbanken.gu.se/ws/sparv/v2/](https://spraakbanken.gu.se/ws/sparv/v2/).

### <a name="be-requirements">Requirements

* the Korp corpus pipeline (see [here](https://spraakbanken.gu.se/eng/research/infrastructure/sparv/distribution/pipeline) for installation instructions)
* [Python 3.4](https://www.python.org/) or newer
* A WSGI server


### Python virtual environment

Though it is not required, we recommend that you use a Python virtual
environment to run the Sparv backend. This is the easiest way
to ensure that you have all the Python dependencies needed to run the modules.

Set up a Python virtual environment as a subdirectory to the `backend/html/app` directory:

    python3 -m venv venv

Activate the virtual environment and install the required Python packages:

    source venv/bin/activate
    pip install -r requirements.txt

You can then deactivate the virtual environment:

    deactivate

### Backend Configuration

The configuration variables are stored in `html/app/config.py`:

 * `backend`: the address where the backend is hosted
 * `sparv_python`: the Python path to the sparv pipeline python directory
 * `sparv_backend`: the path to the backend directory
 * `builds_dir`: the directory that hosts running and completed builds
 * `log_dir`: location of the log files. Can be set to `None` to log to stdout.
 * `sparv_models`: location of the sparv pipeline models
 * `sparv_makefiles`: location of the sparv pipeline makefiles
 * `secret_key`: a string of your choosing. It is needed for queries that may cause deletions of builds.
 * `venv_path`: path to the activation script of the Python virtual environment (may be set to None)
 * `processes`: number of processes that `make` will run while annotating
 * `fileupload_ext`: extension used for builds that contain file uploads
 * `socket_file`: path to the socket file used to communicate with the catapult
 * `catalaunch_binary`: path to the catalaunch binary file
 * `python_interpreter`: "Python" interpreter, replaced with catalaunch

When running the backend with gunicorn (recommended) you may also want to modify
the configuration in `html/app/gunicorn_config.py`.

The recommended place for the Sparv pipeline is the directory `data/pipeline`.

### Running the Backend

The backend is set up to be run with gunicorn which is installed automatically inside the Python
virtual environment. From the backend directory you can run the following command:

    html/app/venv/bin/gunicorn -c html/app/gunicorn_config.py index

This will start a WSGI server and bind it to the socket defined in `gunicorn_config.py`.
Log messages are written to the file specified in the same file (or to the terminal
if nothing is specified).

The backend also be started by running `index.py` with the Python interpreter but this is
mostly used for development or debugging.

### Makefile and Settings JSON Schema

The makefile for each corpus is created from a JSON object that must satisfy one of the
JSON schemas stored in the backend (the default schema being `backend/settings_schema_sv.json`).
The frontend builds its form based on the requested schema. New entries can be added
and the frontend should render them automatically. The file that creates the makefile is
`backend/make_makefile.py`.

## <a name="catapult"></a>Catapult

The catapult runs a Python instance that shares the loaded lexicons, keeps
malt processes running and lowers the Python interpreter startup time.
Scripts are run on the catapult with the tiny c program `catalaunch`.

### Requirements

* [GCC](http://gcc.gnu.org/install) for compiling the `catapult` C extension
* [Python 3.4](https://www.python.org/) or newer

### Catapult setup

The catapult can for example be placed inside the `backend/data` directory.

Just as for the Sparv backend we recomment that you use a Python virtual environment
for running the catapult. Check the [backend requirements](#be-requirements) for instructions.
The standard location for installing the virtual environment for the catapult is inside the
`catapult` directory.

After setting up the Python virtual environment you will to adapt the variable `VENV_PATH`
in the Sparv pipeline in `/makefiles/Makefile.config` so it points to the catapult virtual environment.

### Catapult Configuration

The configuration variables are stored in `config.sh`:

 * `SPARV_PYTHON`: the path to the `sb` pipeline Python directory
 * `SPARV_MODELS`: location of the `sb` pipeline models
 * `SPARV_BIN`: location of the `sb` pipeline binaries
 * `SPARV_MAKEFILES`: location of the pipeline makefiles
 * `CATAPULT_DIR`: location of the catapult directory
 * `BUILDS_DIR`: the directory that hosts running and completed builds
 * `LOGDIR`: the path to the log file directory
 * `CATAPULT_VENV`: the path to the Python virtual environment used by the catapult

### Running the Catapult

  * Run `make` to build `catalaunch`.
  * Run `./start-server.sh` to start the catapult.
  * Set up the [cron jobs](#cronjobs) listed in `catapult/cronjobs`
  for the automatic maintenance of Sparv.

### <a name="cronjobs"></a>Cron jobs

The following cron jobs are used in Sparv:

  * *Cleanup*: Builds that have not been accessed for 7 days are removed every midnight by
  issuing `https://ws.spraakbanken.gu.se/ws/sparv/cleanup?secret_key=SECRETKEY`.
  * *Keep-alive*: The script `catapult/keep-alive.sh` is run every five minutes and restarts
 the catapult with `catapult/start-server.sh` if it does not respond to ping. Instead of
 setting up this cron job you can run the catapult using a process control system like supervisord.
  * *Update-saldo*: The Saldo lexicon is updated daily with the script `catapult/update-saldo.sh`.
  This takes some time, and is therefore run during the night. The catapult is restarted
  afterwards by the `keep-alive.sh` script.
