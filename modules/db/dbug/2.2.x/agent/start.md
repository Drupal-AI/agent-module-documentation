# dBug for Drupal — agent index

A single-class developer utility that dumps any PHP variable as a colored, collapsible HTML
table (a Drupal port of ColdFusion's `cfdump`). No routes, config, permissions, plugins,
Drush, or hooks. You call one static method and attach one asset library.

- **How to call `Dbug::debug()`, the `forceType`/`bCollapsed` args, attaching `dbug/dbug`,
  and how each type renders** → [api/debug.md](api/debug.md)

Key facts:
- Entry point: `\Drupal\dbug\Dbug::debug($var, string $forceType = '', bool $bCollapsed = FALSE)`
  returns an HTML **markup string** (it does **not** echo).
- Attach `dbug/dbug` (`js/dBug.js` + `css/dBug.css`) for styling and expand/collapse.
- Arrays → `class="dBug_array"` tables; objects → `class="dBug_object"` (methods shown as
  `[function]`); booleans render as `TRUE`/`FALSE`; recursion shows `*RECURSION*`.
- `forceType` accepts `"array"`, `"object"`, `"xml"` (required for XML string/file input).
