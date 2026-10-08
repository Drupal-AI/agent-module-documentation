<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Apigee Edge (apigee_edge) — agent index

Connects a Drupal site to a **Google Apigee** organization (Apigee Edge public/private cloud, or
Apigee X/hybrid) to build an **API developer portal**. It mirrors Apigee **Developers** onto Drupal
users, and exposes **Developer Apps**, **API Products**, and app **credentials/API keys** as Drupal
entities backed by the Apigee Management API (via the `apigee/apigee-client-php` SDK). No local
database storage for these — every read/write is a live API call, cached in memory/`cache` bins.

- Dependencies (core): `file`, `user`, `filter`, `options`, `system`; (contrib) `entity`, **`key`**.
  Composer also pulls `apigee/apigee-client-php ~4.1` and `php-http/guzzle7-adapter`. PHP `>= 8.3`.
- `configure` route: **`apigee_edge.settings`** (`/admin/config/apigee-edge/settings`).
- Defines permissions: **yes**. Drush commands: **yes**. Config schema: **yes**. Plugin types: **yes**
  (`ApigeeFieldStorageFormat`, plus the internal `EdgeEntityType` annotation for Apigee entities).
- Submodules: `apigee_edge_teams`, `apigee_edge_apiproduct_rbac`, `apigee_edge_debug`,
  `apigee_edge_actions`.

## Solution docs
- **Connect to Apigee (Key entity, org, endpoint, auth type, timeouts/proxy, test connection)** →
  [configure/connection.md](configure/connection.md)
- **Entity types + their settings forms (developers, apps, products, sync, caching, display)** →
  [configure/entities-and-settings.md](configure/entities-and-settings.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)
- **Drush commands (developer sync, create Apigee role)** → [drush/commands.md](drush/commands.md)
- **Services / SDK client / entity controllers** → [api/services.md](api/services.md)
- **Plugin types (field storage format, key plugins, Apigee entity types)** →
  [plugins/plugins.md](plugins/plugins.md)
- **Hooks it invokes + the `api_product_access` extension point** → [hooks/hooks.md](hooks/hooks.md)

## Key facts
- Active auth key id lives in config `apigee_edge.auth:active_key`; it names a **Key** entity of type
  `apigee_auth` (`ApigeeAuthKeyType`) whose value is the credentials (org, username/password or
  client id/secret or GCP service-account JSON, endpoint, auth_type, instance_type).
- Key providers shipped: `apigee_edge_environment_variables`, `apigee_edge_private_file` (plus any
  core Key provider). Key input plugin: `apigee_auth_input`.
- HTTP config object `apigee_edge.client`: `http_client_connect_timeout` (30), `http_client_timeout`
  (30), `http_client_proxy` ('').
- Entity types (Apigee-backed, non-SQL): `developer`, `developer_app`, `api_product`. Central service
  **`apigee_edge.sdk_connector`** (`SDKConnector`) builds the Apigee `Client`.
- Permissions: `administer apigee edge`, `bypass api product access control`, plus generated
  `developer_app` entity permissions (view/create/update/delete own|any, analytics, *_api_key,
  edit_api_products).
- Drush: `apigee-edge:sync`, `apigee-edge:create-edge-role` (alias `create-edge-role`).
