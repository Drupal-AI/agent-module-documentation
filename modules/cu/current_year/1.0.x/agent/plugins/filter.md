<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `filter_current_year` input filter

Source: `src/Plugin/Filter/CurrentYearFilter.php`, `current_year.libraries.yml`, `js/current_year.js`.

## Install & enable

- `drush en current_year -y` (or Extend UI). No dependencies beyond core **Filter** (always on).
- Go to **Administration → Configuration → Content authoring → Text formats and editors**
  (`/admin/config/content/formats`), edit a format (e.g. *Basic HTML*, *Full HTML*), tick
  **Current Year** in *Enabled filters*, and save. Optionally reorder it under *Filter processing order*.
- No permission, route, config object, or admin settings form is added by this module — enabling
  is done entirely through core's text-format screens. The filter itself exposes **no settings**
  (it does not override `settingsForm()` / `defaultConfiguration()`).

## Plugin definition

- Class `CurrentYearFilter extends \Drupal\filter\Plugin\FilterBase`.
- `@Filter` annotation: `id = "filter_current_year"`, `title = "Current Year"`,
  `description = "This filter enables &year; to be replaced by the current year."`,
  `type = FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE`.
- `TYPE_TRANSFORM_IRREVERSIBLE` means it transforms output and cannot be reversed to the source, so
  it is unavailable to editors that need round-tripping; place it appropriately in the filter order
  (typically after HTML-restricting filters so the injected span survives).

## What `process()` does

- `process($text, $langcode)` → `new FilterProcessResult($this->currentYearise($text))`, then
  `->setAttachments(['library' => ['current_year/current_year']])` so the JS attaches whenever the
  filter runs.
- `currentYearise($text)` runs one regex: `preg_replace_callback('|\&(amp;)?year\;|', …)`.
  - Matches the literal `&year;` and the HTML-entity-encoded form `&amp;year;` (so it works whether
    or not an earlier filter/editor encoded the ampersand).
  - Callback returns: `'<span class="js-current-year">' . date('Y') . '</span>'`.
  - The replacement year is `date('Y')` — a server-side computed 4-digit integer. No user- or
    request-supplied data is inserted; the surrounding markup is a fixed literal string.
- `tips($long = FALSE)` returns *"The token &year; will be replaced with the current year."* (shown
  in the format's filter tips).

## Client-side fallback (`js/current_year.js`)

- Library `current_year/current_year` = `js/current_year.js` + dependency `core/drupal`.
- `Drupal.behaviors.currentYear.attach(context)` computes `String(new Date().getFullYear())` and,
  via `once('current-year', '.js-current-year', context)`, sets each span's `textContent` to that
  value if it differs. Using `Drupal.behaviors` means it also runs on BigPipe/AJAX-attached content.
- Purpose: if a rendered page is served from cache across a New-Year boundary, the server-baked year
  in the span may be stale; the JS corrects it in the browser. (`once` requires core's `once` library,
  provided transitively by `core/drupal`.)

## Usage

- In any field/block using a format with this filter enabled, type `&year;` where the year should
  appear. Example footer: `© &year; Acme Ltd.` renders as `© <span class="js-current-year">2026</span> Acme Ltd.`
- Style the year if wanted via the `.js-current-year` class.

## Notes

- Idempotent per render; no configuration, so nothing to export. `provides_config_schema` is false.
- Output is fixed markup wrapping a numeric year — there is no editor- or visitor-controlled value
  passing through the callback.
