<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 DeepL (ckeditor5_deepl) — agent index

A CKEditor 5 plugin that machine-translates the **selected text** via the **DeepL API**. The
editor posts the selection to a Drupal route; the server loads the DeepL key from a **Key** entity
and calls `deeplcom/deepl-php` — the key never reaches the browser. Package `CKEditor 5`. Core
`^10 || ^11`. License GPL-2.0-or-later. Installed as **1.x-dev** (no stable release; version dir `1.x`).

## Dependencies

- Drupal modules: **`ckeditor5`**, **`key`** (both required, from `.info.yml`).
- PHP library: **`deeplcom/deepl-php` `^1.7`** and **`drupal/key` `^1.17`** (`composer.json`).

## What it provides (from source)

- **CKEditor 5 plugin** `ckeditor5_deepl_integration` (`ckeditor5_deepl.ckeditor5.yml`), PHP class
  `Plugin/CKEditor5Plugin/DeeplIntegration` — per-text-format config (key, languages, formality,
  tag handling, split sentences, preserve formatting). JS source under
  `js/ckeditor5_plugins/deeplIntegration/`, built into `js/build/deeplIntegration.js`.
- **Key type** `deepl_api_key` (`Plugin/KeyType/DeeplKeyType`, group `authentication`) — validates
  the key against DeepL on save.
- **Translate route** `ckeditor5_deepl.translate` → `POST /api/ckeditor-deepl/translate`,
  `Controller/TranslationEndpointController` (`__invoke`), guarded by the custom
  `_translate_access` checker `Access/TranslationEndpointAccessChecker`.
- **Block** `ckeditor5_deepl_deepl_translation` (`Plugin/Block/DeeplTranslationBlock`) rendering
  `Form/DeeplTranslationForm` — a standalone AJAX translate form.
- **Usage route** `ckeditor5_deepl.usage` → `/admin/config/system/settings/ckeditor5-deepl/usage-statistics`
  (`Controller/UsageStatisticsController`), and menu-page route `ckeditor5_deepl.ui`.
- **Services**: `ckeditor5_deepl.translator` (`DeeplTranslator`), `ckeditor5_deepl.helper`
  (`DeeplHelper`), `ckeditor5_deepl.keys` (`DeeplKeys`), `ckeditor5_deepl.config`.
- **Permissions** (`.permissions.yml`): `administer deepl integration`, `access deepl usage`,
  `access deepl translate`. **Config schema** for the plugin + block settings. No install/update
  hooks; one hook: `hook_editor_js_settings_alter` (injects supported formalities).

## Solution docs

- **CKEditor plugin config, key type, config schema** → [config/settings.md](config/settings.md)
- **Translate endpoint, access checker, translator service, JS request flow** →
  [api/translate-endpoint.md](api/translate-endpoint.md)
- **Translation block, form, usage-statistics page, admin routes** →
  [blocks/translation-block.md](blocks/translation-block.md)
