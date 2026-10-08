<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# X AI Provider — install & configuration

## Install & enable

```bash
composer require drupal/ai_provider_x
drush en ai_provider_x -y
```

Composer pulls `drupal/ai` (`^1.0.4`), `drupal/key` (`^1.18`) and `openai-php/client` (`>=v0.10.1`).
The module declares module deps `ai:ai` and `key:key` in `ai_provider_x.info.yml`.

## Store the API key

1. Create your xAI API key at the X/xAI console.
2. Create a **Key** entity (Configuration → System → Keys) holding that value — an environment or
   file provider keeps it out of exported config.
3. Go to **`/admin/config/ai/providers/x`** (route `ai_provider_x.settings_form`, form
   `Drupal\ai_provider_x\Form\XConfigForm`) and pick the Key in the **X Ai API Key** `key_select`
   element.

`XConfigForm::submitForm()` writes the chosen key id to config `ai_provider_x.settings:api_key`, then
calls `AiProviderPluginManager::defaultIfNone()` twice so — if nothing is set yet — `x`/`grok-2-latest`
becomes the default `chat` provider and `x`/`grok-2-vision-1212` the default `chat_with_image_vision`
provider.

## Config object & schema

`config/install/ai_provider_x.settings.yml` ships `api_key: ''`. Schema
`config/schema/ai_provider_x.schema.yml` types it as a `config_object` with one required string
`api_key` (label "API Key"). The stored value is a **Key id**, not the secret itself — the plugin
resolves the real token through the AI base class `loadApiKey()` (Key repository) at call time.

## Access control

The only route is the settings form, guarded by `_permission: 'administer ai providers'` (a permission
owned by the `ai` module). There are no anonymous, mutation or callback routes in this module.

## Menu

`ai_provider_x.links.menu.yml` adds "X Ai Configuration" under the AI providers admin menu
(`parent: ai.admin_providers`).
