# allowed_formats — agent start

Hides the "About text formats" help link and format guidelines under formatted-text
field widgets (`text`, `text_long`, `text_with_summary`). No admin page — settings live
per widget on **Manage form display**. Depends on core `field` + `filter`. Since Drupal
10.1 the actual format-restriction feature is in core; this module only cleans up the UI
and migrates legacy settings.

- Hide help/guidelines per field widget (third-party settings) → [configure/widget-settings.md](configure/widget-settings.md)
- Legacy → core settings migration (presave + post_update) → [hooks/migration.md](hooks/migration.md)
