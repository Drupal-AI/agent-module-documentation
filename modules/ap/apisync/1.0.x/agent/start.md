<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Api Sync module (apisync) — agent index

Framework to integrate Drupal with a REST / **OData v4** API (Microsoft Navision / Business Central), syncing entities to/from the remote system. Fork of the Salesforce Suite. Package `liip`, core `^10 || ^11`, version 1.0.0-alpha22. `configure: apisync.admin_config_apisync`.

## What the base module provides
- **OData client** `Drupal\apisync\OData\ODataClient` — service `apisync.odata_client` (args: `http_client`, `config.factory`, `state`, `cache.default`, `datetime.time`, auth manager). Methods: `query`/`queryAll`/`queryMore`, `objects`/`objectDescribe`, `objectRead`/`objectCreate`/`objectUpdate`/`objectDelete`. Base URL = `apisync.settings:instance_url`; metadata from `metadata_url`. Uses core Guzzle `@http_client` (default TLS verification); `allow_redirects => FALSE`.
- **Auth plugin type** `apisync_auth_provider` (annotation `Drupal\apisync\Annotation\ApiSyncAuthProvider`, dir `Plugin/ApiSyncAuthProvider`, manager service `plugin.manager.apisync.auth_providers`, fallback `broken`). Interface `ApiSyncAuthProviderInterface` (`appendAuthHeaders`, `getAccessToken`, `isTokenBasedProvider`, `refreshAccessToken`, `clearAccessToken`). Base class `ApiSyncAuthProviderPluginBase`. Providers ship in submodules (`apisync_basicauth`, `apisync_oauth`).
- **Config entity** `apisync_auth` (`Drupal\apisync\Entity\ApiSyncAuthConfig`) — an authorization instance selecting a provider plugin + `provider_settings`; the active one is named in `apisync.settings:apisync_auth_provider`. `admin_permission = authorize apisync`.
- **Settings** config object `apisync.settings` (see [agent/config/settings.md](config/settings.md)).
- **OData value objects**: `SelectQuery`/`SelectQueryResult`, `ODataObject`, `ODataMetadataParser`, `XMLResponse` (`src/OData/`).
- **Drush** `odata:list-objects`, `odata:describe-fields`, `odata:query-object`, `odata:list-providers` (`src/Commands/ApiSyncCommands.php`).

## Routes & permissions
Routes under `/admin/config/apisync` (`apisync.routing.yml`): `apisync.global_settings` (`administer apisync`), `apisync.auth_config` + `entity.apisync_auth.*` (`authorize apisync` / entity access). Permissions (`apisync.permissions.yml`, both `restrict access: TRUE`): **administer apisync**, **authorize apisync**. Menu/task/action links wire the admin config tree.

## Submodules (each documented separately)
- [apisync_mapping](../../modules/apisync_mapping/1.0.x/agent/start.md) — mapping + mapped-object entities, field-map plugins (`apisync_mapping_field`), events. Deps: `dynamic_entity_reference`, `typed_data`, `apisync_logger`.
- [apisync_mapping_ui](../../modules/apisync_mapping_ui/1.0.x/agent/start.md) — admin UI for mappings/mapped objects.
- [apisync_basicauth](../../modules/apisync_basicauth/1.0.x/agent/start.md) — HTTP Basic auth provider.
- [apisync_oauth](../../modules/apisync_oauth/1.0.x/agent/start.md) — OAuth2 client-credentials provider (uses `oauth2_client`).
- [apisync_pull](../../modules/apisync_pull/1.0.x/agent/start.md) — import remote → Drupal (cron + standalone endpoints, queue).
- [apisync_push](../../modules/apisync_push/1.0.x/agent/start.md) — export Drupal → remote (real-time + async queue).
- [apisync_logger](../../modules/apisync_logger/1.0.x/agent/start.md) — centralized suite logging.

## Solution docs
- [agent/config/settings.md](config/settings.md) — `apisync.settings` keys, schema, admin routes.
- [agent/api/odata-client.md](api/odata-client.md) — using `ODataClient` and building queries.
- [agent/auth/providers.md](auth/providers.md) — the auth plugin type and `apisync_auth` config entity.

## Operating notes
Store the remote API **credentials** as secrets and serve the API over **HTTPS** (the client honors the scheme of `instance_url`). Exchanged records may contain **PII** — handle per privacy obligations. All configuration is gated by the restricted `administer apisync` / `authorize apisync` permissions; there is no additional access role.
