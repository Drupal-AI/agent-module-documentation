# Views Database Connector (VDC) — agent index

Exposes tables of extra databases defined in `settings.php` to Views, so you can build a
View over external/legacy data with no custom `hook_views_data()`. Each table shows up in
the Views "Show" list as `[VDC] <db>:  <table>`. Requires `views`. No Drush commands.

- **Enable which databases/tables are exposed, the settings form, `$settings['vdc_allow']`,
  the opt-in vs opt-out default, data-type handling** → [configure/databases.md](configure/databases.md)
- **Define relationships between VDC tables (custom `hook_views_data_alter()` module) and the
  `standard_vdc` field's HTML option** → [api/relationships.md](api/relationships.md)

Key facts:
- Data provider: `views_database_connector.views.inc` → `hook_views_data()` iterates
  `Database::getAllConnectionInfo()` and introspects each enabled connection's schema.
- Config form: route `views_database_connector.settings`,
  `/admin/config/development/views_database_connector`, permission
  `administer site configuration`. Stores `<db>.enabled` in config
  `views_database_connector.settings`. (`configure` is NOT declared in info.yml.)
- Default exposure: `default` DB is opt-in; **non-default connections are exposed by
  default** unless disabled (`views_database_connector_get_database_schemas()`).
- Plugins provided (internal, not new plugin types): Views field `standard_vdc`
  (`@ViewsField`), Views relationship `views_database_connector_relationship`.
- Config schema: only `views.field.standard_vdc` → `render_html` (bool).
