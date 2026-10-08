# The `date` Views pager plugin

Date Pager provides exactly one plugin: a Views **pager** that pages by date period instead of by
numbered offset. There is no plugin *type* and no plugin manager of the module's own — this is a
single implementation of the core `@ViewsPager` type.

| Item | Value |
|---|---|
| Plugin type | `@ViewsPager` (core Views pager) |
| Plugin id | `date` |
| Title / short title | "Date Pager" / "Date" |
| Class | `Drupal\date_pager\Plugin\views\pager\DatePager` (extends `PagerPluginBase`, implements `CacheableDependencyInterface`) |
| Theme | `datepager` (`register_theme = TRUE`) |
| Config schema | `views.pager.date` (`type: views_pager_sql`) |

## Configuration (four option keys)

Set on a view display's pager. Config schema `config/schema/datepager.schema.yml`; form built in
`DatePager::buildOptionsForm()` (`DatePager.php:234`), defaults in `defineOptions()`
(`DatePager.php:220`).

| Key | Form label | Type | Default | Values |
|---|---|---|---|---|
| `granularity` | Granularity | integer | `3` (Hour) | `0`=Year, `1`=Month, `2`=Day, `3`=Hour, `4`=Minute |
| `default_page` | Default time | string | `now` | `earliest`, `now` (current), `latest` |
| `date_field` | Date field | string | `FALSE` | `{entity_type}.{field_name}`, e.g. `node.field_event` |
| `date_sort` | Reverse order | boolean | `FALSE` | `TRUE` = descending period order |

`granularity` is the **maximum** depth of the pager. The rendered pager always starts at Year and
nests inward down to the selected level (year → month → day → hour → minute). `default_page` chooses
which period is shown when the URL has no `date` parameter: `earliest`/`latest` jump to the min/max
date present in the data, `now` uses the current date formatted at the configured granularity.

Validation (`validateOptionsForm()`, `DatePager.php:324`): `granularity` must be numeric and 0–4;
`date_field` must be non-empty ("Please select a valid date field.").

### Supported date field types

`getDateFieldOptions()` (`DatePager.php:289`) lists every field on the view's base entity whose type
is one of `$supportedDateTypes` (`DatePager.php:38`):

- `datetime`, `daterange` — stored as ISO datetime strings.
- `changed`, `created`, `smartdate` — stored as **unix timestamps** (`$unixtimestampTypes`,
  `DatePager.php:51`); the plugin converts period bounds with `strtotime()`/`date()` for these.

`daterange` uses both `value` and `end_value` columns; a row matches a period when its range overlaps
the period. `smartdate` support is why `smart_date` is a `test_dependencies` entry in the info.yml —
it is not required at runtime.

## Add it via the Views UI

1. Edit a view (`/admin/structure/views/view/<name>`) whose base entity has a supported date field.
2. In **Pager**, click the current pager type and choose **Date Pager**, *Apply*.
3. In the pager settings choose **Granularity**, **Default time**, the **Date field**, and optionally
   **Reverse order**; *Apply* and *Save*. (Summary link text is "Page by date".)

## Add it programmatically (view config)

In a `views.view.<name>` config entity, the display's `display_options.pager`:

```yaml
pager:
  type: date
  options:
    granularity: 1              # 0=Year 1=Month 2=Day 3=Hour 4=Minute
    default_page: now           # earliest | now | latest
    date_field: 'node.field_event_date'   # {entity_type}.{field_name}
    date_sort: false            # true = descending
```

A legacy `date_field` written with `__` in place of the dot (e.g. `node__field_event_date`) is
normalised back to dotted form in `init()` (`DatePager.php:173`) for backwards compatibility.

## The `?date=` URL parameter and period navigation

The active period comes from the **`date`** query parameter, read in `setCurrentPage()`
(`DatePager.php:414`). It is accepted only if it matches
`^\d{4}(-[0-1][0-9](-[0-3][0-9](T[0-2][0-9](:[0-6][0-9])?)?)?)?$` — i.e. `YYYY`, `YYYY-MM`,
`YYYY-MM-DD`, `YYYY-MM-DDTHH`, or `YYYY-MM-DDTHH:MM`. Anything else falls back to `default_page`.
Example URLs: `?date=2026`, `?date=2026-09`, `?date=2026-09-14T10`. Each generated period link
(built in `PagerDate::toLink()`, `PagerDate.php:266`) sets this parameter and merges it with any
other query args, and the plugin declares the `url.query_args` cache context so it coexists with
exposed filters and other pagers.

## Query mechanism

`query()` (`DatePager.php:343`) constrains the view to the active period rather than applying an
`OFFSET`:

- Adds the field's start column (and end column, for ranges) to the query as fields.
- If the date column already appears in `where[0]` conditions (e.g. a contextual filter on the same
  field), it rewrites that condition to `LIKE '<activeDate>%'`.
- Otherwise it adds two conditions in group `1`: `startColumn < periodEnd` **and**
  `endColumn >= periodStart`, so any row overlapping the period matches. Period bounds come from
  `PagerDate::startDate()`/`endDate()`; for unix-timestamp field types they are `strtotime()`-converted.

`useCountQuery()` returns `FALSE`, `usePager()` returns `TRUE`, `usesExposed()` returns `FALSE`.
`getDateRange()` (`DatePager.php:383`) runs a `MIN(startDate)`/`MAX(endDate)` subquery over the date
field to bound the year range shown in the pager (and to resolve `earliest`/`latest`).

Because the condition value is the strictly regex-validated active date passed through the Views
query builder as a placeholder value (never string-concatenated into SQL), the `date` parameter is
not an injection vector.

## Theming and the `PagerDate` helper

- Theme hook `datepager` is registered by `date_pager_theme()` and preprocessed by
  `template_preprocess_datepager()` (both in `date_pager.module`), which assembles the nested
  year/month/day/hour/minute item lists and attaches `date_pager/datepager`.
- Template: `templates/datepager.html.twig` — override by copying into your theme. It renders
  `<nav class="pager date-pager">` with `.pager__item__year|month|day|hour|minute` items; the active
  period carries an `is-active`/`active` class, future periods a `future` class.
- Library `date_pager/datepager` attaches `css/date-pager-component.css` and
  `css/date-pager-state.css`.
- `Drupal\date_pager\PagerDate` (extends `\DateTime`) stores a granularity and provides
  `startDate()`, `endDate()`, `between()`, `toTime()`, `toLink()`, and `userTimezone()` (period math
  is done in the user's/site's timezone). Each link is a `#theme => 'link'` render array wrapping a
  `<time datetime="…">` element via `TranslatableMarkup`.

## Caching

`getCacheMaxAge()` = `Cache::PERMANENT`, `getCacheContexts()` = `['url.query_args']`,
`getCacheTags()` = `[]` (`DatePager.php:485`). The plugin varies output by query args so the pager
links stay correct alongside exposed filters and additional query parameters.
