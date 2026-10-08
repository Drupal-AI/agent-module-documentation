<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Groq Provider (ai_provider_groq) — agent index

Registers **Groq** as a provider for Drupal's **`ai`** module. It is a thin adapter over Groq's
OpenAI-compatible API: a single `AiProvider` plugin (`id: groq`) extending the AI module's shared
`OpenAiBasedProviderClientBase`, pointed at `https://api.groq.com/openai/v1`, supporting the **`chat`**
operation only. Model discovery is live (`GET /models`, cached) with text-to-speech/Whisper models
filtered out and a hardcoded allow-list for function-calling models. Groq's selling point is latency
(purpose-built inference hardware), so it fits interactive uses — inline suggestions, an editorial
assistant, query reformulation — where a sub-second response changes what the feature can be.

Configuration is one admin form (API key + default request tuning, plus optional per-operation
overrides). The API key is held by the **`key`** module: the form stores a Key entity's machine name,
and the secret is resolved only at request time — keep it in an environment-variable-backed Key,
never in exported config.

- Depends on: `ai:ai`, `key:key`. Composer: `drupal/ai:^1.2.0`.
- Core: `^10.2 || ^11`. Package: `AI Providers`. Version **1.2.0-rc1** (release candidate).
- Settings page / `configure` route: **`ai_provider_groq.settings_form`**
  (`/admin/config/ai/providers/groq`), permission `administer ai providers`.
- Provides config schema (settings + overrides). **No** permissions of its own, **no** drush, **no**
  plugin *types* (it is one plugin instance of the AI module's `AiProvider` type).

## What you'd do → where

- **Set the API key / choose default temperature, max tokens, reasoning format, JSON mode / add
  per-operation overrides** → [configure/settings.md](configure/settings.md)
- **Understand the `groq` plugin: models list & filtering, capabilities, chat call, api_defaults** →
  [plugins/provider.md](plugins/provider.md)
- **Select Groq for an operation site-wide** → done on the core AI settings form
  (`ai.settings:default_providers`); this module only adds a link/notice there.

## Key facts (real machine names)

- Plugin: `AiProvider` id **`groq`**, class
  `Drupal\ai_provider_groq\Plugin\AiProvider\GroqProvider` (uses `ChatTrait`), manager service
  `ai.provider`. Endpoint `https://api.groq.com/openai/v1`. Supported ops: `chat`.
- Inherited capabilities: `StreamChatOutput`, `ChatFiberSupport`.
- Setup data: `key_config_name => api_key`, default chat model `llama-3.3-70b-versatile`.
- Route: `ai_provider_groq.settings_form` → `/admin/config/ai/providers/groq`
  (`_permission: administer ai providers`). Menu link: `ai_provider_groq.settings_menu`.
- Form: `Drupal\ai_provider_groq\Form\GroqConfigForm` (form id `groq_settings`).
- Config objects: `ai_provider_groq.settings` (`api_key`, `reasoning_format`, `temperature`,
  `max_tokens`, `json_mode`) and `ai_provider_groq.overrides` (`operation_overrides` sequence).
- Definitions: `definitions/api_defaults.yml` (per-call `chat` fields).
- Hooks: `hook_form_ai_settings_alter` (adds a settings-page notice), `hook_install` (migrates the
  legacy in-core `provider_groq` submodule config).

Peers documented here: `ai_provider_openrouter`, `ai_provider_mistral`, `ai_provider_anthropic`,
`ai_provider_deepl`.

## Operating an AI provider (applies to any)

- The API key is a **spending credential** — set a limit at the provider and monitor it.
- A prompt is a **disclosure**: whatever is sent leaves the site. Treat unpublished content, personal
  data and internal notes accordingly, including where the provider processes them.
- **Pin a model** — availability changes. Groq serves open-weight models, so the same weights can
  usually be run elsewhere if one is withdrawn.
