# The year filter (date / datetime / Search API date)

Views Year Filter provides **no standalone filter plugin id**. It implements
`hook_views_plugins_filter_alter()` (`views_year_filter.views.inc`) to override the handler
CLASS of three existing Views filter plugins:

| Views filter `plugin_id` | Applies to | Replacement class |
|---|---|---|
| `date` | Timestamp/date fields: **Authored on** (`created`), **Updated** (`changed`), Scheduler **Publish on** (`published_at`), and other core date fields | `ViewsYearFilterDate` (attribute id `date_with_more_options`) |
| `datetime` | **Datetime** fields created via Field UI (field type `datetime`) | `ViewsYearFilterDatetime` (attribute id `datetime_with_more_options`) |
| `search_api_date` | **Search API** date fields — only overridden when `search_api` is installed | `ViewsSearchApiYearFilterDate` (attribute id `search_api_date_with_more_options`) |

Smart Date fields are deliberately skipped (the alter leaves `date` alone when its provider is
`smart_date`) so Smart Date's own year granularity keeps working.

## How an admin uses it

1. Edit a view → **Filter criteria** → add a normal date field (e.g. **Content: Authored on**,
   or a Datetime field). No special "year" filter appears in the list — the enhancement rides
   on the ordinary date filter.
2. In the filter's settings, the value **Type** select now has an extra option:
   **A date in CCYY format.** (internal value `date_year`). Choose it.
3. Enter a four-digit year (e.g. `2023`) as the value. For the **Is between** operator, enter a
   min and max year.

## What gets stored in the view config

The filter's `plugin_id` stays `date` / `datetime` / `search_api_date`. The year mode is
recorded on the filter's **`value`**:

```yaml
filters:
  created:
    id: created
    table: node_field_data
    field: created
    plugin_id: date          # unchanged — NOT "date_year"
    operator: '='
    value:
      type: date_year        # <-- this marks the year filter as active
      value: '2023'          # the year (simple operators)
      min: ''                # used by the "between" operator
      max: ''
```

So to detect "this view uses the year filter", check a filter's `value.type === 'date_year'`
(not the `plugin_id`).

## How the query is rewritten

When `value.type === 'date_year'` and a valid integer year is given (`ViewsYearFilterDate` /
`ViewsYearFilterDatetime`):

- **Simple operators** (`=`, `!=`, `>`, `<`, `>=`, `<=`) →
  `YEAR(field) <op> <year>` for stored date strings.
- **UNIX-timestamp columns** — when the field name contains `.created`, `.changed`, or
  `.published_at` → `YEAR(FROM_UNIXTIME(field)) <op> <year>`.
- **Is between / not between** → `YEAR(field) BETWEEN <min> AND <max>`
  (or `YEAR(FROM_UNIXTIME(field)) ...` for timestamp columns).

The **Search API** handler (`ViewsSearchApiYearFilterDate`) works differently: it does not emit
`YEAR()`; it converts the year to a range of UNIX timestamps
(`<year>-01-01 00:00:00` … `<year>-12-31 23:59:59` via `strtotime()`) and adds a `BETWEEN`
condition on the Search API query.

If the type is not `date_year` (or the year isn't a valid integer), the handler falls back to
the parent core behaviour (full date / offset).

## Notes for building a view programmatically

- Set the filter `plugin_id` to `date` for timestamp fields (`created`/`changed`/`published_at`)
  and generic date fields; `datetime` for Field-UI Datetime fields; `search_api_date` for
  Search API date fields.
- Set `value.type` to `date_year` and put the year in `value.value` (simple) or
  `value.min`/`value.max` (between).
- No config schema ships with the module for these filter values, and there are no permissions
  or Drush commands to configure the filter — it is pure view config.
