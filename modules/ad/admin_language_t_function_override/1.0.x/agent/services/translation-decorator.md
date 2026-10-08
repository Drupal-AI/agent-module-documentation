<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Translation decorator + per-user preference

`src/Translation/AdminStringTranslationDecorator.php`, registered in
`admin_language_t_function_override.services.yml`.

## Service registration

```yaml
services:
  admin_lang_t_override.translation_decorator:
    class: Drupal\admin_language_t_function_override\Translation\AdminStringTranslationDecorator
    decorates: string_translation
    arguments:
      - '@admin_lang_t_override.translation_decorator.inner'
      - '@service_container'
```

It **decorates `string_translation`**, so every call to `t()`, `\Drupal::translation()`,
`TranslatableMarkup`, and `formatPlural()` flows through it. The class `extends TranslationManager`
(only to satisfy the core type hints); it calls `parent::__construct()` with a dummy `LanguageDefault`
of `en` and stores the real inner service (`$inner`) plus the container (for lazy service lookups that
avoid a container-compile loop).

## Override decision — `getTargetOverrideLangcode(): ?string`

Returns the langcode to force, or `NULL` for "no override". Steps:

1. Per-request static cache (`$overrideLangcodeCache`; `FALSE` means "computed: no override").
2. If `config.factory` is not yet available (early bootstrap) → `NULL`.
3. Load config `admin_language_t_function_override.settings`; if `enabled` is falsey → `NULL`.
4. Get the current request from `request_stack`; if none → `NULL`.
5. **Path match:** for each pattern in `force_english_paths`, build
   `'#^' . str_replace('\*', '[^?]*', preg_quote($pattern, '#')) . '($|\?)#'` and `preg_match` it
   against `$request->getPathInfo()`. First hit sets matched.
6. **Fallback match:** if no path matched, get `current_route_match`; if the route option
   `_admin_route == TRUE`, treat as matched.
7. On a match, if the current user is authenticated, read `user.data` (module
   `admin_language_t_function_override`, key `user_lang`) — if it is set and not `site_default`, return
   that langcode. Otherwise return `'en'`.
8. No match → `NULL`.

## Applying the override

- `translate($string, $args, $options)` and `formatPlural($count, $singular, $plural, $args, $options)`:
  if a target langcode is returned, set `$options['langcode']` then delegate to `$this->inner`.
- `translateString(TranslatableMarkup $translated_string)`: reflection is used to overwrite the
  markup object's protected `options` array with `langcode` set, then delegates to `$this->inner`.
  The actual string lookup/escaping is core's — this module only steers **which** langcode is used.

## Per-user preference (`.module`)

- `admin_language_t_function_override_form_user_form_alter()` adds a details group
  `admin_language_preference` with a select `admin_langcode` (options = `site_default` + every
  configurable language). Default value is read from `user.data` key `user_lang`.
- `admin_language_t_function_override_user_form_submit()` writes the chosen `admin_langcode` back to
  `user.data` (`->set('admin_language_t_function_override', $uid, 'user_lang', $value)`).
- The stored preference is what `getTargetOverrideLangcode()` reads in step 7 — so a user who picks
  "German" sees matched admin pages in German; one who leaves "site default" sees them in English.

## Operating notes

- Enable the module and core `language`; visit the settings form to toggle `enabled` and edit paths.
- Clear caches after changing the service wiring. The override is **request-scoped and read-only**;
  it changes only interface-string langcode selection, never content field data.
