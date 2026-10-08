<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The AmplitudeJS library asset

The base `amplitudejs` module's entire job is to register one Drupal asset library.

## Definition (`amplitudejs.libraries.yml`)

```yaml
amplitudejs:
  remote: https://github.com/521dimensions/amplitudejs
  version: 5.3.2
  license: { name: MIT, url: ..., gpl-compatible: true }
  js:
    /libraries/amplitudejs/dist/amplitude.min.js: { minified: true }
```

Library id to attach: **`amplitudejs/amplitudejs`**. It has no CSS and no dependencies. The path
begins with a leading `/`, so Drupal serves it from the **web root** at
`/libraries/amplitudejs/dist/amplitude.min.js` — i.e. a `libraries/` folder at the docroot, not
inside the module.

## Installing the JS file (required — not shipped)

The module does **not** vendor the AmplitudeJS script. Provide it one of two ways:

- Composer (if the project is set up for npm-asset packages):
  `composer require npm-asset/amplitudejs:^5.3`
- Manual: download `https://cdn.jsdelivr.net/npm/amplitudejs@5.3.2/dist/amplitude.min.js` and copy it
  to `/libraries/amplitudejs/dist/`.

If the file is absent the library resolves to a 404 and any player silently fails to initialize
(`Amplitude` is undefined in the browser).

## Enabling

`drush en amplitudejs` — this alone only makes the library available. Enable it standalone if you
are hand-building a player in a custom module/theme; enable `amplitudejs_formatters` too if you want
the ready-made field-formatter players.

## Attaching it yourself

From a render array: `$build['#attached']['library'][] = 'amplitudejs/amplitudejs';` then initialize
the player in your own JS with `Amplitude.init({...})`. The formatters submodule is the reference
implementation of doing this (see its `js/amplitudejs-players-init.js`).

## Help page

`amplitudejs_help()` handles route `help.page.amplitudejs`: it `file_get_contents()`s the module's
own `README.md` and, if the contrib **markdown** module is enabled, runs it through the `markdown`
filter plugin (using `markdown.settings`); otherwise it wraps the raw text in `<pre>`. The path is a
fixed `dirname(__FILE__) . '/README.md'` — not user input.
