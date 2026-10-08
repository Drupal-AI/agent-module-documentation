<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AmplitudeJS (amplitudejs) — agent index

Registers the third-party **AmplitudeJS** HTML5 audio library as a Drupal asset library, and ships an
optional **`amplitudejs_formatters`** submodule of audio-player field formatters. Package **Media**.
Core `^9.3 || ^10 || ^11`. License GPL-2.0-or-later. Version **1.0.4**.

## What the base module actually is

- **No plugins, routes, permissions, services, entities, config, or Drush.** It contributes exactly
  one Drupal library plus a help page.
- `amplitudejs.libraries.yml` defines library **`amplitudejs/amplitudejs`** → the single JS file
  `/libraries/amplitudejs/dist/amplitude.min.js` (remote `github.com/521dimensions/amplitudejs`,
  version 5.3.2, MIT). The library file is **not bundled** — it must be placed under
  `/libraries/amplitudejs/dist/` (via `composer require npm-asset/amplitudejs:^5.3` or a manual
  download). See [library/amplitudejs.md](library/amplitudejs.md).
- `amplitudejs.module` implements only `hook_help()` (`help.page.amplitudejs`): reads `README.md`
  and renders it through the contrib **markdown** filter if present, else in a `<pre>`.
- `composer.json` requires **`drupal/token: ^1.11`** (used by the submodule's formatters). The base
  `.info.yml` declares **no** Drupal module dependencies.

## Dependencies

- Base module: none in `.info.yml`; needs the on-disk AmplitudeJS JS asset to be useful.
- Submodule `amplitudejs_formatters`: `drupal:file`, `drupal:media`, `token:token`,
  `amplitudejs:amplitudejs`.

## Submodule — the actual functionality

**`amplitudejs_formatters`** provides seven field formatter plugins (media entity-reference and file
fields) that render themed AmplitudeJS players. Documented in its own tree:
[modules/amplitudejs_formatters/1.0.x/agent/start.md](modules/amplitudejs_formatters/1.0.x/agent/start.md)
and [modules/amplitudejs_formatters/1.0.x/agent/fields/formatters.md](modules/amplitudejs_formatters/1.0.x/agent/fields/formatters.md).

## Solution docs

- **Library definition, install location, attaching it yourself** → [library/amplitudejs.md](library/amplitudejs.md)
- **The formatters (settings, tokens, plugins, templates, JS)** → the submodule tree linked above.
