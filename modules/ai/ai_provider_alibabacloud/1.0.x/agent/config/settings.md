<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings form, config object, install

## Install & enable

```bash
composer require drupal/ai_provider_alibabacloud
drush en ai_provider_alibabacloud -y
```

Dependencies (from `ai_provider_alibabacloud.info.yml` / `composer.json`): the AI module
(`drupal/ai ^1.1.0`, machine name `ai`) and the Key module (`drupal/key ^1.18`, machine name
`key`). Core `^10.3 || ^11`.

`hook_install()` (`ai_provider_alibabacloud.install`) seeds default models through
`\Drupal::service('ai.provider')->defaultIfNone(...)`: chat `qwen-plus`, chat_with_tools
`qwen-max`, chat_with_structured_response `qwen-max`, embeddings `text-embedding-v3`.

## Settings form

- Route **`ai_provider_alibabacloud.settings_form`** → `/admin/config/ai/providers/alibabacloud`,
  `_permission: 'administer ai providers'` (defined by the AI module), form
  `Form\AlibabaCloudConfigForm`. Menu link `ai_provider_alibabacloud.settings_menu` under
  `ai.admin_providers`.
- Editable config: **`ai_provider_alibabacloud.settings`** (`getEditableConfigNames()`).

Fields (`buildForm()`):

| Field | Type | Config key | Notes |
|---|---|---|---|
| Alibaba Cloud Model Studio API Key | `key_select` | `key_id` | Required; a Key entity id. |
| Region | select | `region` | `intl` (Singapore) or `cn` (Beijing). Default `intl`. |
| API Mode | select | `api_mode` | `compatible` (OpenAI) or `native` (DashScope). Default `compatible`. |
| Enable streaming responses | checkbox | `enable_streaming` | SSE for chat. |
| Include usage info in streaming | checkbox | `include_usage_in_stream` | Compatible mode only; visible when streaming + compatible. |
| Request timeout | number | `timeout` | Seconds, min 10 max 300, default 60. Required. |

### Validation & submit

`validateForm()` requires `key_id`, loads the Key via `key.repository`, errors if the key is
missing or its value is empty, then calls `AlibabaCloudHelper::testConnection($api_key, $mode,
$region)` — a live `POST` (a 10-token `qwen-turbo` probe) to the selected endpoint; a failure sets a
form error so a bad key/region/mode cannot be saved. `submitForm()` writes the six values and calls
`setDefaultModels()` → `AiProviderPluginManager::defaultIfNone()` from the plugin's `getSetupData()`.

## Config object & schema

`config/install/ai_provider_alibabacloud.settings.yml`:

```yaml
key_id: ''
api_mode: 'compatible'
region: 'intl'
enable_streaming: false
timeout: 60
include_usage_in_stream: false
```

Schema `config/schema/ai_provider_alibabacloud.schema.yml` types
`ai_provider_alibabacloud.settings` as a `config_object` with `key_id`/`api_mode`/`region` (string),
`enable_streaming`/`include_usage_in_stream` (boolean), `timeout` (integer). The stored `key_id` is
a reference to a Key entity — the secret itself lives in the Key provider, not this config, so it is
absent from config exports.

## Runtime requirements check

`hook_requirements($phase === 'runtime')` reports the provider as *Configured* / *Not configured*
(warning when `key_id` empty), *Invalid key* (error — the Key entity no longer exists), or *Empty
key* (error — the Key has no value), linking to the settings form.

## Endpoints (not configurable)

`AlibabaCloudHelper::getBaseUrl($mode, $region)` returns a fixed HTTPS base URL — there is no
admin-overridable host field. Values:

- compatible / intl → `https://dashscope-intl.aliyuncs.com/compatible-mode/v1`
- compatible / cn → `https://dashscope.aliyuncs.com/compatible-mode/v1`
- native / intl → `https://dashscope-intl.aliyuncs.com/api/v1`
- native / cn → `https://dashscope.aliyuncs.com/api/v1`
