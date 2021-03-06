resin-plugin-sync
-----------------

[![npm version](https://badge.fury.io/js/resin-plugin-sync.svg)](http://badge.fury.io/js/resin-plugin-sync)
[![dependencies](https://david-dm.org/resin-io/resin-plugin-sync.png)](https://david-dm.org/resin-io/resin-plugin-sync.png)
[![Build Status](https://travis-ci.org/resin-io/resin-plugin-sync.svg?branch=master)](https://travis-ci.org/resin-io/resin-plugin-sync)

Join our online chat at [![Gitter chat](https://badges.gitter.im/resin-io/chat.png)](https://gitter.im/resin-io/chat)

**DEPRECATED: This plugin is now included in the [Resin CLI](https://github.com/resin-io/resin-cli) by default.**

Watch a local project directory and sync it on the fly.

Requirements
------------

This plugin depends on the following programs being available from the command line:

- `rsync`
- `ssh`
- `nc`

Windows
-------

Currently, this plugin only supports [Cygwin](https://www.cygwin.com). Make sure the following packages are installed:

- `openssh`
- `rsync`
- `nc`

Installation
------------

Install `resin-plugin-sync` by running:

```sh
$ npm install -g resin-cli resin-plugin-sync
```

You can then access the `resin sync` command from your terminal.

Documentation
-------------

Run `resin help sync` for documentation.

Support
-------

If you're having any problem, please [raise an issue](https://github.com/resin-io/resin-plugin-sync/issues/new) on GitHub and the Resin.io team will be happy to help.

Tests
-----

Run the test suite by doing:

```sh
$ gulp test
```

Contribute
----------

- Issue Tracker: [github.com/resin-io/resin-plugin-sync/issues](https://github.com/resin-io/resin-plugin-sync/issues)
- Source Code: [github.com/resin-io/resin-plugin-sync](https://github.com/resin-io/resin-plugin-sync)

Before submitting a PR, please make sure that you include tests, and that [coffeelint](http://www.coffeelint.org/) runs without any warning:

```sh
$ gulp lint
```

License
-------

The project is licensed under the MIT license.
