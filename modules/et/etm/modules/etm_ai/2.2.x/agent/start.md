<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ETM AI (etm_ai) — agent index

Submodule of project **`etm`**; module machine name **`etm_ai`**. Version **2.2.1**
(dir `2.2.x`). Core `^10.4 || ^11`. Package `Taxonomy`. GPL-2.0-or-later.
Depends on **`enhanced_taxonomy_manager`** and **`ai`** (Drupal AI module). Separate enable.
Config route: `etm_ai.settings`.

## What it is

Adds AI-powered taxonomy operations into the parent module's tree view. All model calls go through
the AI module's provider abstraction (`ai.provider` / `AiProviderPluginManager`) — there is no
direct LLM HTTP client and no API key handling in this module. The AI proposes changes as JSON
operations; a human applies them through the parent's normal (access- and CSRF-checked) endpoints.

## Provides

- **Service** `etm_ai.service` → `Service\EtmAiService` — all prompt building, provider calls, and
  strict-JSON parsing/repair. See [agent/api/service.md](api/service.md).
- **Controller** `etm_ai.controller` → `Controller\AiController` — 15 AJAX endpoints
  (`etm_ai.routing.yml`). See [agent/api/service.md](api/service.md).
- **Settings form** `Form\EtmAiSettingsForm` at `/admin/config/content/etm-ai`
  (`_permission: administer taxonomy`). Config `etm_ai.settings` (+ schema). See
  [agent/config/settings.md](config/settings.md).
- **Permissions** (`etm_ai.permissions.yml`): `use etm ai features`, `use etm ai advanced features`
  (`restrict access: true`).
- **Hook** `#[Hook('preprocess_taxonomy_tree_view')]` (`src/Hook/EtmAiHooks.php`; `#[LegacyHook]`
  wrapper in `etm_ai.module`) — attaches the `etm_ai/ai` library and AI `drupalSettings` when the
  user has `use etm ai features`.
- **Industry templates** — 7 bundled YAML files in `templates/` (schema_org, iab_content, unspsc,
  gs1_gpc, google_product, education_oer, restaurant), loaded by `listTemplates` /
  `loadTemplateStructure`.

## Access model

Every AI operation route requires **both** `_etm_access: 'TRUE'` (parent's per-vocabulary access
check) **and** a permission: `use etm ai features` for standard ops, `use etm ai advanced features`
for `deep_analysis`, `auto_tag`, `relationships`. State-changing endpoints validate the
`X-CSRF-Token` header against the parent's `taxonomy_manager` token. The `etm_ai.templates` (list)
route needs only the permission (no vocabulary in the path).

## Solution docs

- [agent/api/service.md](api/service.md) — `EtmAiService` methods, `AiController` endpoints/routes, URL fetch, JSON handling.
- [agent/config/settings.md](config/settings.md) — config keys, provider selection, permissions, daily limit.
