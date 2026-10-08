<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External Link Status Check (external_link_status_check) — agent index

Detects outbound external URLs across content entities, verifies each URL's HTTP status in the
background, stores the result plus scraped metadata in a custom DB table, and reports broken links
on an admin dashboard. Package `SEO`. License GPL-2.0-or-later. Version 1.0.2 (dir `1.0.x`).
Core `^10 || ^11`.

## Dependencies

- `drupal:link` and `drupal:node` (core). No third-party Composer/PHP libraries, no `composer.json`
  in the project.

## What it provides (from source)

- **DB table `external_links_registry`** (`external_link_status_check.install`, `hook_schema`):
  one row per unique external URL (`url_hash` = `md5(url)` unique key) with `status_code`,
  `response_time`, `title`, `description`, `thumbnail`, `last_checked`, and the source
  `entity_type`/`entity_id`. Dropped on uninstall. → [routes/dashboard-and-scan.md](routes/dashboard-and-scan.md)
- **Three routes** (`external_link_status_check.routing.yml`): report dashboard, manual scan form,
  CSV export. → [routes/dashboard-and-scan.md](routes/dashboard-and-scan.md)
- **One menu link** (`external_link_status_check.links.menu.yml`): `scan_form_link` under
  `system.admin_config_system`.
- **Three services** (`external_link_status_check.services.yml`): `...manager`
  (`ExternalLinkManager`, aliased to the FQCN), `...entity_scan_queue` (`EntityScanQueueService`),
  `...entity_hooks` (`Hook\ExternalLinkHooks`). → [services/link-manager.md](services/link-manager.md)
- **One QueueWorker plugin**: `LinkCheckerWorker` (id `external_link_checker_queue`, cron time 60s)
  in `src/Plugin/QueueWorker/`. → [services/link-manager.md](services/link-manager.md)
- **Entity + cron hooks**: both an OO `#[Hook]` class (`src/Hook/ExternalLinkHooks.php`) and
  procedural hooks in `external_link_status_check.module` implement `cron`, `entity_insert`,
  `entity_update`, `entity_predelete` (redundant — see gotchas). → [services/link-manager.md](services/link-manager.md)
- **One CSS library** `external_link_status_check/dashboard` (`css/dashboard.css`).

## What it does NOT provide

No `*.permissions.yml` (routes reuse core permissions), no `config/install` or `config/schema`
(no config objects — `provides_config_schema` is false), no `configure` route in info.yml, no
entities, no fields/formatters, no Drush commands, no submodules.

## Install / operate

1. `composer require drupal/external_link_status_check` then `drush en external_link_status_check -y`.
2. Content is queued for scanning automatically on insert/update and during cron; run cron
   (`drush cron`) so queued checks are processed.
3. Trigger a full manual scan at `/admin/config/system/external-link-scan`
   (**Configuration → System → External Link Status Scan**).
4. Review results at `/admin/reports/external-links` (filters + pager) and export via the
   **Export CSV** button.

## Gotchas (from source)

- **Queue-name mismatch:** `EntityScanQueueService` and `ExternalLinkHooks::onCron()` push items into
  the queue **`external_link_status_check_queue`**, but the `LinkCheckerWorker` plugin id is
  **`external_link_checker_queue`**. Core's cron queue processing keys on the plugin id, so items in
  `external_link_status_check_queue` are not automatically drained by that worker. The manual scan
  form (`LinkScanForm`) does not use the queue at all — it runs via the Batch API, so it works regardless.
- **Duplicate hook implementations:** the same entity/cron hooks exist both as `#[Hook]` methods in
  `ExternalLinkHooks` and as procedural functions in the `.module`; on a stock D11 install both fire.
- **Dangling service:** `external_link_status_check.services.yml` also declares
  `...hook_handler` → `Hook\HookHandler`, a class that does not exist on disk; it is untagged and
  only errors if something tries to instantiate it.
