<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Datepicker JS behavior

Library `facets_range_datepicker_widget/datepicker` (`facets_range_datepicker_widget.libraries.yml`): loads
`js/datepicker.js` with `defer: true`, depends on `core/drupal` + `core/drupalSettings`. Attached by the widget's
`build()` (see [../plugins/widgets.md](../plugins/widgets.md)).

## `Drupal.behaviors.facet_datepicker` (`js/datepicker.js`)

On `attach`, binds `change` handlers to the date inputs:

- `.facets-widget-datepicker input[data-type=datepicker-min]` → `autoSubmit`.
- `.facets-widget-range_datepicker input[data-type=datepicker-min]` and `…[data-type=datepicker-max]` →
  `autoRangeSubmit`.

### `autoSubmit()` (single day)

- Finds the facet id from `.facets-widget-datepicker ul[data-drupal-facet-id]`.
- Reads the server-supplied token URL from `settings.facets.datepicker[facetId].url` (set by the widget from the
  processor's `build()` output).
- `datePickerValue = toTimestamp(minInput.val())`; if truthy, produces
  `facetUrl.replace('__datepicker_min__', datePickerValue)`; otherwise keeps `window.location.href`.
- Navigates via `window.location.href = redirectUrl`.

### `autoRangeSubmit()` (range)

- Same lookup of facet id + `settings.facets.datepicker[facetId].url`.
- `min = toTimestamp(minInput.val())`, `max = toTimestamp(maxInput.val())`, then substitutes
  `__range_datepicker_min__` / `__range_datepicker_max__` into the URL:
  - both present → both placeholders replaced;
  - min only → min replaced, max replaced with `''`;
  - max only → min replaced with `''`, max replaced.
- Navigates via `window.location.href`.

### `toTimestamp(strDate)`

`return Date.parse(strDate) / 1000;` — converts the `<input type="date">` value (ISO `YYYY-MM-DD`) to a UNIX
timestamp (seconds); an unparseable value yields `NaN`.

## Notes

- The value substituted into the URL is a numeric timestamp from `Date.parse()/1000`, and the base URL is the
  server-generated facet URL from `drupalSettings`. The script performs a full-page navigation
  (`window.location.href`); the picked value only ever becomes a query parameter that the processor's
  `preQuery()` re-parses with a strict numeric regex.
- Auto-submit fires on the `change` event, so no separate apply button is rendered.
- `Drupal.facets` is namespaced (`Drupal.facets = Drupal.facets || {}`) but the timestamp/redirect logic is
  self-contained in this file.
