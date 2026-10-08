<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Translated Config (translated_config) — agent index

One helper service that returns a config array fully merged with its language override for a chosen
language (translated keys win, untranslated keys retained). Pure API — no routes, forms, permissions,
config, hooks, or Drush.

- **The `translated_config.helper` service, `getTranslatedConfig()`, and `TranslatedImmutableConfig`
  usage** → [api/helper.md](api/helper.md)

Key facts:
- Service id `translated_config.helper` = `Drupal\translated_config\TranslatedConfigHelper`
  (args: `@config.factory`, `@language_manager`).
- `getTranslatedConfig($configName, $langCode = NULL)` → `TranslatedImmutableConfig`;
  merge is `array_replace_recursive(original, languageOverride)`; default langcode = current language.
- `TranslatedImmutableConfig::get($key = '')` reads dot paths, returns full array when key empty, and
  implements `CacheableDependencyInterface`.
