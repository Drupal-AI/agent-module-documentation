<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CountUp Formatter (countup_formatter) — agent index

A single **field formatter** that renders integer / decimal / float fields as an animated number
**counting up** from a start value to the field value when the element scrolls into the viewport,
via the **countUp.js** library. Package `Fields`. Core `^9.2 || ^10 || ^11`. License
GPL-2.0-or-later. Version 1.x (installed 1.0.1).

- **The formatter, every setting, the library requirement, and the JS behavior** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `CountUpFormatter` (id **`countup_formatter_countupformatter`**, label *"CountUp"*),
  in `src/Plugin/Field/FieldFormatter/CountUpFormatter.php`, extending core's
  **`NumericFormatterBase`**. `field_types = { "integer", "decimal", "float" }`.
- **No** dependencies in `.info.yml`, **no** routes, permissions, services, hooks, `.install`,
  `config/**` (no config schema), Drush, or submodules. It only changes how a numeric field is
  **displayed**, chosen per view-display on *Manage display*.
- Ships one behavior file `js/countup.js` (`Drupal.behaviors.countupformatter`) and library
  definitions in `countup_formatter.libraries.yml`.

## Mechanism (from source)

- `defaultSettings()` adds `thousand_separator` (''), `decimal_separator` ('.'), `scale` (2),
  `prefix_suffix` (TRUE), `start_val` (0), `duration` (2), `prefix` (''), `suffix` ('') on top of
  the numeric base.
- `numberFormat()` uses PHP `number_format($number, scale, decimal_separator, thousand_separator)`.
- `viewElements()` renders each item as `#markup => $output` (the formatted number) with
  `#field_prefix`/`#field_suffix` (from **field** settings, via `FieldFilteredMarkup`) and an
  `#attributes` bag carrying the countUp config as **`data-*`** attributes (`data-startVal`,
  `data-endVal`, `data-duration`, `data-prefix`, `data-suffix`, `data-decimal`, `data-separator`,
  `data-useGrouping`, `data-decimalPlaces`, `data-enableScrollSpy`) plus class `countup-formatter`.
  It attaches library **`countup_formatter/countup`**.
- `js/countup.js` binds debounced `DOMContentLoaded load resize scroll` handlers; `checkVisibility()`
  finds `.countup-formatter:not(.countup-processed)` fully inside the viewport, marks it processed,
  and calls `new countUp.CountUp(element, end, options).start()`.

## Library requirement (external)

- The countUp.js library is **not bundled**. Library `countup-lib` loads
  **`/libraries/countup.js/dist/countUp.umd.js`** — a **local** path you must populate by installing
  `inorganik/countup-js` (2.4.2+) manually or via composer-merge-plugin (see README /
  `composer.libraries.json`). Missing library → `js/countup.js` returns early and the plain number
  is shown with no animation.

## Settings quick list

`thousand_separator`, `decimal_separator` (point/comma), `scale` (0–10 decimals), `prefix_suffix`,
`start_val` (required), `duration` (seconds), `prefix`, `suffix`. Details, the `data-*` mapping,
and an export example → [fields/formatter.md](fields/formatter.md).
