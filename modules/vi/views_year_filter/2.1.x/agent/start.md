# views_year_filter — agent start

Lets a Views **date / datetime / Search API date** filter match on a bare four-digit year
(`CCYY`, e.g. `2021`) instead of a full timestamp. It does **not** register a new filter in
the "Add filter" dialog: `hook_views_plugins_filter_alter()` swaps the handler CLASS behind
the existing `date`, `datetime`, and `search_api_date` filter plugins, adding a value **Type**
option "A date in CCYY format." (internal `date_year`). Package `Date`; depends only on core
`views`. Smart Date fields are left untouched.

Key fact for reading/writing view config: the year mode is stored on the filter's
`value.type = "date_year"` (with the year in `value.value`, or `value.min`/`value.max` for
"between") — the `plugin_id` stays `date` / `datetime` / `search_api_date`.

- Use the year filter in a view + how the query is rewritten (`YEAR()`, timestamps, between) →
  [plugins/year-filter.md](plugins/year-filter.md)
- Admin settings form + Bootstrap year datepicker option → [configure/settings.md](configure/settings.md)
