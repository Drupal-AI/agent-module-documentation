<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActiveCampaign API Sentry Context (activecampaign_api_raven_context) — agent index

Optional submodule of **activecampaign_api** that adds ActiveCampaign request context to **Sentry**
via the `raven` module. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.2.0.

**Dependencies:** `activecampaign_api:activecampaign_api` and `raven:raven` (both required in
`activecampaign_api_raven_context.info.yml`).

- **The two hook implementations, what context they attach, and operational notes** →
  [hooks/sentry-context.md](hooks/sentry-context.md)

## What it is (from source)

- A single file: `activecampaign_api_raven_context.module`. No routes, permissions, services, config,
  schema, entities, plugins or Drush.
- Implements the parent module's two payload-alter hooks:
  - `activecampaign_api_raven_context_activecampaign_api_endpoint_createresource_alter()`
  - `activecampaign_api_raven_context_activecampaign_api_endpoint_updateresource_alter()`
- Each calls Sentry's `configureScope(fn (Scope $scope) => $scope->setContext(...))` (functions
  `Sentry\configureScope`, class `Sentry\State\Scope`, provided by `raven`) to attach a context named
  `create <resource>resource` / `update <resource>resource` holding the sent `data`
  (`json_decode(json_encode($data))`) and the endpoint `url` (`$endpoint->getUrl()`).
- Does **not** modify `$data` — it only reads it to enrich the Sentry scope. The API token is not part
  of `$data` or `getUrl()` (the token is sent as a request header by the parent module).
