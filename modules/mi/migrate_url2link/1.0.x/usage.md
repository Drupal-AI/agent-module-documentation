Migrate URL2Link provides a Drupal-to-Drupal migration path for the Drupal 7 contrib **URL** field, mapping it (and its widgets/formatters) onto the core **Link** field on Drupal 8/9/10/11.

---

The module is a small glue plugin for the migrate framework. It supplies one `MigrateField` plugin,
`UrlField` (`src/Plugin/migrate/field/d7/UrlField.php`, `id = field_url`, `core = {7}`), which declares
the field type map `url → link`, source module `url`, destination module `link`. Its
`getFieldFormatterMap()` maps the D7 formatters `url_default`/`url_plain` to `link`, and
`getFieldWidgetMap()` maps the D7 widget `url_external` to `link_default`. A migration state file
(`migrations/state/migrate_url2link.migrate_drupal.yml`) marks the D7 `url` module as `finished → link`,
so the Migrate Drupal upgrade audit recognizes it as handled rather than "not upgraded". There is no UI,
no configuration, no permissions, and no Drush of its own — you enable it before running the standard
Drupal 7→D8+ migration (via Migrate Drupal / migrate_plus) and the URL fields are converted
automatically. Depends on core `link`, `migrate`, and contrib `migrate_plus`.

---

- Migrate Drupal 7 URL fields into core Link fields during a D7→D8/9/10/11 upgrade.
- Automatically convert D7 URL field storage and instances to `link` field type.
- Map the D7 `url_default` display formatter to the core `link` formatter.
- Map the D7 `url_plain` display formatter to the core `link` formatter.
- Map the D7 `url_external` widget to the core `link_default` widget.
- Clear the "URL module not upgraded" warning in the Migrate Drupal readiness/audit report.
- Include URL fields in an automated `drush migrate:import` run without hand-written field mappings.
- Preserve existing URL field data when moving a site off Drupal 7.
- Support both UI-driven (Migrate Drupal UI) and config-driven (migrate_plus) upgrade workflows.
- Avoid writing a custom `MigrateField` plugin for the common D7 URL contrib field.
- Ensure link values from D7 render correctly after upgrade via the mapped formatter.
- Combine with other field migration modules to complete a full D7 content migration.
- Handle multi-value URL fields as multi-value Link fields.
- Enable only during migration, then remove once the upgrade is complete.
- Provide a reproducible, code-based conversion path suitable for CI/staged migrations.
