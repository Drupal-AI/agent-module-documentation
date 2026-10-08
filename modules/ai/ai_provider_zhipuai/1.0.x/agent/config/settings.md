<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Zhipuai provider

## Install & enable

```bash
composer require drupal/ai_provider_zhipuai
drush en ai_provider_zhipuai -y   # pulls in ai + key
```

Requires `drupal/ai` (>=1.0-beta) and the `key` module.

## 1. Store the API key as a Key entity

Get a key from `https://bigmodel.cn/usercenter/proj-mgmt/apikeys`, then at
`/admin/config/system/keys/add` create a Key holding it (an env- or file-backed provider
keeps it out of exported config).

## 2. Select the key on the provider settings form

Route `ai_provider_zhipuai.settings` → `/admin/config/ai/providers/zhipuai`, class
`Form\SettingsForm` (extends `ConfigFormBase`, injects `key.repository`). Permission:
**`administer ai providers`**. Menu link: *Configuration → AI → Providers → Zhipuai*.

Fields:

| Field | Type | Notes |
|---|---|---|
| **API Key** | `key_select` | Choose the Key entity holding your Zhipuai API key. Required. |

There is also a collapsible **Help** section linking to Zhipu's API docs.

`submitForm()` saves the selected key id into config `ai_provider_zhipuai.settings`
under `api_key` (it also writes `model` from the form, but no `model` element is defined,
so that stays empty).

## Config object

```yaml
# ai_provider_zhipuai.settings
api_key: my_zhipuai_key   # the Key entity id, NOT the secret itself
```

The module ships no `config/schema`; the stored value is the Key id, and the secret is
resolved at call time via the Key repository.

## 3. Use it

Once a key is selected, the `zhipuai` provider (chat operation) is selectable anywhere the
AI module offers a provider — e.g. AI default provider settings, assistants, or custom
code calling the AI chat API. Models available: `glm-4.5`, `glm-4.5-air`, `glm-4.5-x`,
`glm-4.5-airx`, `glm-4.5-flash`.
