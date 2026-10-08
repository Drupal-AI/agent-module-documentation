# Views field: Global "Timestamp to Date"

Renders a raw integer **Unix timestamp** (produced by some other field in the same view) as a
formatted date. It does **not** add a column to the query (`query()` is empty) — it pulls the value
of a *sibling* field already present in the row, then formats it with core's date formatter.

Class: `Drupal\views_timestamp_to_date\Plugin\views\field\TimestampToDate` (`@ViewsField("field_views_timestamp_to_date")`),
extending `Drupal\views\Plugin\views\field\Date`.

## When you need it

A normal Views date field expects an entity date/timestamp field. When the source is a raw DB table
(Views Database Connector, a non-entity table, an imported/legacy column), the timestamp is just an
integer and Views prints it as a number. This field gives you core's date-format UI for that integer.

## Add it in the Views UI (or config)

1. Add the field that outputs the timestamp integer (e.g. a raw `created` column) so it exists in the row.
2. Add field **"Global: Timestamp to Date"**.
3. In its settings, set **Timestamp Field** = the field from step 1.
4. Set the date **Format** (and custom format / timezone) as with any core date field.

Optionally hide the source field from step 1 (Views UI "Exclude from display") so only the formatted
date shows.

## Options

| Option | Source | Notes |
|---|---|---|
| `timestamp_field` | This module | Select in the options form; choices come from `$this->displayHandler->getFieldLabels()` — i.e. every other field currently in the display. Stored as a string field ID. |
| `date_format` | inherited (core `Date`) | Named format (`short`/`medium`/`long`/`html_*`…), `custom`, or a relative format: `time ago`, `raw time ago`, `time hence`, `raw time hence`, `time span`, `raw time span`, `inverse time span`. |
| `custom_date_format` | inherited (core `Date`) | For `custom`, a PHP `date()` format string. For the relative formats it is read as the **granularity** (numeric, default 2). |
| `timezone` | inherited (core `Date`) | Optional timezone override; empty = site/user default. |

## What `render()` does (per row)

- Reads the source value as `$values->{base_table . '_' . timestamp_field}` (the row-alias of the
  chosen sibling field). Empty/zero → returns `''`.
- `time diff = datetime.time->getRequestTime() - value` drives the relative formats.
- Relative formats call `dateFormatter->formatTimeDiffSince()` / `formatTimeDiffUntil()` with the
  granularity; `time span` / `inverse time span` add a leading `-` based on past/future.
- `custom` → `dateFormatter->format($value, 'custom', $custom_format, $timezone)` (langcode `en` only
  when the custom format is exactly `r`).
- Any other/named format → `dateFormatter->format($value, $format, '', $timezone)`.

## Config schema

`views.field.views_timestamp_to_date` (type `views_field`) adds one mapped key: `timestamp_field`
(string). The date-format keys live in the inherited `views_field` / core Date schema.

## Notes / gotchas

- The value read assumes the row property alias is `base_table_<fieldID>`; it works for the common
  raw-table / global-field case but is not guaranteed for every relationship/alias arrangement.
- A Unix timestamp is an absolute instant with no timezone. Keep the `timezone` option consistent
  with how the same value is displayed elsewhere, or dates can appear off by up to a day.
