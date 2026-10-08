<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings form, config, caching

## Install & enable

```bash
composer require drupal/ai_provider_bifrost
drush en ai_provider_bifrost -y
```

Requirements (from `composer.json` / `.info.yml`): PHP `>=8.3`, Drupal core `^11 || ^12`,
`drupal/ai ^1.4` (machine name `ai`), `drupal/key ^1.18` (machine name `key`). The OpenAI PHP client
(`OpenAI\Client`) it uses is provided transitively by the AI module. No `.install` file, so nothing
is seeded on install; the provider becomes usable only once configured.

You also need a running Bifrost gateway and a Bifrost virtual key (stored as a Key entity of type
`authentication`).

## Settings form

- Route **`ai_provider_bifrost.settings_form`** → `/admin/config/ai/providers/ai_provider_bifrost`,
  `_permission: 'administer ai providers'`, form `Form\BifrostConfigForm`. Menu link
  `ai_provider_bifrost.settings_menu` under `ai.admin_providers`.
- Editable config: **`ai_provider_bifrost.settings`**.

Fields (`buildForm()`):

| Field | Type | Config key | Notes |
|---|---|---|---|
| Host | textfield | `host` | Base URL incl. `/v1`, e.g. `https://bifrost.example.com/v1`. Required. |
| Bifrost virtual key | `key_select` | `api_key` | Required; filtered to Key entities of type `authentication`. Sent as `x-bf-vk`. |

### Validation (`validateForm()`)

Host checks, in order: non-empty → `FILTER_VALIDATE_URL` → scheme in `['http','https']` → no trailing
slash. Then the key is resolved via `key.repository` (a `getKeyValue()` exception is logged and turned
into a generic error). Finally a **live connectivity check**: a `BifrostAiClient` is built and
`models()` called; an empty result errors "no models were returned"; any `\Throwable` (incl.
`InvalidArgumentException` from Guzzle URI parsing that `filter_var` let through) is logged via
`Error::logException()` and shown as a generic "not working" error — raw detail is never echoed to
the UI.

### Submit (`submitForm()`)

Saves `api_key` + `host`, then `Cache::invalidateTags([BifrostAiProvider::CACHE_TAG])`
(`ai_provider_bifrost:models`) so the cached model list and cached embeddings vector sizes are
cleared when the gateway is repointed.

## Config object & schema

`config/install/ai_provider_bifrost.settings.yml`:

```yaml
api_key: ''
host: ''
```

Schema `config/schema/ai_provider_bifrost.schema.yml` types `ai_provider_bifrost.settings` as a
`config_object` with `api_key` (string, required — a Key entity id) and `host` (string, required).
`api_key` holds the Key entity **id**; the virtual key itself lives in the Key provider and is not in
config exports.

## Model-list caching

`BifrostAiProvider::getModels()` fetches `GET <host>/models` and caches the raw list under
`models:bifrost` for 300 seconds with tag `ai_provider_bifrost:models`. An **empty** list is not
cached (so a gateway whose key access is still propagating is not pinned to "no models" for the TTL).
`embeddingsVectorSize()` caches per-model vector sizes permanently under the same tag. Both are
cleared together on config save (above).

## Parameter definitions

`definitions/api_defaults.yml` declares per-operation configuration schema returned to the AI module:
chat (max_tokens, temperature, top_p, frequency/presence penalty), embeddings (dimensions),
text_to_image (n, size, response_format), text_to_speech (voice, response_format, speed),
speech_to_text (language, prompt, temperature).
