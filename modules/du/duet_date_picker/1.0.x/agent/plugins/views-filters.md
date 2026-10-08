<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views filter handlers (Duet date pickers on exposed filters)

Three handlers in `src/Plugin/views/filter/`, each subclassing the matching base date filter and
adding one option — a `duet` checkbox — that swaps the exposed value input for a Duet picker. They
**do not build query conditions themselves**: `query()` and all condition/placeholder logic are
inherited unchanged from the parent core/Search API filter (Views query API, parameterized — no raw
SQL, no SQLi surface added). They only alter the *form* of the exposed value element.

## The three classes

| Class | id (`@ViewsFilter`) | Extends |
|---|---|---|
| `DuetDate` | `duet_date` | `Drupal\views\Plugin\views\filter\Date` |
| `DuetDateTime` | `duet_datetime` | `Drupal\datetime\Plugin\views\filter\Date` |
| `DuetSearchApiDate` | `duet_search_api_date` | `Drupal\search_api\Plugin\views\filter\SearchApiDate` |

## How they are activated

`duet_date_picker.views.inc` implements `hook_views_plugins_filter_alter()` and **replaces the
class** of the existing `date`, `datetime`, and `search_api_date` filter plugins with the Duet
subclasses (only if that plugin key exists). So every date/datetime/Search-API-date Views filter
gains the option; the Duet picker is applied only when its checkbox is on.

## Per-class behavior (identical shape)

- `defineOptions()` adds `duet` (default `FALSE`).
- `buildOptionsForm()` adds a `duet` checkbox: *"Use Duet date picker (only allows date, not time
  selection"*. (Duet supplies date only, so pair it with date-granularity views filters — see the
  `views.inc` note about core issue 2868014.)
- `valueForm()` calls `parent::valueForm()`, and when `options['duet']` is on:
  - attaches library `duet_date_picker/duet-date-picker`;
  - resolves the field identifier (`options['expose']['identifier']` if exposed, else `$this->field`)
    and reads any current value from `$form_state->getUserInput()`;
  - sets `#theme = 'duet_date_picker'`, `#name = <identifier>`, and `#default_value` on the value
    element(s): `value.value` or `value`, and for `DuetSearchApiDate` also the `value.min` /
    `value.max` pair (`#name = <identifier>[min]` / `[max]`).

## Config schema

`config/schema/duet_date_picker.filter.schema.yml`: `views.filter.duet_date` (extends
`views.filter.date`) and `views.filter.duet_datetime` (extends `views.filter.datetime`), each adding
`duet: boolean`; plus `views.filter_value.duet_date` / `duet_datetime`. (No custom schema entry for
`duet_search_api_date`; it reuses the Search API filter schema.)

## Operating

Edit a View → add/edit a date, datetime, or Search API date filter → check **Use Duet date picker**.
Requires `views` (and `search_api` for the Search API filter) enabled. Because Duet is date-only,
prefer it where time granularity is not needed on the exposed filter.
