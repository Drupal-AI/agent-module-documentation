<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CDNetworks Purge (cdnetworks_purge) — agent index

Purge plugin that invalidates cached content on the **CDNetworks** CDN through its authenticated
Content Management REST API. Package *Performance and scalability*. Core `^10 || ^11`. License
GPL-2.0-or-later. Version 2.0.0. **Depends on `key` and `purge`.**

## What it provides (from source)

- **Purger plugin** `CdnetworksPurgePurger` (id `cdnetworks_purge`, `types = {"url"}`,
  `multi_instance = FALSE`) — `src/Plugin/Purge/Purger/CdnetworksPurgePurger.php`. Handles Purge
  `url` invalidations; `invalidateTags`/`invalidateRegex` exist in code but are not wired via
  `routeTypeToMethod()` (only `url` -> `invalidateUrls`).
- **Tags-header plugin** `CdnetworksPurgeTagsHeader` (id `cdnetworks_purge_tags_header`,
  `header_name = "tag"`) — emits a `tag` response header when the `cachetag` setting is on.
- **API client service** `cdnetworks_purge.client` = `Client\CdnetworksPurgeApiClient`
  (implements `CdnetworksPurgeApiClientInterface`): `purgeUrl()`, `purgeRegex()`, `purgeTag()`,
  `validateConfiguration()`. Injects `@http_client` (Guzzle), `@key.repository`, `@config.factory`,
  logger channel.
- **Two forms / routes:** `ConfigForm` at `/admin/config/development/cdnetworks_purge`
  (perm `administer cdnetworks_purge configuration`); `CachePurgeForm` (manual purge) at
  `/admin/config/development/cdnetworks_purge/purge` (perm `perform cdnetworks_purge manual purge`).
  Both perms have `restrict access: true`.
- **Config object** `cdnetworks_purge.settings` (schema in `config/schema/`, defaults in
  `config/install/`).
- **`hook_requirements`** (in `.install`) flags a runtime error when credentials are missing.
- A legacy `cdnetworks_purge.drush.inc` (D8-style `hook_drush_command`) — not functional under
  modern Drush; see config doc.

## Solution docs

- **Config, keys, routes, permissions, how to operate** → [config/settings.md](config/settings.md)
- **Purger + tags-header plugins and the API client service** → [plugins/purger.md](plugins/purger.md)
