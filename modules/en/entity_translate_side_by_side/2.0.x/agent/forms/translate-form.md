<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Side-by-side translation form

Files: `src/Form/EntityTranslateSideBySideForm.php`,
`src/Controller/EntityTranslateSideBySideController.php`,
`src/Breadcrumb/EntityTranslateSideBySideBreadcrumbBuilder.php`,
`src/Hook/EntityTranslateSideBySideHooks.php`, `entity_translate_side_by_side.routing.yml`,
`js/edit_form_scripts.js`, `js/drag_and_drop_scrolling.js`, `css/edit_form_styles.css`.

## Route

`entity_translate_side_by_side.routing.yml`:
```
entity_translate_side_by_side:
  path: '/entity-translate/{entity_type}/{entity_id}'
  defaults:
    _form: '…\Form\EntityTranslateSideBySideForm'
    _title_callback: '…\Controller\EntityTranslateSideBySideController::titleCallback'
  requirements:
    # access requirements
    entity_type: '.+'
    entity_id: '\d+'
  options:
    _admin_route: TRUE
```
Access is controlled by the module's own "Access Entity Translate Side by Side" permission. The
`entity_type`/`entity_id` route parameters identify the entity to translate, and the title callback
returns "Entity translation for @label type of @entity_type".

## Reaching the form

`Hook\EntityTranslateSideBySideHooks::addTranslateSideBySideOperation()` (`#[Hook('entity_operation')]`,
also bridged by `entity_translate_side_by_side_entity_operation()` in the `.module`) adds a
**"Translate side by side"** operation (weight 10) for every entity that is a `TranslatableInterface`,
has a numeric id, `isTranslatable()`, and is not in the skip list (`menu_link_content` by default;
alterable via `hook_entity_translate_side_by_side_skip_alter()`). The operation URL carries
`?destination=<current>`.

## buildForm() — rendering the languages

`EntityTranslateSideBySideForm extends FormBase`; DI: `entity_type.manager`, `language_manager`
(`create()`); `$defaultLanguage` = system default langcode.

1. Validates `$entity_type` via `entityTypeManager->hasDefinition()` and loads the entity by id;
   adds an error message and returns early if either is missing.
2. Determines the language set: `langcodes` query param (comma-list) if present, else the configured
   `entity_translate_side_by_side.settings:languages`, else the entity's existing translation
   languages, else the site default.
3. `addFieldsForSelectedLanguages()` builds, per selected language, a helper form via
   `EntityFormDisplay::collectRenderDisplay($entity, 'edit')->buildForm(...)` on the translation
   (`getTranslation($langcode)` or a temporary `addTranslation($langcode)`), then
   `updateChildElementParents()` prefixes each element's `#parents` with the langcode so values land
   under `$form_state[$langcode][$field]`. Fields are ordered by `createSortedListOfFields()` (form
   display component weights). Only editable fields are added (see below); a `#tree` container
   `language_fields` holds one sub-container per language.
4. `getLanguageSelectDetailsSummary()` adds a collapsible `language_selection` checkboxes element,
   an "Update Languages" span (JS-driven, not a submit) and, for users with
   `administer site configuration`, an inline link to the settings route.
5. Attaches libraries `edit_form_styles` and `edit_form_scripts`. A "Save translations" submit is
   added only when at least one field was rendered (`$form['#fields_have_been_added']`).

`isFieldEditable()` accepts a field only if it is translatable, not read-only, not computed, not a
base field, and not in `$blacklist` (`langcode`, `uid`, `status`, `created`, `changed`,
`default_langcode`, `content_translation_source`, `content_translation_outdated`,
`layout_builder__layout`).

## submitForm() — change detection and save

- Resets entity cache and reloads (temporary `addTranslation()` calls in buildForm can leave unsaved
  states), then reads `language_selection`.
- For each selected langcode, gets/creates the translation and iterates field definitions; for each
  editable field compares submitted vs stored value via `shouldSaveChanges()` and only
  `set()`s changed fields. Required fields left empty inherit the default translation's value.
- `shouldSaveChanges()` has per-type key handling (`target_id` for file/image/entity_reference,
  `value` for text/string/text_with_summary/boolean), strips empty deltas from multi-value text,
  and treats null/''/empty-array as equal (`arraysAreEffectivelyEqual()`, `isEffectivelyEmpty()`) —
  so unchanged languages/fields are never re-saved.
- New translation status: published only if the default translation is published (new ones default
  to published, existing keep their status); if the default translation is unpublished, status = 0.
- Saves the translation, then reports updated languages/fields via a `Markup`-built message. Redirects
  to `internal:/<destination>` when a `destination` query param is present.

## Title, breadcrumb, JS

- `EntityTranslateSideBySideController::titleCallback()` loads the entity (throws
  `InvalidArgumentException` on bad type/id) and returns the page title.
- `EntityTranslateSideBySideBreadcrumbBuilder` (`applies()` on this route name) builds Home →
  optional "Previous page" (from `destination`, only if `Url::fromUserInput()->isRouted()`) →
  current entity label.
- `js/edit_form_scripts.js` wires the "Update Languages" span to reload the form with the chosen
  `langcodes`; `js/drag_and_drop_scrolling.js` adds click-drag horizontal scrolling of the language
  container; `css/edit_form_styles.css` lays the language columns out side by side.
