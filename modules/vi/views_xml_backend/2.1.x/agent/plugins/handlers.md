<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views XML Backend — handlers & data columns

All plugins live under `src/Plugin/views/`. Data columns are declared in
`views_xml_backend.views.inc` (`hook_views_data`) on the `views_xml_backend` base table. Config
schema for each option set is in `config/schema/views_xml_backend.views.schema.yml`.

## Query plugin
- **`views_xml_backend`** — `src/Plugin/views/query/Xml.php`, `@ViewsQuery`. Replaces the SQL
  engine. Options: `xml_file`, `row_xpath`, `default_namespace` (default `default`), `show_errors`
  (default TRUE). `query()` builds `row_xpath` then appends `[filters and …][arguments and …]`.
  `getCacheMaxAge()` returns `0` (results not cached by Views render cache). `ensureTable()` is a
  no-op; `addOrderBy()` only supports the core `rand` sort (via `shuffle`). `addWhere()` handles
  the `in` operator (used by exposed grouped filters) by escaping each value and OR-joining.

## Data columns (hook_views_data)
Each column maps to handler plugin IDs per handler kind:

| Column | title | field | filter | sort | argument |
|--------|-------|-------|--------|------|----------|
| `text` | XML Text | `_standard` | `_standard` | `_standard` | `_standard` |
| `numeric` | XML Number | `_standard` | `_numeric` | `_numeric` | `_numeric` |
| `date` | XML Date | `_date` | `_date` | `_date` | `_date` |
| `date_year` | XML Year | — | — | — | `_date_year` |
| `date_month` | XML Month | — | — | — | `_date_month` |
| `date_day` | XML Day | — | — | — | `_date_day` |
| `markup` | HTML Markup | `_markup` | — | — | — |
| `passthrough` | Pass through | — | — | — | `_passthrough` |

(IDs are prefixed `views_xml_backend`.) Every non-passthrough handler exposes an `xpath_selector`
textfield evaluated relative to the row node.

## Field handlers (`src/Plugin/views/field/`)
- **`views_xml_backend_standard`** (`Standard`) — multi-value text field
  (`MultiItemsFieldHandlerInterface`). Display `type` = ul / ol / separator (default `, `).
  `clickSort()` adds a `StringSorter`.
- **`views_xml_backend_markup`** (`Markup` extends `Standard`) — renders each value through a
  chosen text **`format`** via `#type => processed_text` (`renderer->renderPlain`); strips
  `<!--break-->`. Format list comes from `filter_formats($currentUser)`.
- **`views_xml_backend_date`** (`Date` extends core Views `Date` field) — parses the value with
  `views_xml_backend_date()` (optional `xml_date_format`) then delegates to core date rendering;
  `clickSort()` adds a `DateSorter`.

## Filter handlers (`src/Plugin/views/filter/`) — emit XPath predicates
- **`views_xml_backend_standard`** (`Standard` extends `StringFilter`) — operators `=`, `!=`,
  `contains`, `!contains`, `starts-with`/`!starts-with`, `ends-with`/`!ends-with`. Emits e.g.
  `xpath = 'v'`, `contains(xpath, 'v')`, `not(starts-with(xpath, 'v'))`.
- **`views_xml_backend_numeric`** (`Numeric` extends `NumericFilter`) — comparisons plus
  `between` / `not between`; regex operator removed. Emits `xpath >= min and xpath <= max` etc.
- **`views_xml_backend_date`** (`Date` extends core `Date` filter) — `granularity`
  (second…year), optional `xml_date_format`; emits
  `php:functionString('views_xml_backend_date', xpath, 'granularity', fmt) <op> <timestamp>`.
- All values pass through `Xpath::escapeXpathString()` (`src/Xpath.php`): wraps in `'`…`'`, or
  `"`…`"`, or a `concat()` when both quote types appear — prevents breaking out of the XPath
  string literal.

## Sort handlers (`src/Plugin/views/sort/`) — sort in PHP, not XPath
Each `query()` registers an extra field (the selector) via `$query->addField()` and pushes a
`Sorter` callable via `$query->addSort()`; the query plugin applies them with `array_reverse`
(stable, re-indexed between passes).
- **`views_xml_backend_standard`** → `Sorter\StringSorter`.
- **`views_xml_backend_numeric`** → `Sorter\NumericSorter`.
- **`views_xml_backend_date`** → `Sorter\DateSorter` (honours `xml_date_format`).

## Argument handlers (`src/Plugin/views/argument/`) — emit XPath predicates
Implement `XmlArgumentInterface::__toString()`.
- **`views_xml_backend_standard`** (`Standard`) — `xpath = 'value'` (escaped).
- **`views_xml_backend_numeric`** (`Numeric extends Standard`) — same, numeric column.
- **`views_xml_backend_date`** (`Date` extends core `Date` argument) — emits
  `php:functionString('views_xml_backend_format_value', xpath, argFormat, fmt) = value`.
- **`views_xml_backend_date_year` / `_date_month` / `_date_day`** (`YearDate` / `MonthDate` /
  `DayDate` extend `Date`) — date-granularity contextual filters.
- **`views_xml_backend_passthrough`** (`Passthrough`) — `query()` is a no-op; adds **no**
  predicate. Use only to make an argument value available for token replacement (e.g. inside
  `xml_file` or a rewritten field), not to filter rows.

## Traits & helpers
- `AdminLabelTrait` — admin label shows `"<xpath>: <title>"`.
- `Plugin/views/field/XmlFieldHelperTrait` — shared field options (`xpath_selector`, `type`,
  `separator`), `getItems`/`renderItems` (safe_join / item_list).
- `XmlDateHelperTrait` — shared `xml_date_format` option + form.
- `views_xml_backend_date()` / `views_xml_backend_format_value()` (`.module`) — the two PHP
  functions registered for XPath (`php:functionString`); round dates to a granularity / format a
  date, with a 4-digit-year shim and `DateTime::createFromFormat` custom-format support.
