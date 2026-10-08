<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Database logging API (dblog_api) — agent index

Developer framework that adds a plugin extension point to the **Operations** column of Drupal core's Database logging (dblog) log views. Not an HTTP/REST API — it exposes nothing over the network. Version dir **2.0.x**. Core `^10.2 || ^11 || ^12`, PHP 8.1.

## What it provides
- A `DblogOperation` plugin type: manager `plugin.manager.dblog_api_operation` (`Drupal\dblog_api\DblogOperationManager`), interface `DblogOperationInterface`, base `DblogOperationBase`, annotation `@DblogOperation` (namespace `Plugin/DblogOperation`, alter hook `dblog_api_operation`).
- A Views field handler `dblog_api_operations` (`Drupal\dblog_api\Plugin\views\field\DblogApiOperations`, extends core `DblogOperations`) that renders core's "view" link then appends each applicable plugin's output.
- `hook_views_data_alter()` (via `Drupal\dblog_api\Hook\DblogApiViewsHooks::viewsDataAlter()`, wired in `dblog_api.views.inc`) that repoints `watchdog` → `link` → `field` `id` from core's `dblog_operations` to `dblog_api_operations`.
- A migrate-state marker (`migrations/state/dblog_api.migrate_drupal.yml`) for the D7 upgrade path.

## Dependencies
- Core `dblog` (only hard dependency; declared in `dblog_api.info.yml`). No Composer runtime requirements, no libraries.

## What it does NOT provide
- No routes, no permissions, no config objects/schema, no settings form, no Drush commands, no `.module`/`.install`, no blocks.

## Solution docs
- [Plugin type & rendering pipeline](plugins/dblog-operation.md) — write a `DblogOperation`, how rows flow through the Views handler, the test module example.
