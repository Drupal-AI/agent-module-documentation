# Configure Entity Log

Form `EntityLogConfigForm` (extends `ConfigFormBase`) at `admin/config/entity-log`
(route `entity_log.configuration`, perm `administer entity log entities`). Config object: `entity_log.configuration`.

## What you configure
- **Master toggles**:
  - `log_in_logger` (bool) — write changes to the Drupal logger channel `entity_log`.
  - `log_in_entity` (bool) — create an `entity_log` content entity per change.
  - If both are off, nothing is logged (`entitySetForLogging()` returns FALSE early).
- **`row_limit`** (int) — max rows kept in the `entity_log` table; older rows are deleted on cron.
- **Per entity type / bundle / field selection** — the form lists fieldable entity types, their bundles and
  fields; checked fields are stored under a nested key per entity type, e.g.:

```yaml
# entity_log.configuration (shape)
log_in_logger: true
log_in_entity: true
row_limit: 1000
node:
  article:
    fields:
      title: title
      field_status: field_status   # only checked (truthy) fields are watched
```

`EntityLogService::entitySetForLogging($entity)` reads
`entity_log.configuration:<entity_type_id>.<bundle>.fields` and `array_filter`s it to the enabled fields.

## Set config with Drush (example: watch node.article title)
```bash
ddev drush cset entity_log.configuration log_in_entity 1 -y
ddev drush cset entity_log.configuration node.article.fields.title title -y
```

## Pruning
`entity_log_cron()` → `EntityLogService::cleanupLogs()` keeps the newest `row_limit` rows in the `entity_log`
table (deletes rows with `id` below the row_limit-th newest). No pruning when `row_limit` is 0/empty.

Note: there is no `config/schema` file shipped, so add schema in your own module if you need strict config
validation/translation for these keys.
