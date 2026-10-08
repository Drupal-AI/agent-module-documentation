<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Event capture + log table schema

All in `content_modification_log.module`.

## Hooks that capture changes

- `content_modification_log_entity_insert($entity)` → `_content_modification_log_record_entry($entity, 'created')`
- `content_modification_log_entity_update($entity)` → `_content_modification_log_record_entry($entity, 'updated')`
- `content_modification_log_entity_delete($entity)` → `_content_modification_log_record_entry($entity, 'deleted')`

These are core generic entity hooks, so they fire for every entity save/delete on the site, but the
recorder filters what it stores.

## The recorder: `_content_modification_log_record_entry(EntityInterface $entity, string $action)`

- **Filter**: does nothing unless `in_array($entity->getEntityTypeId(), ['node', 'file'])`. Only
  **node** and **file** entities are ever logged; users, taxonomy terms, comments, config entities,
  media, paragraphs, etc. are ignored.
- Gathers, for a matching entity:
  - `uid` = `\Drupal::currentUser()->id()` (the acting user; 0 for anonymous / cron / system).
  - `timestamp` = `\Drupal::time()->getCurrentTime()`.
  - `client_ip` = `\Drupal::request()->getClientIp()`.
  - `entity_type`, `entity_id` = `$entity->id()`, `entity_title` = `$entity->label()`,
    `entity_bundle` = `$entity->bundle() ?: NULL`.
  - `revision_log_message` = `$entity->getRevisionLogMessage()` — only when `!empty($entity->revision_log)`, else NULL.
  - `action` = the passed string.
- Inserts one row: `\Drupal::database()->insert('content_modification_log')->fields($info)->execute()`
  (parameterised DBTNG insert).

Note: the title/bundle/id are **snapshotted at write time** into the log row, so the report/CSV can
show them even after the entity is unpublished or deleted.

## Table schema — `content_modification_log_schema()`

Table `content_modification_log`:

| column | type | notes |
|---|---|---|
| `lid` | serial, unsigned, PK | log entry id |
| `uid` | int, unsigned, not null | user who made the change |
| `timestamp` | int, not null | unix time of the change (indexed) |
| `client_ip` | varchar(40), null | client IP |
| `entity_type` | varchar(32), null | e.g. `node`, `file` |
| `entity_id` | varchar(32), null | entity id |
| `entity_title` | varchar(255), null | entity label at write time |
| `entity_bundle` | varchar(32), null | bundle machine name |
| `revision_log_message` | text big, null | revision log message if any |
| `action` | varchar(32), null | `created` / `updated` / `deleted` |

Indexes: `uid`, `timestamp`. Primary key: `lid`.

- Update hook `content_modification_log_update_10002()` adds the `revision_log_message` column to
  installs created before it existed.

## Other module glue

- `hook_theme()` registers a `content_modification_log` theme
  (`templates/content-modification-log.html.twig`) — an empty `<div>` container used by the block.
- `hook_local_tasks_alter()` removes the `content_modification_log.content.tab` local task unless
  `content_modification_log.settings:show_tab === 1`.
- `hook_help()` prints a one-line About section on the module help page.
