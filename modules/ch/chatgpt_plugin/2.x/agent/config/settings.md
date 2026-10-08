<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, routes & permissions

## Install / enable

`drush en chatgpt_plugin -y`. No composer requirements (`composer.json` `require: {}`), no
`config/install`, no update hooks. To use the translate feature enable core
`content_translation` and make a content type translatable. After enabling, set the OpenAI
credentials at **`/admin/config/chatgpt`** (link "OpenAI API Settings" under
*Configuration → Development*, `chatgpt_plugin.links.menu.yml`).

## Config object: `chatgpt_plugin.adminsettings`

Written/read by `ChatGPTConfigForm` (`src/Form/ChatGPTConfigForm.php`,
`getEditableConfigNames()`). **No config schema ships** (`provides_config_schema = false`),
so keys are untyped. Keys and their form widgets:

| Key | Form `#type` | Default in form | Notes |
|-----|--------------|-----------------|-------|
| `gpt_model_version` | `select` (required) | — | `chatgpt` / `gpt4` / `gpt4-mini` — a display label only; not sent to the API. |
| `completion_endpoint` | `textfield` | `https://api.openai.com/v1/chat/completions` | Chat-completions URL used by `GPTApiService`. |
| `model_name` | `textfield` | — | Actual model string sent as `model` (e.g. `gpt-4o-mini`). |
| `dalle_endpoint` | `textfield` (required) | `https://api.openai.com/v1/images/generations` | Used by `DallEApiService`. |
| `moderation_endpoint` | `textfield` (required) | `https://api.openai.com/v1/moderations` | Post-generation moderation check. |
| `access_token` | `textfield` (required) | — | OpenAI Bearer token. Stored in this config object. |
| `chatgpt_max_token` | `textfield` (required) | — | Cast to int → `max_tokens`. |
| `chatgpt_temperature` | `textfield` | `0` | Cast to int → `temperature`. |
| `content_types` | `checkboxes` (required) | — | Node bundles where the generator link appears. |

`validateForm()` is empty — no validation. `submitForm()` saves each value verbatim. The
model actually sent to OpenAI is `model_name` (not the `gpt_model_version` label).

## Routes (`chatgpt_plugin.routing.yml`)

| Route | Path | Handler | Requirement |
|-------|------|---------|-------------|
| `chatgpt_plugin.search_form` | `/chatgpt/search_form/{fieldName}` | `ChatGPTForm` | `_permission: 'access chatgpt search form'` |
| `chatgpt_plugin.admin_settings` | `/admin/config/chatgpt` | `ChatGPTConfigForm` | `_permission: 'configure chatpgpt plugin'` |
| `chatgpt_plugin.translate_content` | `/chatgpt/translate/{lang_code}/{lang_name}/{node_id}` | `ChatGPTTranslateController::translate` | `_permission: 'access chatgpt translation'` |
| `chatgpt_plugin.chatgpt_assist_tool` | `/admin/config/chatgpt_assist_tool` | `ChatGPTAssistToolForm` | `_permission: 'access chatgpt search form'` |

`configure` in `info.yml` → `chatgpt_plugin.admin_settings`. A menu task under
`system.admin_content` (`chatgpt_plugin.links.task.yml`) surfaces the assist tool as a tab on
`admin/content` (route path is actually `/admin/config/chatgpt_assist_tool`).

## Permissions (`chatgpt_plugin.permissions.yml`)

- `access chatgpt search form` — "Access ChatGPT search form". Gates the generator modal, the
  the node-form link added via `form_alter`, and the assist tool.
- `access chatgpt translation` — "Access ChatGPT Translation". Gates the translate controller.
- `configure chatpgpt plugin` — "Administer ChatGPT plugin configuration" (machine name typo
  is upstream). Gates the settings form.

## Config-export example

```yaml
# config export: chatgpt_plugin.adminsettings.yml
gpt_model_version: gpt4-mini
completion_endpoint: 'https://api.openai.com/v1/chat/completions'
model_name: gpt-4o-mini
dalle_endpoint: 'https://api.openai.com/v1/images/generations'
moderation_endpoint: 'https://api.openai.com/v1/moderations'
access_token: 'sk-...'      # OpenAI Bearer token
chatgpt_max_token: '1000'
chatgpt_temperature: '0'
content_types:
  article: article
```
