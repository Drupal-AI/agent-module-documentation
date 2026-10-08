<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PapaParse (papaparse) — agent index

A **library-wrapper module**. It registers one Drupal asset library, `papaparse/papaparse`,
that loads the third-party **PapaParse** JavaScript CSV parser (v5.3.0) so other modules/themes
can depend on it. Package `csv`. Core `^10 || ^11`. License GPL-2.0-or-later. Version dir `1.x`
(packaged `1.0.1`).

- **How the library is declared and how to attach/consume it** →
  [api/library.md](api/library.md)

## What it actually is

- Two files only: `papaparse.info.yml` and `papaparse.libraries.yml`. **No** `src/`, no `.module`,
  no `.install`, no routing, no permissions, no services, no config, no schema, no submodules,
  no Drush, no plugins, no hooks.
- `papaparse.libraries.yml` defines a single library `papaparse` with a `js` entry marked
  `{ type: external, minified: true }` pointing at the PapaParse 5.3.0 file, `remote:` and MIT
  `license:` metadata, and library `version: 5.3.0`.
- Enabling the module has no runtime effect on its own — it only makes `papaparse/papaparse`
  available for other code to depend on. The `Papa` JS global appears only on pages where a
  dependent library is attached.

## Mechanism (from source)

- Consumers depend on it via `dependencies: [ papaparse/papaparse ]` in their own `*.libraries.yml`,
  or attach it directly: `$build['#attached']['library'][] = 'papaparse/papaparse';`.
- No PHP surface means no access-control, database, HTTP, or input-handling code paths in the
  module itself; any behaviour comes entirely from the JavaScript that consuming code writes
  against the `Papa` API.
