# Manager service, access model, Views filter & hooks

## Service `allowed_languages.allowed_languages_manager`
Class `Drupal\allowed_languages\AllowedLanguagesManager` (implements
`AllowedLanguagesManagerInterface`). Constructor args: `@current_user`, `@entity_type.manager`.

| Method | Returns / behavior |
|---|---|
| `assignedLanguages(?AccountInterface $account = NULL)` | `array` of language ids referenced by the account's `allowed_languages` field (empty if the field is missing). Defaults to the current user. |
| `hasPermissionForLanguage(LanguageInterface $language, ?AccountInterface $account = NULL)` | `bool`. Returns TRUE if the user has `translate all languages`, else whether `$language->getId()` is in the assigned set. **Note:** it always resolves the acting user from `current_user` — the `$account` argument is effectively ignored, so it answers for the current user regardless of what is passed. |
| `isEntityLanguageControlled(EntityInterface $entity)` | `bool`. TRUE for any `ContentEntityInterface` that `isTranslatable()`. |
| `accountFromProxy(?AccountInterface $account = NULL)` | Loads the full `user` entity behind an `AccountProxyInterface`. |

Read the assigned languages of the current user:
```php
$mgr = \Drupal::service('allowed_languages.allowed_languages_manager');
$langs = $mgr->assignedLanguages();          // ['de', 'fr']
$ok = $mgr->hasPermissionForLanguage(\Drupal::languageManager()->getLanguage('de'));
```

## The per-user field
`hook_entity_base_field_info()` adds `allowed_languages` (unlimited `entity_reference` →
`configurable_language`) to the `user` entity. `hook_form_user_form_alter()` renders it as an
"Allowed languages" checkboxes group (plus an "Allow all languages" option) behind
`#access = hasPermission('administer allowed languages')`; a submit handler saves the ticked language
ids (dropping the synthetic `all`).

## What is enforced (and what is not)
- **update / delete of existing content** — `hook_entity_access()` returns `AccessResult::forbidden()`
  when the entity is language-controlled and the acting user lacks permission for the entity's current
  language. It returns *neutral* for `view` and `create`, and neutral on the translation add/overview
  routes (those are handled by the access check below).
- **Translation management** — service `allowed_languages.content_translation_access_check` (class
  `ContentTranslationAccessCheck`, `applies_to: _access_content_translation_manage`) returns
  allowed/forbidden based on the target language, so add/edit/delete translation routes are gated.
- **Translations overview** — `AllowedLanguagesRouteSubscriber` swaps the overview controller to
  `AllowedLanguagesController::overview()`, which removes operation links for disallowed languages.
- **Create forms** — `hook_field_widget_single_element_language_select_form_alter()` adds a
  `#pre_render` (`AllowedLanguagesTrustedCallbacks::languageSelectWidgetPreRender`) that unsets
  disallowed options from the language `<select>`.

## Views filter `allowed_languages`
Plugin `Drupal\allowed_languages\Plugin\views\filter\AllowedLanguages` ("Current users allowed
languages"). `canExpose()` is FALSE (cannot be exposed to end users). Its `query()` adds
`WHERE langcode IN (<current user's assigned languages>)` — but only when the user actually has
assigned languages (an empty set adds no filter, so the view is unfiltered). Registered via
`hook_views_data()` on the data table and revision-data table of every translatable content entity
type. Cache context: `user`.

## Extending
Override enforcement by decorating `allowed_languages.allowed_languages_manager` or adding your own
`hook_entity_access()`. `AllowedLanguagesTrustedCallbacks` is a `TrustedCallbackInterface` exposing
`languageSelectWidgetPreRender`.
