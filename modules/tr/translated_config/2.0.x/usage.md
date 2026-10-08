<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Translated Config is a tiny developer helper that returns a single, complete configuration array for a given language, merging the original config with its language override so every key resolves — translated where a translation exists, original otherwise.

---

The module exposes one service, `translated_config.helper` (`TranslatedConfigHelper`), with `getTranslatedConfig($configName, $langCode = NULL)`. It loads the base config via the config factory and the per-language override via `LanguageManager::getLanguageConfigOverride()`, then combines them with `array_replace_recursive($original, $override)` so the override only replaces keys it actually defines and nothing is lost. When `$langCode` is omitted it uses the current interface language. The result is wrapped in a `TranslatedImmutableConfig` value object whose `get($key)` reads dot-separated paths (e.g. `foo.bar.baz`) and returns the whole merged array when called with no key; it also carries cacheability metadata (`CacheableDependencyInterface`) aggregated from both the original and override config so it can be attached to render arrays. There are no routes, forms, permissions, config, hooks, or Drush commands — it is purely an API used from custom code that needs a fully-populated config set in one language without manually walking overrides. This solves the common pitfall where reading a language override alone yields only the translated keys, missing everything untranslated.

---

- Get a config array in a specific language with all untranslated keys still present.
- Read the current-language version of a config object in one call from custom code.
- Merge a base config with its language override without losing untranslated keys.
- Fetch a dot-path value (`get('foo.bar')`) from the merged translated config.
- Retrieve the entire merged config array by calling `get()` with no argument.
- Attach correct cache metadata (both original + override) to a render array using the result.
- Avoid the bug where `getLanguageConfigOverride()` alone returns only translated keys.
- Resolve a label/setting in the visitor's language while falling back to the source value.
- Build a language-aware settings reader for a custom module.
- Render email/notification templates stored in config in the recipient's language.
- Populate a form default value from translated config with a safe original fallback.
- Feed a fully-populated per-language config set into a normalizer or API response.
- Look up a translated third-party/settings value inside a controller or service.
- Provide translated config values to a Twig template with proper cache dependencies.
- Centralise "give me this config in language X, complete" logic instead of repeating merges.
