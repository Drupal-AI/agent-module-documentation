<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Current Year (current_year) — agent index

A single **text-format input filter** that replaces the token `&year;` with the current
four-digit year at render time. Package `Text Formats`. No module dependencies beyond core's
**Filter**. Core requirement `^10 || ^11`. License GPL-2.0-or-later. Installed version 1.0.5.

- **The filter plugin, the token, the JS fallback, how to enable it** →
  [plugins/filter.md](plugins/filter.md)

## What it actually is

- One plugin: `CurrentYearFilter` (`@Filter` id **`filter_current_year`**, title *"Current Year"*),
  in `src/Plugin/Filter/CurrentYearFilter.php`, extending core's `FilterBase`.
  Type `TYPE_TRANSFORM_IRREVERSIBLE`.
- One JS asset library `current_year/current_year` (`current_year.libraries.yml` → `js/current_year.js`,
  depends on `core/drupal`).
- **No** routes, **no** permissions, **no** services, **no** hooks, **no** config schema,
  **no** admin form, **no** Drush, **no** submodules. Configuration is done entirely on the
  standard core *Text formats and editors* screens.

## Mechanism (from source)

- `process($text, $langcode)` returns a `FilterProcessResult` whose value is `currentYearise($text)`,
  and attaches the `current_year/current_year` library.
- `currentYearise()` runs `preg_replace_callback('|\&(amp;)?year\;|', …)`: each `&year;` (or the
  HTML-encoded `&amp;year;`) becomes `<span class="js-current-year">` + `date('Y')` + `</span>`.
  The year is a server-computed integer — no user/request input is reflected.
- `tips()` returns the help string *"The token &year; will be replaced with the current year."*
- `js/current_year.js` (`Drupal.behaviors.currentYear`) uses `once('current-year', '.js-current-year')`
  to rewrite each span's `textContent` to `new Date().getFullYear()` — a client-side fallback so a
  page-cached / BigPipe copy served after a year rollover still shows the correct year.

## Operate it

- `drush en current_year -y`, then on a text format (`/admin/config/content/formats`) tick
  **Current Year** and adjust filter order. Type `&year;` in any content using that format.
