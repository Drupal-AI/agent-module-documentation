Views Database Connector (VDC) exposes the tables of *any* extra database defined in `settings.php` to Drupal Views, so you can build a normal View around external/legacy data without writing a custom `hook_views_data()`.

---

On `hook_views_data()`, VDC reads every database connection from `Database::getAllConnectionInfo()`, and for each **enabled** connection it introspects the schema (via `SHOW TABLES` + `information_schema.columns` on MySQL, `sqlite_master` + `PRAGMA table_info` on SQLite, `information_schema` on PostgreSQL, `sys.tables` + `information_schema` on SQL Server) and registers each table as a Views base table titled `[VDC] <db>:  <table>`. Column data types are bucketed into `numeric`, `date`, `string`, or `boolean`, and each gets appropriate Views field/sort/filter/argument handlers; string columns use a custom `standard_vdc` field handler that can optionally render as (XSS-filtered) HTML. Which connections are exposed is controlled two ways: the config form at `/admin/config/development/views_database_connector` (route `views_database_connector.settings`, permission *administer site configuration*) stores a per-connection `enabled` flag, and an optional `$settings['vdc_allow'][<db>] = [<table>, ...]` allow-list in `settings.php` restricts VDC to named tables. Note the default: the `default` (Drupal) database is opt-in (only exposed if explicitly enabled), but any **non-default** connection is exposed by default unless you turn it off. Tables whose names are already claimed by another module's `hook_views_data()` are skipped to avoid collisions. Relationships between VDC tables are possible but require a small custom module implementing `hook_views_data_alter()` with the `views_database_connector_relationship` plugin (see the api doc). The module ships a config schema only for the `standard_vdc` field's `render_html` option. Requires the `views` module; no Drush commands.

---

- Build a View listing rows from a legacy MySQL database connected via `settings.php`.
- Show data from an external CRM/ERP database inside a Drupal page or block.
- Create a filtered, sortable table of records from a reporting database using Views UI.
- Expose a read-only analytics table to site editors without writing custom code.
- Pull product data from a separate e-commerce database into a Drupal View.
- Add exposed filters over columns of an external table for a search-like UI.
- Combine an external table with a Views page display and a path for public listing.
- Render a specific string column as sanitized HTML using the `standard_vdc` field option.
- Restrict Views access to only named tables of a database via `$settings['vdc_allow']`.
- Enable/disable which database connections Views can see from the settings form.
- Surface SQLite data (e.g. an imported dataset) to Views without a migration.
- Expose PostgreSQL tables/views to Views for cross-system reporting.
- Read SQL Server (`sqlsrv`/`odbc`) tables into Views for a Drupal front end.
- Provide editors a Views-based dashboard over an external operational database.
- Join two external tables in Views by defining a relationship in a small custom module.
- Feed external table data into a Views REST or feed display.
- Prototype dashboards over legacy data quickly without ETL into Drupal entities.
- Display audit/log rows stored in a dedicated database via Views.
- Give a View access to the Drupal `default` database's raw tables (must opt in per-connection).
- Add numeric/date filters and arguments over external columns using auto-detected data types.
- Present a paginated, themeable list of external records using Views styles.
- Expose multiple external databases at once, each table prefixed `[VDC] <db>:`.
