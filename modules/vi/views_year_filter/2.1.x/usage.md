Views Year Filter lets a Views date/date-time filter match on just a year (four-digit `CCYY`, e.g. `2021`) instead of a full timestamp or an offset from now. It adds an extra "A date in CCYY format." value type to the standard Views date, datetime, and Search API date filters, so you can build listings like "content published in 2023" without writing a date range.

---

The module does not add a new named filter to the "Add filter" dialog. Instead it implements `hook_views_plugins_filter_alter()` to swap the handler CLASS behind three existing core/contrib Views filter plugins — `date` (timestamp/date fields such as Authored on, Updated, and Publish-on), `datetime` (Datetime fields created via Field UI), and `search_api_date` (Search API date fields, only when `search_api` is installed). The replacement classes (`ViewsYearFilterDate`, `ViewsYearFilterDatetime`, `ViewsSearchApiYearFilterDate`) extend the core handlers and add one option to the filter's value **Type** select: **A date in CCYY format.** (internal value `date_year`). When an admin picks that type and enters a year, the filter stops comparing full dates and instead compares only the year: for stored date strings it rewrites the query as `YEAR(field) <op> <year>`, and for UNIX-timestamp columns (`created`, `changed`, `published_at`) as `YEAR(FROM_UNIXTIME(field)) <op> <year>`. The "Is between" operator produces `YEAR(...) BETWEEN <min> AND <max>`. In a saved view the year mode is recorded not by the `plugin_id` (which stays `date` / `datetime` / `search_api_date`) but by the filter's `value.type` being set to `date_year`, with the year in `value.value` (or `value.min` / `value.max` for between). Smart Date fields are intentionally left alone so Smart Date's own year granularity keeps working. An admin settings form at `/admin/config/views-year-filter/settings` (permission "administer site configuration", config `views_year_filter.settings`) has a single option, "Use Bootstrap Datepicker", which attaches a year-only Bootstrap datepicker to exposed year filters; the change takes effect after a cache clear. The optional `date_popup` module upgrades non-year date filters to HTML5 date inputs.

---

- Build a view of nodes authored in a specific year (filter Authored on → type "A date in CCYY format." → 2023).
- Filter content updated (changed) in a given year using `YEAR(FROM_UNIXTIME(changed))`.
- List Scheduler "Publish on" content for a chosen year via the `published_at` timestamp.
- Show only events whose Datetime field falls in one year (e.g. a "conference_date" field = 2024).
- Filter a range of years with the "Is between" operator (e.g. articles from 2019 to 2021).
- Expose a year filter to visitors so they can type a four-digit year in the view header.
- Add a year-only Bootstrap datepicker to an exposed year filter (enable the module setting).
- Create an archive block listing posts per year without computing full date ranges by hand.
- Filter a Search API-indexed date field by year when `search_api` is enabled.
- Combine a year filter with other filters (content type, published) for a yearly report view.
- Replace a fragile "greater than / less than full-date" pair with a single year value.
- Power a "This year vs. last year" comparison view using two displays with different years.
- Filter taxonomy or media entities by the year of any of their date fields.
- Provide a contextual/exposed "year" selector for a news or blog archive listing.
- Show users registered in a particular year via the `created` timestamp on the user base table.
- Build a yearly financial/records report filtered on a custom Datetime field.
- Let editors preview all content scheduled for the upcoming year.
- Filter comments or revisions by their creation year.
- Restrict an RSS/data-export view to a single year of content.
- Drive a "year of publication" facet-like listing without the Facets module.
- Keep Smart Date fields on their native year granularity while other date fields use this filter.
- Quickly answer "how many articles did we publish in year X" via a filtered view count.
- Filter by year across mixed timestamp and datetime fields in the same view.
- Use the "Is not equal to" year operator to exclude a single year from a listing.
- Migrate legacy full-date range filters to simpler single-year filters during a site rebuild.

