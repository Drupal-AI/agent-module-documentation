# Logging, validation & process plugins

## Settings (`wordpress_migrate.settings`)

No admin form; edit via Drush/config sync. Config schema in `config/schema/wordpress_migrate.schema.yml`.

| Key | Default | Meaning |
|---|---|---|
| `wp_migrate_logging_level` | `3` | RFC 5424 threshold for module log output. `0`=emergency only … `3`=errors … `7`=full debug. |
| `wp_migrate_drush_logging_level` | `3` | Same threshold for Drush-context logging. |
| `defaults` | (mapping) | Default bundle/vocabulary/format values pre-filled in the wizard and CLI (e.g. `default_post_type_bundle: article`, `default_post_text_format: basic_html`, `drupal_types_bundles`, `types_input`, …). |

```bash
ddev drush cset wordpress_migrate.settings wp_migrate_logging_level 7 -y   # debug while troubleshooting
```

Takes effect on the next request; no cache rebuild needed.

## Logging architecture (`wordpress_migrate.services.yml`)

All output goes to the `wordpress_migrate` watchdog channel (filter it at `/admin/reports/dblog` or
`drush watchdog:show --type=wordpress_migrate`). No code calls a raw logger channel directly — two
gated wrappers read `wp_migrate_logging_level` at construction and drop calls above the threshold:

- `wordpress_migrate.logger` (`MigrateLogger`, shared) — for services, Drush commands, wizard steps.
  Also collects `LogEntry` objects in memory (`getEntries()`, `getErrors()`, `hasErrors()`, `toLines()`,
  `reset()`) for display.
- `wordpress_migrate.threshold_logger` (`ThresholdLogger`, `shared: false`) — a lightweight
  `LoggerInterface` decorator injected into process plugins; same threshold gate, no in-memory
  collection.

Severity string/int mapping helpers live in `src/Constants.php` (`severityToInt`, `intToSeverity`).

## Pre-flight validation

`wordpress_migrate.config_validator` (`MigrationConfigValidator`) checks the full configuration array
before any entity is created and forwards results through `MigrateLogger`. Blocking errors abort
generation (both Drush and the wizard); warnings/info are surfaced but non-blocking.

## Process plugins

Only **`wordpress_migrate_log_term`** (`@MigrateProcessPlugin(id="wordpress_migrate_log_term")`,
`src/Plugin/migrate/process/LogTerm.php`) is implemented in this release. It is a transparent observer:
logs term id/name/slug/destination/value at `debug` and returns the value unchanged. Add it to a
taxonomy pipeline to debug tag/category rows:

```yaml
process:
  name:
    - plugin: wordpress_migrate_log_term
    - plugin: get
      source: tag_name
```

`docs/processing-plugins.md` also describes `wordpress_migrate_log_content_row`,
`wordpress_migrate_log_post_date`, `wordpress_migrate_sanitize_thumbnail_id`, and
`wordpress_migrate_fetch_attachment_url`, but those classes are **not present** in this codebase (the
doc itself states "Not everything is yet implemented") — do not rely on them here.

## Security / content note

Per the README security note: imported posts/comments can contain harmful JS or unsanitized markup —
review imported content. Imported WordPress authors become **active** Drupal users — review them after
import. Existing users (matched by email) are not overwritten. These are operator responsibilities; the
per-bundle text format is admin-chosen.
