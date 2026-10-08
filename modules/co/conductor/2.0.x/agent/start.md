<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing Assistant / Conductor (conductor) — agent index

info.yml **name: "Writing Assistant"**, **description: "Integrates Conductor with Canvas"**, package
**SEO**. Embeds the hosted **Conductor** SEO/AI writing-assistant as a **Canvas** extension: a
front-end app (built JS in `app/dist/`, attached via `conductor.app` library and registered as a
Canvas extension through `drupalSettings.canvasExtension.conductor`) that reaches the Conductor SaaS
API through a **Drupal-side proxy** which injects the site's shared Conductor credentials. It maps
Canvas entities to Conductor **draft UUIDs** in a local table and enforces a per-year draft quota.
Version **2.0.3**. Core `^11`. License GPL-2.0-or-later.

## Dependencies

- Drupal modules: **`canvas:canvas`** (the extension host / experience builder) and **`drupal:key`**
  (credential storage). No submodules, no third-party PHP libraries.
- Front-end: a prebuilt Vite/React app under `app/dist/` (source in `app/`; `npm ci && npm run build`
  to rebuild). Depends on the `canvas/canvas-ui` library.

## Credentials model (important)

Conductor is authenticated with an **api_key + shared_secret pair**, stored in a **Key entity** as a
single JSON value: `{"api_key": "...", "shared_secret": "..."}` (README uses key type "Authentication
(Multivalue)"). Config `conductor.settings:key_id` holds only the chosen key's id — the secret itself is
never written to config. `ConductorHttpApiClient::getCredentials()` reads and `json_decode`s the key
value; every upstream call carries `apiKey=<api_key>` and `sig=md5(api_key . shared_secret . time())`
in the query string. Set the key on the settings form at `/admin/config/services/conductor`
(permission `administer conductor`, `restrict access: TRUE`).

## What it provides (from source)

- **Authenticated API proxy** — route `conductor.proxy` `/conductor/proxy/**` (GET/PUT/POST/DELETE,
  `no_cache`, permission `use conductor`). `ConductorPathProcessor` moves the trailing path into a
  `resource` query param; `ConductorProxyController` → `ConductorHttpApiClient::forward()` relays the
  request to `https://api.conductor.com/<resource>` (fixed base URL, parameter
  `conductor.api_base_url`) with credentials attached, and supports NDJSON **streaming** responses
  (`Accept: application/x-ndjson` → `StreamedResponse`). A `ConductorRouteOptionsEventSubscriber`
  sets `_disable_route_normalizer` so the proxy path survives the Redirect module.
- **Draft-mapping API** — route `conductor.api.draft`
  `/conductor/api/draft/{entity_type}/{entity_id}` (GET/PUT/POST/DELETE, permission `use conductor`).
  `ConductorDraftApiController` links a Canvas entity to a Conductor draft UUID via `DraftRepository`
  (create is idempotent; enforces one-draft-per-entity, one-entity-per-draft, and the per-year quota).
- **Settings API** — route `conductor.api.settings` `/conductor/api/settings` (GET,
  `use conductor`): returns `{accountId, maxDrafts, usedDrafts}` for the front-end.
- **Drafts dashboard** — route `conductor.draft_dashboard` `/admin/reports/conductor` (permission
  `use conductor`): a table of the current year's drafts with links to `app.conductor.com`, plus a
  usage counter. Menu links under *Configuration → Services* and *Reports*.
- **Local storage** — table `conductor_draft_map` (`hook_schema`): entity_id + entity_type (primary
  key) → draft_id (unique) with created/changed/deleted. Dropped on uninstall.
- **Draft cleanup** — `DraftCleanup` runs on `hook_cron` (via `ConductorHooks`), deleting orphaned
  Conductor-side drafts (title prefix "Untitled Canvas draft:", unmapped locally, older than
  `delete_unlinked_drafts_after`). **Disabled by default** (`enable_draft_cleanup: false`);
  `conductor_update_10001` turns it off for existing sites.
- **Entity cleanup** — `hook_entity_delete` soft-deletes the local mapping row for a deleted entity.
- **Permissions** — `use conductor` (editor: proxy + draft/settings API + dashboard) and
  `administer conductor` (`restrict access: TRUE`; settings form only).
- **Config** — `conductor.settings` (`key_id`, `max_drafts` default 15, `delete_unlinked_drafts_after`
  default 21600s, `enable_draft_cleanup`) with schema in `config/schema/conductor.schema.yml`.

## Data flow

Content/topic data typed in the Canvas Writing Assistant is sent to the Conductor SaaS for SEO
analysis via the proxy; drafts live on Conductor's side (only the UUID mapping is local). Review this
third-party data flow against your data-handling policy.

## Solution docs

- **Proxy, HTTP API client, streaming, path processor, route normalizer, credentials/signature** →
  [api.md](api.md)
- **Draft-map table, draft CRUD API, quota, dashboard, cron cleanup, entity-delete hook** →
  [drafts.md](drafts.md)
