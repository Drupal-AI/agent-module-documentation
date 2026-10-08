<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# apisync.settings — global settings

Config object `apisync.settings` (schema `config/schema/apisync.schema.yml`, defaults `config/install/apisync.settings.yml`). Edited at `/admin/config/apisync/settings` (route `apisync.global_settings`, form `Drupal\apisync\Form\SettingsForm`, permission `administer apisync`).

## Keys
- `instance_url` (string, default `''`) — base URL of the remote OData service. `ODataClient::getInstanceUrl()` right-trims `/`; relative request paths are prefixed with it. The scheme you set here decides TLS on the wire — use `https://`.
- `metadata_url` (string, default `''`) — URL of the OData `$metadata` document. `ODataClient::objects()` fetches + parses it (`ODataMetadataParser`) to list object types, cached under `odata:objects`.
- `apisync_auth_provider` (string, default `''`) — id of the active `apisync_auth` config entity that supplies authentication. Set automatically when an auth config is saved with "Save and set default".
- `global_push_limit` (int, default `100000`) — max records per push-queue run; `0` = no limit.
- `pull_max_queue_size` (int, default `100000`) — max items enqueued for pull at once; `0` = no limit.
- `standalone` (bool, default `false`) — when TRUE, cron does **not** process push/pull queues; instead the standalone HTTP endpoints (`apisync_push`/`apisync_pull`) must be called by an external scheduler. Endpoints are protected by the site cron key.
- `limit_mapped_object_revisions` (int, default `10`) — retained revisions per mapped object; `0` = unlimited.
- `short_term_cache_lifetime` (int, default `3600`) — seconds for short-term metadata (object types/descriptions).
- `long_term_cache_lifetime` (int, default `604800`) — seconds for long-term metadata (API versions).
- `allowlist_entity_types` (string, schema-only, one per line) — limit remote entity types exposed.
- `allowlist_entity_sets` (string, schema-only, one per line) — limit remote entity sets exposed.

## Admin config tree
- `/admin/config/apisync` (`apisync.admin_config_apisync`) — menu block, `administer apisync+authorize apisync`.
- `/admin/config/apisync/settings` — global settings (above).
- `/admin/config/apisync/authorize` + `/authorize/list` + add/edit/revoke/delete — `apisync_auth` entity management (`authorize apisync`). See [../auth/providers.md](../auth/providers.md).

## Install / uninstall
`apisync_update_9100()` back-fills empty `instance_url`/`metadata_url`. `hook_uninstall` purges state keys `apisync.instance_url`, `apisync.access_token`, `apisync.refresh_token`, `apisync.identity`, `apisync.last_requirements_check`, `apisync.usage`, `apisync.tls_status`.
