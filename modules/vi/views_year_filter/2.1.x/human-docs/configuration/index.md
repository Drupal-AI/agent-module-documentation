# Configuration

There are two things to know: how to use the **year filter inside a view** (the main
feature), and the one **global setting** (an optional datepicker).

## Use the year filter in a view

The enhancement rides on an ordinary date filter — there is no special "year" entry in
the filter list.

1. Edit or create a view at **Structure → Views**.
2. Under **Filter criteria**, click **Add** and choose a normal date field — for
   example **Content: Authored on** (`created`), a Datetime field you built in Field UI,
   or a Search API date field.
3. In the filter's settings, open the value **Type** select. It now has an extra
   option: **A date in CCYY format.** Choose it.
4. Enter a four‑digit year, such as `2023`. For the **Is between** operator, enter a
   minimum and maximum year to match a range (e.g. 2019–2021).
5. Save the view.

The filter now matches only on the year: for stored date fields the query becomes
`YEAR(field) = 2023`, and for timestamp columns such as *Authored on*, *Updated*, and
*Publish on* it uses `YEAR(FROM_UNIXTIME(field))`. You can expose the filter so visitors
type a year themselves, and combine it with other filters (content type, published
status) for a yearly report.

A few notes:

- **Search API date fields** are matched by converting the year into a timestamp range
  (Jan 1 – Dec 31) rather than a `YEAR()` expression, but the result is the same "just
  this year" behavior.
- **Smart Date** fields are intentionally skipped, so Smart Date keeps its own native
  year granularity.

## The global setting — Bootstrap year datepicker

The module has one settings form at **Configuration → User interface → Views year filter
settings** (`/admin/config/views-year-filter/settings`), guarded by the core
**Administer site configuration** permission. It has a single checkbox:

- **Use Bootstrap Datepicker** — when ticked, an *exposed* year filter gets a year‑only
  Bootstrap datepicker popup attached, so visitors pick a year from a widget instead of
  typing it. (The Bootstrap datepicker assets are loaded from a CDN.)

After toggling it, the form warns that the change takes effect **after the next cache
clear** — so run `drush cr`:

```bash
drush config:set views_year_filter.settings use_bootstrap_datepicker 1 -y
drush cr
```

> **Related but separate:** if the optional core **Date Popup** module is installed, it
> upgrades your *non‑year* date filter inputs from plain text fields to HTML5 date
> pickers. That is independent of the Bootstrap datepicker checkbox above.
