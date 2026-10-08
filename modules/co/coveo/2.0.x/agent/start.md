<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Coveo (coveo) — agent index

Integrates Drupal with the **Coveo hosted (SaaS) search platform**. Base module `coveo` defines the
config entities, admin UI, security-provider plugin type and API service layer; three submodules add
Search API push, secured search and the Atomic UI. Package **Search**. Core `^10 || ^11`, **PHP >= 8.3**,
`ext-curl`, and several `neclimdul/coveo-*` Composer libraries. License GPL-2.0-or-later. Version 2.0.1.

- **Organizations, search components, routes, permissions, config schema** → [config/organizations-and-components.md](config/organizations-and-components.md)
- **Security-provider plugin type + `/coveo/refresh` token endpoint** → [plugins/security-providers.md](plugins/security-providers.md)
- **API service layer (factories, HTTP client, push/index helper)** → [api/services.md](api/services.md)

## What it actually is (base module)

- Two config entities (`src/Entity/`): **`coveo_organization`** (id/label, `organization_id`,
  `read_only`, `auto_sync`, `prefix`, `push_source_id`, `push_key`) and **`coveo_search_component`**
  (id/label, `search_key`, `organization_name`, `security_provider`). Both `admin_permission =
  "administer coveo search"`, config prefixes `organization` / `search_component`.
- Admin UI at **`/admin/config/search/coveo`** (`CoveoOverview`), organization + search-component
  collections/forms, and a **Security Providers** overview. Menu under *Configuration → Search*.
- One plugin type: **`coveo_security_provider`** (attribute `Drupal\coveo\Attribute\CoveoSecurityProvider`,
  legacy annotation also present; manager `plugin.manager.coveo_security_provider`). Ships
  `EmailProvider`, `TokenProvider`, and abstract `AbstractSecuredUserProvider`.
- One route controller of note: **`SearchTokenRefresh`** at `/coveo/refresh` returning a JSON
  `{token}` for the current user (permission `access coveo search`).
- API layer in `src/API/**`: Guzzle-backed factories (`PushApiFactory`, `FieldApiFactory`,
  `SearchApiFactory`, `SecurityCacheFactory`, `SourceApiFactory`) that wrap the `neclimdul/coveo-*`
  OpenAPI clients; `src/Coveo/Index.php` performs the batched push + file-container upload flow.
- Hooks live in `src/Hook/CoveoHooks.php` (only `hook_help`, wired via `coveo.module` `LegacyHook`).

## Permissions (`coveo.permissions.yml`)

- **`administer coveo search`** — `restrict access: true`; gates all `/admin/config/search/coveo/**`
  routes and both config-entity admin permissions.
- **`access coveo search`** — gates the `/coveo/refresh` token endpoint.

## Submodules (each documented in its own tree under `modules/`)

- **coveo_search_api** (requires `search_api`) — `search_api` backend `coveo` (`SearchApiCoveoBackend`),
  processors, a file data type + computed absolute-file-URI field, field sync and event subscribers.
- **coveo_secured_search** (requires `coveo_search_api`) — `coveo_custom_security_provider` config
  entity, a `coveo_custom_security_provider` plugin type, `Drupal Provider`, and the `coveo_identity`
  Search API backend that pushes Drupal identities to Coveo.
- **coveo_atomic** — a derivative `coveo_atomic` block per search component that renders Coveo's Atomic
  web-component UI, a Twig extension (`atomic_field`/`atomic_fields`), and the `atomic` JS/CSS library.

## Notes

- Credentials (`push_key`, `search_key`) are stored on the config entities as plain string properties
  entered through `password` form fields; there is **no** env-var or Key-module mechanism in this
  module — document the mechanism as-is (config storage) and do not assume otherwise.
- The HTTP client is a plain `GuzzleHttp\Client` (`coveo.rest.client`) with default TLS verification;
  API base URLs come from the vendored `neclimdul/coveo-*` client `Configuration` classes.
