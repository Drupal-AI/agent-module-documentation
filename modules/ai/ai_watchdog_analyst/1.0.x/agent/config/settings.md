<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings form & config object

## Install / enable

```bash
composer require drupal/ai_watchdog_analyst
drush en ai_watchdog_analyst -y
```

Requires core `dblog` and the `ai` module (^1.0). Before it can produce anything, configure at
least one **chat-capable AI provider** in the AI module (e.g. `/admin/config/ai/providers`) — this
module has no provider of its own; it only orchestrates the AI module.

## Settings form

- Route `ai_watchdog_analyst.settings` → `/admin/config/ai/watchdog-analyst`, form
  `Form\SettingsForm` (`getFormId() = 'ai_watchdog_analyst_settings'`).
- Permission: **`administer site configuration`**.
- Menu link `ai_watchdog_analyst.links.menu.yml` places it under *Configuration → AI*
  (parent `ai.admin_settings`).

Fields (`buildForm`):

- **AI Provider** (`provider_id`, `select`, required) — options are every AI provider definition
  from `AiProviderPluginManager::getDefinitions()`. Has an `#ajax` callback
  (`updateModelsCallback`) that repopulates the model field when the provider changes.
- **Model ID** (`model_id`, required) — rendered as a `select` when the chosen provider returns
  chat models from `getConfiguredModels('chat')` (only if `isUsable('chat')`), otherwise a free
  `textfield`. When empty and the provider is `azure`, the form pre-fills `openai-gpt-4o-mini`.
- **System Prompt** (`system_prompt`, `textarea`, 15 rows, required) — the AI persona/instructions.
  Pre-filled with a long default "senior Drupal expert" prompt that dictates the answer sections
  (Root Cause / Context / Contrib Module Check / Solution / Prevention / References).

`submitForm()` saves `provider_id`, `model_id`, `system_prompt` into `ai_watchdog_analyst.settings`.

## Config object & schema

Config object `ai_watchdog_analyst.settings` (schema `config/schema/ai_watchdog_analyst.schema.yml`,
type `config_object`):

| key | type | notes |
|-----|------|-------|
| `provider_id` | string | AI provider plugin id. Runtime default `azure` if unset. |
| `model_id` | string | Chat model id. If empty, `LogAnalyzerService::getDefaultChatModel()` picks the provider's first configured chat model. |
| `system_prompt` | text (translatable) | Overrides the built-in default prompt when non-empty. |

No `config/install/` ships — the object is created on first save; until then the runtime defaults
above apply. `ai_watchdog_analyst.config_translation.yml` exposes the settings for config
translation.

## Operating notes

- Nothing runs on log write. Analysis is triggered only by an operator clicking a button, which
  hits one of the two controller routes (see [../api/analysis.md](../api/analysis.md)).
- Results are cached 24h per `md5(type:message)`, so re-clicking the same error is free; changing
  the model/prompt does **not** invalidate existing cache entries (key ignores config).
- A "respond in <site current language>" instruction is appended to whatever system prompt is
  active, so answers follow the interface language.
