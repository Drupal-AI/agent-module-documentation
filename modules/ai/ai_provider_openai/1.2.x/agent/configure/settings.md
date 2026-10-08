# Configure the OpenAI provider

## Settings form — `ai_provider_openai.settings_form`

Route path `/admin/config/ai/providers/openai` (menu: **Config → AI → AI Providers → OpenAI
Authentication**). Access = permission **`administer ai providers`** (defined by AI Core, not
this module). Form class `Form\OpenAiConfigForm`, config object `ai_provider_openai.settings`.

The form has one required field plus an advanced note:

| Field | Type | Notes |
|---|---|---|
| **OpenAI API Key** | `key_select` | A **Key** entity (from the `key` module) that holds the real API key. Required. Only the Key **id** is stored in config — never the raw key. |
| Moderation (advanced) | markup note | Moderation is **always on by default** for any text-based call; disable it per-request in code or by editing the `moderation` value in config. |

On **validate**, the form resolves the selected Key's value and instantiates the `openai`
provider to call `getConfiguredModels()` — a live connectivity/credit check against OpenAI.
On **submit** it calls `OpenAiHelper::testRateLimit()` (warns if the key is free-tier / out of
quota) and then seeds AI Core's default provider→model map via `defaultIfNone()` (see below).

## Config object — `ai_provider_openai.settings`

`config/install/ai_provider_openai.settings.yml`, schema `config/schema/...schema.yml`:

| Key | Default | Meaning |
|---|---|---|
| `api_key` | `''` | Machine name of the Key entity holding the OpenAI API key. |
| `moderation` | `true` | Run an `omni-moderation-latest` check before each text call; throws `AiUnsafePromptException` if the prompt is flagged. |
| `host` | `''` | Override the API host for **OpenAI-compatible or Azure** endpoints (e.g. `my-azure.openai.azure.com/...` or a LocalAI host). Empty = `api.openai.com/v1`. Set it via `drush cset ai_provider_openai.settings host <host>` — the form has no host field. |

The settings are a config object, so they export/deploy with `drush config:export`.

## Default models seeded on setup (`getSetupData()`)

When the key is saved (or on `postSetup`), these are set as AI Core defaults **only if that
operation type has no provider yet** (`ai.provider` → `defaultIfNone`):

| Operation type | Default model |
|---|---|
| `chat`, `chat_with_image_vision`, `chat_with_complex_json`, `chat_with_tools`, `chat_with_structured_response` | `gpt-5.2` |
| `text_to_image` | `gpt-image-1` |
| `embeddings` | `text-embedding-3-small` |
| `moderation` | `omni-moderation-latest` |
| `text_to_speech` | `tts-1-hd` |
| `speech_to_text` | `whisper-1` |

## Make OpenAI the site-wide default provider

Choose the provider/model per operation type at AI Core's own settings form
**`ai.settings_form`** → `/admin/config/ai/settings` (stored in `ai.settings`
`default_providers`). The seeding above pre-fills these; change them there or with
`drush cset ai.settings default_providers.chat.provider_id openai`.

## Key setup reminder

Create the Key first (module `key`): e.g. `drush key:save openai_api_key --label='OpenAI API
Key' --key-type=authentication --key-provider=env ...`, then select it in the form. A
file/env-based Key keeps the secret out of config and out of version control.
