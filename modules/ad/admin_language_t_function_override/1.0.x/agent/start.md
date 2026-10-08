<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Language t() function Override (admin_language_t_function_override) — agent index

Forces interface (`t()`) strings to render in a fixed language — **English by default, or a per-user
choice** — on admin and configured **wildcard paths**, regardless of the URL language prefix, by
**decorating the `string_translation` service**. Content translations are untouched. Depends on core
**`language`**. Core `^10 || ^11`. Package `HCLTech`. License GPL-2.0-or-later. Version 1.0.x.

- **The decorator service, the match/override logic, and the per-user preference** →
  [services/translation-decorator.md](services/translation-decorator.md)
- **The settings form, config object, and default paths** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- One decorator service `admin_lang_t_override.translation_decorator` (`admin_language_t_function_override.services.yml`)
  `decorates: string_translation`, class
  `Drupal\admin_language_t_function_override\Translation\AdminStringTranslationDecorator`
  (extends core `TranslationManager`), args = the inner service + `@service_container`.
- One config form `AdminLanguageSettingsForm` (route `admin_language_t_function_override.settings`,
  path `/admin/config/regional/admin-language-t-function-override`, permission
  **`administer site configuration`**), menu link under *Regional and language*.
- Config object **`admin_language_t_function_override.settings`** (`enabled`, `force_english_paths`),
  install defaults in `config/install/`. **No config schema shipped**, **no permissions**, **no Drush**,
  **no plugins**, **no entities**.
- `.module`: `hook_form_user_form_alter` adds an "Administration Language Preference" select to the
  user edit form; a submit handler stores the choice in **`user.data`** under module name
  `admin_language_t_function_override`, key `user_lang`.

## Mechanism (short)

- `AdminStringTranslationDecorator::translate()`, `translateString()`, `formatPlural()` each call
  `getTargetOverrideLangcode()` and, if it returns a langcode, set `$options['langcode']` before
  delegating to the inner service.
- `getTargetOverrideLangcode()`: if `enabled`, matches the current request path against the configured
  wildcard patterns (regex built from `preg_quote` with `\*` → `[^?]*`), OR treats the route as matched
  when `route->getOption('_admin_route') == TRUE`. On a match it returns the logged-in user's saved
  `user_lang` (if set and not `site_default`), else falls back to `'en'`. Result cached per request.
- `translateString()` uses reflection to rewrite the `options` property of the `TranslatableMarkup`
  so the forced langcode is applied. Output is still produced by core's translation manager (normal
  escaping preserved).
