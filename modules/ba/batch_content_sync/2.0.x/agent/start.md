<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Batch Content Sync (batch_content_sync) — agent index

Pushes and receives **full content entities between Drupal environments** (QA/Stage/Prod). A node plus its
referenced media, images, files, paragraphs, taxonomy terms and Layout Builder sections is normalized to one
JSON payload and POSTed by a **Batch API** run to a target site; the target re-creates or overrides the entity
(matched by UUID). Auth is a **single shared access token**. Version 2.0.2. Core `^10 || ^11`.

## Dependencies
Core only: `rest`, `serialization`, `node`, `file`. No composer requirements. (README mentions media/paragraphs,
but those are optional — handled if present.)

## What it provides
- **Config object** `batch_content_sync.settings` — `qa_url`, `stage_url`, `prod_url`, `access_token`,
  `existing_content_behavior` (override|clone). No config schema shipped.
- **Settings form** `Form\SettingsForm` at route `batch_content_sync.settings`
  (`/admin/config/services/batch-content-sync`, perm `administer site configuration`) — includes an AJAX
  "Generate Token" button (`bin2hex(random_bytes(16))`).
- **Actions** (`type: node`): `Plugin\Action\PushContentQA|Stage|Prod` — start a batch pushing selected nodes.
- **Batch** `Batch\ContentSyncBatch` — `startBatch()`/`processItem()` call the sync service per node.
- **Service** `batch_content_sync.sync_service` (`Service\SyncService`) — `pushToRemote()` normalizes a node
  recursively (base64 media/files, Layout Builder) and POSTs it to the configured env URL.
- **Service** `batch_content_sync.logger` (`Service\SyncLogger`) — writes sent/received payloads (base64
  truncated) to the `batch_content_sync_log` table (`hook_schema` in `.install`).
- **Receiver** `Controller\ReceiverController::receive` — the inbound endpoint that rebuilds entities from a
  payload (routes below).
- **Log UI** `Controller\ContentSyncLogController` — `view()`/`detail()` at `/admin/content/sync-log[/{id}]`.
- **REST resources** `Plugin\rest\resource\PushContentQa|Stage|Prod` (`/api/push-content-*`, cookie auth) —
  thin wrappers over the sync service. Note: they call `pushToRemote($nid, $env)` with **2 args** while the
  method signature requires 3 (`$langcode` has no default) → these plugins are effectively broken.

## Routes
- `POST /api/push-entity-qa|stage|prod` → `ReceiverController::receive` (the receive endpoints).
- `/admin/config/services/batch-content-sync` → settings form.
- `/admin/content/sync-log`, `/admin/content/sync-log/{id}` → log list + JSON detail.
- `/admin/config/batch_content_sync` → admin menu block.

## Solution docs
- [config/settings.md](config/settings.md) — settings form, config keys, token generation, install/enable.
- [api/push-and-receive.md](api/push-and-receive.md) — push flow (actions → batch → SyncService), the receive
  endpoints and payload shape, normalization/rebuild rules, and the sync log.

No permissions of its own (all admin routes use `administer site configuration`).
