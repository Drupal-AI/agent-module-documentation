# Hooks implemented

The module is entirely hook-driven; both hooks live in `entity_translations_helper.module`.

## `hook_form_alter()`

`entity_translations_helper_form_alter(&$form, FormStateInterface $form_state, string $form_id)` runs on
**every** form and dispatches to the two services (it has no `$form_id` allowlist — the guarding is done
inside each service):

1. `entity_translations_helper->alterModalForm($form, $form_state)` — rewires the submit to an AJAX
   in-place callback **only** when the request is a modal/ajax request carrying
   `?entity_translations_helper=ajax` (see [../api/services.md](../api/services.md)).
2. `entity_translations_helper->alterMainForm($form, $form_state)` — injects the "Manage related
   translations" panel **only** on the edit form of a non-default translation of a bundle that hides
   untranslatable fields on translation forms.
3. `entity_translations.language_information` — when
   `isTranslatableContentCreationForm($form_state)` is true, calls `addLanguageHelper($form, $form_state)`
   to inject the creation-language notice.

Because the alter runs on all forms, an integrator does not call anything: enabling the module plus the
right content-translation bundle settings is what activates each branch.

## `hook_entity_extra_field_info()`

`entity_translations_helper_entity_extra_field_info()` registers a **form-context pseudo-field** named
`entity_translations_helper_language` on **every bundle** of `node`, `media`, and `taxonomy_term` (it
loads each entity type's bundle entities and only emits for types that have a bundle entity type):

```php
$extra[$entity_type_id][$bundle]['form']['entity_translations_helper_language'] = [
  'label' => t('Language helper'),
  'description' => t('Let editors know the language they are creating content to, and allows to switch languages.'),
  'weight' => -1,
];
```

This lets site builders **reorder or hide** the creation-language notice from
*Manage form display* for those bundles. The notice's actual render array is added at runtime by
`EntityTranslationsLanguageInformation::addLanguageHelper()` under the same `entity_translations_helper_language`
form key; the extra-field entry only governs its placement/visibility. The related-translations panel
(`entity_translations_helper` key) is **not** registered as an extra field and cannot be rearranged this
way.

## Hooks NOT implemented

No `hook_help`, no `hook_theme`, no update hooks, no entity CRUD hooks, no `hook_requirements`. There is
no `.install` file. No alter hooks are *invoked* by this module for integrators to implement.
