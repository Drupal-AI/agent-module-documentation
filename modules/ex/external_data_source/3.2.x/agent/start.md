# External Data Source — agent index

A field type whose options come from an external web service through pluggable
`@ExternalDataSource` data-source plugins. Depends on core `field`. No global config page
(`configure` null), no permissions of its own, no Drush. Ships 3 data sources (`countries`,
`franceregions`, `francezipcodes`) with **hardcoded** endpoints.

- **Add & configure the field: `ws`/`count`/`max_length` storage settings, the 3 widgets, the
  formatter, the autocomplete route** → [configure/field.md](configure/field.md)
- **Write your own data-source plugin (`@ExternalDataSource` + `getResponse()`)** →
  [plugins/data-source.md](plugins/data-source.md)

Key facts:
- Field type `external_data_source` (single `value` varchar). Storage settings: `ws` (data-source
  plugin id, default `countries`), `count` (default 10), `max_length` (default 255) — all locked
  once the field has data.
- Widgets: `external_data_source_select_widget` (default select), `external_data_source_checkboxes_widget`
  (checkboxes/radios), `external_data_source_auto_complete_widget` (autocomplete textfield).
- Formatter `external_data_source_formatter` → `nl2br(Html::escape(t($value)))`.
- Autocomplete route `external_data_source.auto_complete_controller` = `/external_data_source/autocomplete`
  (`?plugin_name=<id>&q=<term>`), permission **`access content`**; unknown plugin → 404.
- Plugin manager `plugin.manager.external_data_source`, annotation `@ExternalDataSource`
  (`Plugin/ExternalDataSource/`), interface `ExternalDataSourceInterface::getResponse()`.
