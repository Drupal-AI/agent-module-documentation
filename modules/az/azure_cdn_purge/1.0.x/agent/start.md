<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Azure CDN Purger (azure_cdn_purge) — agent index

A **Purge** (`drupal/purge` `^3.2`) extension that invalidates cached paths on **Azure CDN** and
**Azure Front Door**. On `hook_node_update` it queues the node's alias; queued/manual paths are
chunked and POSTed to the Azure purge REST API after an Azure AD OAuth2 client-credentials token
exchange. Package *Purge - reverse proxies & CDNs*. Core `^10 || ^11`. Version **1.0.4**.
No config schema, no Drush, no submodules.

## What it provides (from source)

- **Purger** `AzurePurger` (id `azurecdn`, `src/Plugin/Purge/Purger/AzurePurger.php`) — types
  `path` + `wildcardpath`, `multi_instance = FALSE`. `invalidate()` chunks by `chunk_size`,
  `sleep($chunk_delay)` between chunks, calls `purgeChunk()`.
- **Queuer** `PathQueuer` (id `path_queuer`, `src/Plugin/Purge/Queuer/PathQueuer.php`) — empty
  subclass of `QueuerBase`, `enable_by_default = true`.
- **Processor** `AzureProcessor` (id `azure_processor`, `src/Plugin/Purge/Processor/AzureProcessor.php`)
  — empty subclass of `ProcessorBase`, `enable_by_default = true`.
- **Hook** `azure_cdn_purge_node_update()` (`.module`) — resolves `path_alias.manager` alias for
  `/node/{id}` and adds a `path` invalidation to `purge.queue` via `path_queuer`.
- **Permission** `administer azure cdn purge` (`.permissions.yml`).
- **Two routes / forms**, both gated by that permission (`.routing.yml`):
  - `azure_cdn_purge.admin_config_form` → `/admin/config/services/azure` → `AzureCdnSettingsForm`.
  - `azure_cdn_purge.purge_form` → `/admin/config/services/azure/purge` → `AzureCdnPurgeForm`.
- Menu link `azure_cdn_purge.admin_settings` under `system.admin_config_services`; two local tasks
  (Settings, Purge).

## Solution docs

- **Settings form, the `azure_cdn_purge.settings` config object, and all keys** →
  [config/settings.md](config/settings.md)
- **The purge mechanism: OAuth token exchange, REST call, chunking, node-update queuing, manual
  purge** → [api/purger.md](api/purger.md)
