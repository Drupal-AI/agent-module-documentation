<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BrightEdge Autopilot Page Publisher (brightedge_autopilot_page_publisher) — agent index

Drupal-side bridge for **BrightEdge Autopilot Page Publisher**. Updates page **title / meta
description / H1** and arbitrary **XPath-targeted** text/image/link content from BrightEdge
recommendations, over three POST REST endpoints, plus an in-form Google **SERP preview**.
Package `BrightEdge`. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 8.x-1.61.

- **The three REST endpoints (auth, request fields, behavior)** → [api/rest-endpoints.md](api/rest-endpoints.md)
- **The response-rewrite subscriber + `beapp_seo_references` table + settings** → [api/xpath-rewrite.md](api/xpath-rewrite.md)
- **The content-form SERP preview + metatag write-back (`hook_form_alter`)** → [forms/serp-preview.md](forms/serp-preview.md)

## Dependencies

Drupal modules: **`metatag`**, **`node`**, **`token`** (from `.info.yml`). No composer `require`
beyond core. No submodules. No `*.permissions.yml` (module defines **no** permissions of its own).

## What it provides (from source)

- **Routes** (`*.routing.yml`) — all `methods: [POST]`, all `_access: 'TRUE'`:
  - `…update_entity_rest_api` → `POST /beapp/v1/drupal/update-meta` → `UpdateEntityRestController::updateMeta`
  - `…read_entity_rest_api` → `POST /beapp/v1/drupal/read-meta` → `ReadEntityRestController::readMeta`
  - `…agent_update_content` → `POST /beapp/v1/drupal/update-xpath` → `BeAPPAgentUpdateContent::updateContentViaXpath`
  - Each controller authenticates in-code via `BeAPPLibrary::authenticateUser()` (username + password,
    requires the **`administer nodes`** permission) — see api docs.
- **Services** (`*.services.yml`):
  - `brightedge_autopilot_page_publisher.library` → `BeAPPLibrary` (helpers: auth, route lookup,
    XPath validation, DB read, response formatting).
  - `brightedge_autopilot_page_publisher.content_modifier` → `EventSubscriber\BeAPPContentModifierSubscriber`
    (`event_subscriber`; args `@database`, `@current_route_match`) — rewrites HTML responses.
- **Hooks** (`.module`): `hook_form_alter()` adds the `beapp_meta_snippet` fieldset + SERP preview to
  content-entity forms; `beapp_metatags_form_submit()` writes SEO title/description into the metatag field.
- **Schema** (`.install`): `hook_schema()` creates table **`beapp_seo_references`**
  (`id`, `page_path`, `xpath_content`, `created_at`, `updated_at`) storing serialized XPath overrides.
- **Config**: `brightedge_autopilot_page_publisher.settings` — one key `whitelisted_params` (sequence
  of query-param names). Schema in `config/schema/…`. No settings form / menu link (`configure` = null).
- **Library**: `beapp_meta_snippet` (`assets/js/BeAPPMetaSnippet.js` + CSS; deps core jquery/once/drupal).

## Not present

No plugins, no Drush, no permissions.yml, no menu links/config form, no external HTTP API keys/tokens
(auth is a Drupal account password check). The prior stub's "API credentials env-backed" note was wrong.
