# Views Selective Filters — agent index

Makes an exposed Views filter show only the option values present in the result set. It adds a
**"… (selective)"** variant of every filterable field, backed by the Views filter plugin
`views_selective_filters_filter`. No config page, no permissions, no Drush.

- **Add & configure a selective filter in a view (options, gotchas)** →
  [configure/selective-filter.md](configure/selective-filter.md)
- **How it works: `hook_views_data_alter` + the proxy filter plugin** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- `configure` = null. Depends on `views`.
- In a view's config the placed filter has `plugin_id: views_selective_filters_filter`; the
  synthetic field is named `<original_field>_selective`.
- Option keys (schema `views.filter.views_selective_filters_filter`):
  `selective_display_field`, `selective_display_sort` (ASC/DESC/KASC/KDESC/NONE/ORIG),
  `selective_aggregated_fields`, `selective_items_limit` (default 100), `selective_entity_type`.
- Filter and the field it mirrors must share the same base field, else a mismatch error.
