<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & translation provider

This module ships **no configuration of its own** — no `config/install`, no `config/schema`. Its
`configure` route (`auto_node_translate.settings`) and every setting it reads belong to the parent
`auto_node_translate` module.

## Install / enable

```
composer require drupal/auto_term_translate   # pulls drupal/auto_node_translate:^3.0
drush en auto_term_translate -y               # enables content_translation + auto_node_translate too
```

Requires `content_translation` and `auto_node_translate` (declared in
`auto_term_translate.info.yml`). The vocabulary/term bundles you want to translate must be
content-translation enabled.

## Where settings live

Config is owned by the parent module:

- `auto_node_translate.settings` — read in `TranslationForm::validateForm()` and
  `autoTaxonomyTranslateTerm()` via `$this->config->get('auto_node_translate.settings')`. The key
  that matters here is **`default_api`** — the id of the active
  `auto_node_translate_provider` plugin. If it is empty, both the per-term and bulk forms fail
  validation with "Error, translation API is not configured!".
- Provider-specific config such as `auto_node_translate.my_memory_settings` (e.g. the optional
  `mm_email`) is also owned and consumed by the parent, not by this module.

Settings UI: the parent's `SettingsForm` at route `auto_node_translate.settings`
(`/admin/config/regional/auto-node-translate-settings` in v2), where the `default_api` provider is
chosen. Manage it with the parent's restrict-access permission `configure auto node translate`.

## Provider selection at runtime

`autoTaxonomyTranslateTerm()` instantiates the provider by id:

```php
$default_api_id = $config->get('default_api');
$api = $this->pluginManager->createInstance($default_api_id); // plugin.manager.auto_node_translate_provider
```

Providers are `@AutoNodeTranslateProvider` plugins defined by `auto_node_translate` (the shipped one
is MyMemory, `auto_node_translate_mymemory`). This module contributes **no** provider plugins — to
add DeepL/Google/etc., add a provider plugin in the parent module's plugin namespace and select it
as `default_api`; the term forms pick it up automatically.

## What this module contributes

- Permission: `use bulk auto translate` (restrict-access).
- Access check service `auto_term_translate.manage_access` (`_access_auto_term_translation`).
- Route subscriber service `auto_term_translate.subscriber`.
- Local-task deriver `Plugin\Derivative\AutoTermTranslateLocalTasks`.

See [routes/translate-forms.md](../routes/translate-forms.md) for how these fit together.
