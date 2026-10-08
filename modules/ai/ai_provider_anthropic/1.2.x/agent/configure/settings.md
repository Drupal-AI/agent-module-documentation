# Configure the Anthropic provider

## Settings form — `ai_provider_anthropic.settings_form`

Route path `/admin/config/ai/providers/anthropic` (menu: **Config → AI → AI Providers →
Anthropic Authentication**). Access = permission **`administer ai providers`** (defined by AI
Core, not this module). Form class `Form\AnthropicConfigForm`, config object
`ai_provider_anthropic.settings`.

Fields on the form:

| Field | Type | Notes |
|---|---|---|
| **Anthropic API Key** | `key_select` | A **Key** entity (from the `key` module) holding the real API key (get one at `https://console.anthropic.com/settings/keys`). Only the Key **id** is stored in config — never the raw key. |
| **Enable OpenAI Moderation** | checkbox (`openai_moderation`) | Route each Anthropic prompt through OpenAI moderation first. **Disabled unless** the `ai_provider_openai` provider is enabled/usable **and** the `ai_external_moderation` module is enabled. |
| **No Moderation Needed** | checkbox (`moderation_checkbox`) | Acknowledgement. If OpenAI moderation is off you must tick this to confirm you understand that running Anthropic without moderation risks getting the account banned; **validation fails otherwise**. |

Anthropic has **no native moderation endpoint**. When *Enable OpenAI Moderation* is saved on,
`submitForm()` adds an entry to `ai_external_moderation.settings` `moderations` that runs the
`anthropic` provider's prompts through `openai__text-moderation-latest`; saving it off removes
that entry. On submit the form also calls `setDefaultModels()` → seeds AI Core defaults via
`getSetupData()` (see below). There is **no host / model / version field on the form** — those
are config-only (edit with `drush cset`).

## Config object — `ai_provider_anthropic.settings`

`config/install/ai_provider_anthropic.settings.yml`, schema `config/schema/...schema.yml`:

| Key | Default | Meaning |
|---|---|---|
| `api_key` | `''` | Machine name of the Key entity holding the Anthropic API key. |
| `openai_moderation` | `true` | Whether to run the OpenAI external-moderation check before Anthropic calls (only effective when OpenAI provider + `ai_external_moderation` are enabled). |
| `version` | `'20240229'` | Anthropic API version stored in config. (Note: the live models fetch hard-codes header `anthropic-version: 2023-06-01`.) |
| `models_cache_ttl` | `86400` (schema; unset by default) | Seconds to cache the dynamically fetched models list. Falls back to 86400 (24h) when unset. |
| `host` | *(unset)* | Optional override of the API endpoint (proxy / Anthropic-compatible host). Read in `loadClient()`; empty = `https://api.anthropic.com/v1`. Set with `drush cset ai_provider_anthropic.settings host <host>` — no form field. |

Settings are a config object, so they export/deploy with `drush config:export`.

## Default models seeded on setup (`getSetupData()`)

When the key is saved, these are set as AI Core defaults **only if that operation type has no
provider yet** (`ai.provider` → `defaultIfNone`). Model ids are resolved from the live models
list, falling back to the pinned ids below:

| Operation type | Default model (fallback id) |
|---|---|
| `chat`, `chat_with_image_vision` | Claude Sonnet 4.5 (`claude-sonnet-4-5-20250929`) |
| `chat_with_complex_json`, `chat_with_tools`, `chat_with_structured_response` | Claude Opus 4.5 (`claude-opus-4-5-20251101`) |

`getSetupData()` also reports `key_config_name = 'api_key'`.

## Make Anthropic the site-wide default provider

Choose the provider/model per operation type at AI Core's own settings form
**`ai.settings_form`** → `/admin/config/ai/settings` (stored in `ai.settings`
`default_providers`). The seeding above pre-fills these; change them there or with
`drush cset ai.settings default_providers.chat.provider_id anthropic`.

## Key setup reminder

Create the Key first (module `key`): e.g. `drush key:save anthropic_api_key
--label='Anthropic API Key' --key-type=authentication --key-provider=env
--key-provider-settings='{"env_variable":"ANTHROPIC_API_KEY",...}' --key-input=none -y`, then
select it in the form. An env/file-based Key keeps the secret out of config and version control.
