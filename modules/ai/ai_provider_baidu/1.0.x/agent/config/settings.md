<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings form & config

## Install & enable

```bash
composer require drupal/ai_provider_baidu
drush en ai_provider_baidu -y
```

Dependencies (from `.info.yml`): `ai:ai (>=1.0-beta)` and `key:key`. Core `^10 || ^11`. The
`composer.json` declares no `require` block, so there are no extra Composer libraries. There is no
`.install` file, no `config/install`, and no `config/schema`.

Get a Baidu API key at `https://console.bce.baidu.com/qianfan/ais/console/apiKey`, store it as a Key
entity at `/admin/config/system/keys/add`, then select it on the provider settings form.

## Settings form

- Route **`ai_provider_baidu.settings`** → `/admin/config/ai/providers/baidu`,
  `_permission: 'administer ai providers'`, form `Form\SettingsForm` (extends `ConfigFormBase`,
  injects `key.repository`). Menu link `ai_provider_baidu.settings` under `ai.admin_providers`
  (weight 10).
- Editable config: **`ai_provider_baidu.settings`**.

Fields (`buildForm()`):

| Field | Type | Config key | Notes |
|---|---|---|---|
| API Key | `key_select` | `api_key` | Required; a Key entity id holding the Baidu API key. |

`submitForm()` saves `api_key` and also `model` (`$form_state->getValue('model')`) — but no `model`
form element is built, so `model` is stored empty and unused. There is no `validateForm()` and no live
connection test.

## Config object

No `config/install/ai_provider_baidu.settings.yml` ships; the object is created on first save with
just `api_key` (and the empty `model`). Because no `config/schema` exists, the object is schema-less —
strict config-schema tooling (and config inspection) may warn, but the value saves and works. The
stored `api_key` is a Key entity **id**; the secret lives in the Key provider and is not exported.

## Runtime

`BaiduProvider::isUsable()` returns FALSE until `ai_provider_baidu.settings.api_key` is set.
`loadApiKey()` resolves the Key value via `keyRepository->getKey(...)->getKeyValue()` and hands it to
the client (`setApiToken`). See [../plugins/provider.md](../plugins/provider.md) for the request path.
