<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & permissions

## Config object `etm_ai.settings`

Form `Form\EtmAiSettingsForm` (`ConfigFormBase`) at `/admin/config/content/etm-ai`
(`_permission: administer taxonomy`). Defaults in `config/install/etm_ai.settings.yml`, schema in
`config/schema/etm_ai.schema.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `ai_provider` | string | `''` | AI provider plugin id; empty → site-wide default chat provider. |
| `ai_model` | string | `''` | Model id; empty → provider default. |
| `daily_request_limit` | integer | 500 | Max AI calls per vocabulary per UTC day (0 = unlimited). |
| `cache_results` | boolean | true | Cache AI responses ~1h (tag `etm_ai`) to cut cost. |
| `power_level` | string | `balanced` | `conservative` / `balanced` / `aggressive` — shapes prompt context and how boldly the AI proposes changes. |
| `temperature` | float | 0.7 | Passed to the provider (0 = provider default). |

The form presents provider+model as a single select (`getSimpleProviderModelOptions('chat')`,
format `provider__model`) and splits it back into `ai_provider` / `ai_model` on submit.

## Permissions (`etm_ai.permissions.yml`)

- `use etm ai features` — standard AI operations (generate, suggest, duplicates, describe, health,
  restructure, templates, chat, extract, search). `restrict access: false`.
- `use etm ai advanced features` — token-heavy operations (deep analysis, auto-tag, relationship
  mapping). `restrict access: true`.

Both are additional to the parent's `_etm_access` requirement on the per-vocabulary AI routes, so a
user needs the AI permission **and** the ability to manage that vocabulary
(`administer taxonomy` or `etm manage terms in {vid}`).

## Runtime dependency

Requires the `ai` module with at least one configured chat provider. Endpoints return HTTP 503 with
a "No AI provider is configured" message when none is available (`EtmAiService::isAvailable`).
