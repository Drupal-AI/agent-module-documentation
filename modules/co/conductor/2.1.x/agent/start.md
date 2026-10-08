<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing Assistant / Conductor (conductor) — agent index

info.yml **name: "Writing Assistant"**, **description: "Integrates Conductor with Canvas"**, package
**SEO**. Embeds the hosted **Conductor** SEO/AI writing-assistant as a **Canvas** extension and,
optionally, on the **node edit form** of selected content types: a prebuilt front-end app (built JS in
`app/dist/`, attached via the `conductor.app` / `conductor.node_app` libraries and registered as a
Canvas extension through `drupalSettings.canvasExtension.conductor`) that reaches the Conductor SaaS API
through a **Drupal-side proxy** which injects the site's shared Conductor credentials. It maps
Canvas/node entities to Conductor **draft UUIDs** in a local table with a per-year draft quota and a
per-draft content score. Version **2.1.0**. Core `^11`. License GPL-2.0-or-later.

## Dependencies

- Drupal modules: **`canvas:canvas`** (the extension host / experience builder) and **`drupal:key`**
  (credential storage). No submodules, no third-party PHP libraries.
- Front-end: a prebuilt Vite/React app under `app/dist/` (source in `app/`; `npm ci && npm run build`
  to rebuild). The Canvas embed depends on `canvas/canvas-ui`; the node-form embed supplies the
  React/Redux globals itself via `conductor/conductor.node_globals`.

## Credentials model (important)

Conductor is authenticated from a **Key entity** holding a single JSON value. Two schemes are
supported (`ConductorHttpApiClient::applyAuthentication()`), `api_token` taking priority when both are
present:

- **`api_token`** (recommended) — sent as `Authorization: Bearer <token>`.
- **`api_key` + `shared_secret`** (legacy) — every call carries `apiKey=<api_key>` and
  `sig=md5(api_key . shared_secret . time())` in the query string.

Config `conductor.settings:key_id` holds only the chosen key's id — the secret itself is never written
to config. `ConductorHttpApiClient::getCredentials()` reads and `json_decode`s the key value. Set the
key on the settings form at `/admin/config/services/conductor` (permission `administer conductor`,
`restrict access: TRUE`).

## What it provides (from source)

- **Authenticated API proxy** — route `conductor.proxy` `/conductor/proxy/**` (GET/PUT/POST/DELETE,
  `no_cache`, permission `use conductor`). `ConductorPathProcessor` moves the trailing path into a
  `resource` query param; `ConductorProxyController` → `ConductorHttpApiClient::forward()` relays the
  request to `https://api.conductor.com/<resource>` (fixed base URL, parameter
  `conductor.api_base_url`) with credentials attached, supporting NDJSON **streaming** responses.
  → [api/proxy.md](api/proxy.md)
- **Draft-mapping API** — route `conductor.api.draft` `/conductor/api/draft/{entity_type}/{entity_id}`
  (GET/PUT/POST/DELETE/PATCH, permission `use conductor`). `ConductorDraftApiController` links a
  Canvas/node entity to a Conductor draft UUID via `DraftRepository` and stores a per-draft score.
  → [api/endpoints.md](api/endpoints.md)
- **Node-form extension host** — route `conductor.node_extension`
  `/conductor/node-extension/node/{node_id}` (permission `use conductor`; controller checks
  `node->access('update')` + enabled-bundle). Renders the portal the app mounts into and reports the
  formatted-text fields it may write into. → [api/endpoints.md](api/endpoints.md)
- **Settings API** — route `conductor.api.settings` `/conductor/api/settings` (GET, `use conductor`):
  returns `{accountId, maxDrafts, usedDrafts}`. → [api/proxy.md](api/proxy.md)
- **Drafts dashboard** — route `conductor.draft_dashboard` `/admin/reports/conductor` (permission
  `use conductor`): a table of the current year's drafts (entity, dates, score, status) with links to
  `app.conductor.com`, plus a usage counter. → [api/endpoints.md](api/endpoints.md)
- **Settings form & config** — `ConductorConfigForm` at `/admin/config/services/conductor` writes
  `conductor.settings` (`key_id`, `enable_draft_cleanup`, `node_types`); schema in
  `config/schema/conductor.schema.yml`. → [config/settings.md](config/settings.md)
- **Local storage** — table `conductor_draft_map` (`hook_schema`): entity_id + entity_type (primary
  key) → draft_id (unique), created/changed/deleted/score. Dropped on uninstall.
- **Draft cleanup** — `DraftCleanup` on `hook_cron` (via `ConductorHooks`) deletes orphaned
  Conductor-side drafts; **disabled by default**. **Entity delete** — `hook_entity_delete`
  soft-deletes the local mapping. → [api/endpoints.md](api/endpoints.md)
- **Permissions** — `use conductor` (editor: proxy + draft/settings API + node extension + dashboard)
  and `administer conductor` (`restrict access: TRUE`; settings form only).
  → [config/settings.md](config/settings.md)

## Data flow

Content/topic data typed in the Writing Assistant is sent to the Conductor SaaS for SEO analysis via
the proxy; drafts live on Conductor's side (only the UUID mapping and a score are local). Review this
third-party data flow against your data-handling policy.

## Solution docs

- **Settings form, config keys, credentials model, permissions, node-type opt-in** →
  [config/settings.md](config/settings.md)
- **Proxy, HTTP API client, streaming, path processor, route normalizer, settings API** →
  [api/proxy.md](api/proxy.md)
- **Draft-map table & repository, draft CRUD + score API, node-extension host, dashboard, cron
  cleanup, entity-delete hook** → [api/endpoints.md](api/endpoints.md)
