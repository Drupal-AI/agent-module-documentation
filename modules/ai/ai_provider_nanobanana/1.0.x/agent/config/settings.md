<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NanoBanana Provider — install & configuration

## Install & enable

```bash
composer require drupal/ai_provider_nanobanana
drush en ai key ai_provider_nanobanana -y
drush cr
```

`composer.json` requires `drupal/core` (`^10 || ^11`) and `drupal/ai` (`^1.0`); module deps in
`ai_provider_nanobanana.info.yml` are `ai:ai` and `key:key`.

## Store the Gemini API key

1. Get a Google Gemini API key at `https://aistudio.google.com/apikey`.
2. Create a **Key** entity (Configuration → System → Keys) holding it.
3. Go to **`/admin/config/ai/providers/nanobanana`** (route `ai_provider_nanobanana.settings`, form
   `Drupal\ai_provider_nanobanana\Form\NanoBananaConfigForm`) and pick the Key in the **Google Gemini
   API Key** `key_select` element. `submitForm()` saves the key id to
   `ai_provider_nanobanana.settings:api_key`.

The `NanoBanana` client resolves the real token in its constructor:
`$keyRepository->getKey($config->get('api_key'))->getKeyValue()`.

## Config object & schema

`config/install/ai_provider_nanobanana.settings.yml` ships `api_key: ''`. Schema
`config/schema/ai_provider_nanobanana.schema.yml` declares a `mapping` with one string `api_key`.

## Verify

Open **AI API Explorer → Image-To-Image Explorer**
(`/admin/config/ai/explorers/image_to_image_generator`), choose provider **NanoBanana**, and confirm
the two Gemini models appear in the model dropdown.

## Options (per operation)

From `definitions/api_defaults.yml`, both `text_to_image` and `image_to_image` expose:

- **aspectRatio** — one of `1:1, 2:3, 3:2, 3:4, 4:3, 4:5, 5:4, 9:16, 16:9, 21:9` (default `1:1`).
- **imageSize** — `'' , 1K, 2K, 4K` — **Gemini 3 Pro only**. `NanoBananaProvider::getModelSettings()`
  strips `imageSize` for `gemini-2.5-flash-image`.

## Access control

The only route is the settings form, guarded by `_permission: 'administer ai providers'` (owned by the
`ai` module). Image generation itself is reached through the AI module's own explorer routes / provider
API — this module adds no anonymous, mutation or callback routes.
