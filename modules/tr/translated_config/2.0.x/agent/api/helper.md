<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — translated_config.helper

## Service

`translated_config.helper` → `Drupal\translated_config\TranslatedConfigHelper`
(constructor args `@config.factory`, `@language_manager`).

## `getTranslatedConfig(string $configName, ?string $langCode = NULL): TranslatedImmutableConfig`

- Loads base config: `configFactory->get($configName)`.
- Loads override: `languageManager->getLanguageConfigOverride($langCode, $configName)`.
- Merges: `array_replace_recursive($original->get(), $override->get())` — override replaces only the
  keys it defines; every untranslated key from the original is preserved.
- `$langCode` omitted/empty → current interface language
  (`languageManager->getCurrentLanguage()->getId()`).
- Returns a `TranslatedImmutableConfig` carrying cacheability from both config objects.

## `TranslatedImmutableConfig`

- `get(string $key = '')`: empty key → the whole merged array; otherwise splits on `.` and walks the
  array, returning `NULL` if any segment is missing. (Read-only; there is no `set()`.)
- Implements `CacheableDependencyInterface` (via `CacheableDependencyTrait`) — safe to pass to
  `CacheableMetadata::createFromObject()` / add as a render-array cache dependency.

## Example

```php
/** @var \Drupal\translated_config\TranslatedConfigHelper $helper */
$helper = \Drupal::service('translated_config.helper');

// Current language, complete set:
$config = $helper->getTranslatedConfig('system.site');
$name = $config->get('name');          // translated if a translation exists, else original
$slogan = $config->get('page.front');  // dot path

// Explicit language:
$de = $helper->getTranslatedConfig('system.site', 'de');
$all = $de->get();                     // full merged array
```

Use this instead of reading `getLanguageConfigOverride()` directly, which returns only the
translated keys and omits everything untranslated.
