<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# YandexGPT Provider — install & configuration

## Install & enable

```bash
composer require drupal/ai_provider_yandex
drush en ai_provider_yandex -y
```

`composer.json` requires only `drupal/ai` (`^1.2.1`); the `ai_provider_yandex.info.yml` module deps are
`ai:ai` and `key:key`. No third-party client library is pulled in — the module reuses the AI module's
OpenAI-compatible base client.

## Required settings

Both are needed before the provider is usable:

1. **API key** — a Yandex Cloud API key / service-account credential. Store it as a **Key** entity, then
   select it in the **YandexGPT API Key** `key_select` element on the settings form. Saved to
   `ai_provider_yandex.settings:api_key` (a Key id; resolved to the real token via the AI base class
   `loadApiKey()` at call time).
2. **Catalog identifier** — the Yandex Cloud **folder id**, entered in the **YandexGPT Catalog
   Identifier** textfield. Saved to `ai_provider_yandex.settings:catalog_id`. This is an identifier
   (not a secret) and is combined into the model URI `gpt://<catalog_id>/<model>` at request time.

Form: route `ai_provider_yandex.settings_form` at **`/admin/config/ai/providers/yandex`**, class
`Drupal\ai_provider_yandex\Form\YandexConfigForm`. The field descriptions link to Yandex Cloud's
authentication and folder-id documentation.

## Config object & schema

`config/install/ai_provider_yandex.settings.yml` ships `api_key: ''` and `catalog_id: ''`. Schema
`config/schema/ai_provider_yandex.schema.yml` declares a `config_object` with string `api_key` and
string `catalog_id`.

## Access control

Only route is the settings form, guarded by `_permission: 'administer ai providers'` (owned by `ai`).
No anonymous, mutation or callback routes.

## Model definitions

`definitions/api_defaults.yml` declares the `chat` input/authentication metadata used by the AI
module's form/explorer; the concrete model list is returned by `YandexProvider::getConfiguredModels()`.
