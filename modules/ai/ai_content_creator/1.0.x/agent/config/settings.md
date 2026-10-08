<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Creator — settings

## Install & enable

```bash
composer require drupal/ai_content_creator
drush en ai_content_creator -y
```

No module dependencies (only core). No sub-modules, no permissions of its own, no Drush commands.

## Settings form

Route `ai_content_creator.admin_settings` → `Form\AiContentCreatorConfigForm`, path
**`/admin/config/ai_content_creator`**, permission **`administer site configuration`** (menu link
*AI Content Creator API Settings* under *Configuration → Development*). It is a `ConfigFormBase` editing the single
config object **`ai_content_creator.adminsettings`**.

| Field (form key = config key) | Type | Default | Notes |
|---|---|---|---|
| `api_url` | textfield | `https://api.openai.com/v1/completions` | OpenAI endpoint. Required. For chat models the service rewrites `/completions` → `/chat/completions` (see api/generation.md). |
| `api_key` | textfield | *(empty)* | OpenAI access token (`sk-...`). Required, maxlength 255. Stored in plain config. |
| `api_model` | select | `gpt-3.5-turbo` | One of `gpt-3.5-turbo`, `gpt-4`, `gpt-4-turbo-preview`, `text-davinci-003`. |
| `api_max_token` | number | `2000` | Max tokens, validated to 1–4000. |
| `api_temperature` | number (step 0.1) | `0.7` | Validated to 0–1. |
| `api_node_type` | checkboxes | `[]` | Node bundles that show the generator panel (built from `node_type` entities). |

`validateForm()` rejects an `api_key` shorter than 20 chars, a `max_tokens` outside 1–4000, and a `temperature`
outside 0–1. `submitForm()` writes all six keys back to `ai_content_creator.adminsettings`.

### Config object shape

```yaml
# ai_content_creator.adminsettings
api_url: 'https://api.openai.com/v1/completions'
api_key: 'sk-...'
api_model: 'gpt-3.5-turbo'
api_max_token: 2000
api_temperature: 0.7
api_node_type:
  article: article
  page: '0'   # unchecked bundles are stored as '0'
```

There is **no `config/schema`** for this object, so strict config-schema tooling may flag it; the values still save
and load. The token lives in exportable configuration (not a Key entity or environment variable), so treat exported
config and database dumps accordingly.

## How the panel is switched on

`hook_form_alter` reads `ai_content_creator.adminsettings:api_node_type` and only adds the panel when
`in_array($node->bundle(), $types_enabled)` is true. So enabling a content type here is what makes the
"AI Content Generator" details element appear on that bundle's node form. See
[api/generation.md](../api/generation.md) for the runtime flow.
