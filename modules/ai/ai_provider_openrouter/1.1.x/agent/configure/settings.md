<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the OpenRouter provider

## Settings form — `ai_provider_openrouter.settings`

Route path `/admin/config/ai/providers/openrouter/settings` (menu: **Config → AI → AI Providers →
OpenRouter**). Access = permission **`administer ai providers`** (defined by this module in
`ai_provider_openrouter.permissions.yml`, `restrict access: true`). Form class
`Form\OpenRouterConfigForm` (extends `ConfigFormBase`), config object
`ai_provider_openrouter.settings`. The form also declares `ai.settings` editable so it can set the
site default provider.

Fields:

| Field | Type | Notes |
|---|---|---|
| **OpenRouter API key** | `key_select` (`#key_filters: {type: authentication}`) | Selects a **Key** entity holding the real OpenRouter key (get one at `https://openrouter.ai/keys`). Only the Key **machine name** is stored in `api_key` — never the raw secret. Required. |
| **OpenRouter API Base URL** | textfield | Defaults to `https://openrouter.ai/api/v1`. "Only change this if you are using a custom endpoint." Required. Admin-only. |
| **Enable streaming** | checkbox (`streaming`) | Default for streamed responses; callers can override. |
| **Set as default provider** | checkbox (`default_provider`) | On submit, when ticked, writes `ai.settings` `default_provider = 'openrouter'`. |
| **Model Selection** (per-provider `details` fieldsets) | checkboxes | Whitelist of models to expose. Chat/image and embedding models are listed separately, grouped by upstream provider, each showing context length and prompt/completion pricing. Checked ids are saved to `enabled_models`. |

The model list is fetched **live** from OpenRouter (`OpenRouterClient::listModels()`) each time the
form is built; if the API is unreachable the form falls back to a small static model list. Image-
generation-capable models are flagged with 🖼️.

## Config object — `ai_provider_openrouter.settings`

Schema `config/schema/ai_provider_openrouter.schema.yml`:

| Key | Type | Meaning |
|---|---|---|
| `api_key` | string | Machine name of the Key entity holding the OpenRouter API key. |
| `base_url` | string | API base URL; empty falls back to `https://openrouter.ai/api/v1`. |
| `enabled_models` | sequence[string] | Whitelisted model ids. Empty = expose **all** models. |
| `streaming` | boolean | Default streaming on/off. |
| `default_provider` | boolean | Whether OpenRouter was chosen as the site default. |

Settings are a config object, so they export/deploy with `drush config:export`. Note the API key
itself is **not** in this config — it lives in a Key entity, so no secret is exported.

## Model whitelist behaviour

`getConfiguredModels()` (in the provider plugin) reads `enabled_models`, filters by operation type
(embedding-only models excluded from chat/image and vice-versa), and — if the whitelist is empty —
returns every model. So leaving the whitelist blank exposes all 300+ models; add ids to narrow it.

## Make OpenRouter the site default

Either tick **Set as default provider** on this form (writes `ai.settings default_provider`), or
choose provider/model per operation type at AI Core's own `ai.settings` form under
`/admin/config/ai`.

## Key setup reminder

Create the Key first (module `key`), e.g. with an env-based provider so the secret stays out of
config and version control:

```bash
ddev drush key:save openrouter_api_key --label='OpenRouter API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"OPENROUTER_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Then select it in the OpenRouter settings form.
