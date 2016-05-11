
This document describes the internal structure of the Sparv frontend
and can be used as a developer's guide.

The frontend is available at
[https://spraakbanken.gu.se/sparv/](https://spraakbanken.gu.se/sparv/).

### Requirements

 * Node v0.10.x, which should be installed through you package manager. This should by default include NPM, the node package manager.
 * [Grunt](http://gruntjs.com/), install using `npm install -g grunt-cli`.
 * CoffeeScript, install using `npm install -g coffeescript`.
 * Sass, install using `npm install sass`.

### Frontend Configuration

 The `app/config.js` file contains the configuration of the backend address, the
 address to the default settings JSON schema and also the address to [Karp](https://spraakbanken.gu.se/karp/).

### Running the Frontend

 For running the frontend locally (while developing) run `grunt serve`.
 In you browser, open `http://localhost:9010` to launch Sparv.
 While running `grunt serve` so the CoffeeScript and Sass files will automatically
 be compiled upon edit, additionally causing the browser window to be reloaded to
 reflect the new changes.

 Before releasing a new version, the scripts are compiled by running `grunt` in the frontend directory.
 This will create a directory called `dist` which contains all the files necessary
 to run the frontend.
