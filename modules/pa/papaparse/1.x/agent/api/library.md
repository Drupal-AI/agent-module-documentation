<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `papaparse/papaparse` asset library — declaration and consumption

Source of truth: `papaparse.libraries.yml` (the module's only functional file besides
`papaparse.info.yml`). This module has no PHP.

## Install / enable

- `drush en papaparse -y` (or via the Extend UI). No configuration step exists; the module has
  no settings form and no `configure` route.
- Enabling only *registers* the library. Nothing loads on the page until some module or theme
  attaches `papaparse/papaparse`.

## What the library declaration contains

From `papaparse.libraries.yml`:

```
papaparse:
  remote: https://github.com/mholt/PapaParse
  version: 5.3.0
  license:
    name: MIT
    url: https://raw.githubusercontent.com/mholt/PapaParse/master/LICENSE
    gpl-compatible: true
  js:
    <PapaParse 5.3.0 min file>:
      { type: external, minified: true }
```

- One library, machine name `papaparse` → referenced everywhere as **`papaparse/papaparse`**
  (`<extension>/<library-name>`).
- The single `js` entry is flagged `type: external`, so Drupal emits a `<script src="…">` that the
  browser fetches at page render; `minified: true` tells the aggregator it is already minified.
- `remote:` + `license:` are the Drupal metadata required for declaring a third-party library.
- No `css:`, no `dependencies:`, no `header:` key — PapaParse is standalone and loads in the
  footer by default.

## How to consume it

Attach from a render array / preprocess:

```php
$build['#attached']['library'][] = 'papaparse/papaparse';
```

Depend on it from your own library in `mymodule.libraries.yml`:

```yaml
mymodule.csv-import:
  js:
    js/csv-import.js: {}
  dependencies:
    - papaparse/papaparse
    - core/drupal
```

Then in your JavaScript the global `Papa` is available:

```js
Papa.parse(fileOrString, { header: true, worker: true, complete: (res) => { /* res.data */ } });
Papa.unparse(arrayOfRows);
```

## Operating notes

- Version pinning: the site gets exactly PapaParse **5.3.0**; to change versions you patch/fork
  `papaparse.libraries.yml` (there is no UI or config to select a version).
- Because there is no PHP, nothing about this module needs cache-clearing beyond the normal
  library-info cache: run `drush cr` after editing `papaparse.libraries.yml`.
- To confirm it is wired up, load a page where a dependent library is attached and check that a
  `<script>` for the PapaParse file is present and `window.Papa` is defined in the browser console.
