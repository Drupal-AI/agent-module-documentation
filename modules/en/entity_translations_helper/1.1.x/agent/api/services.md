# Services & mechanism (API)

Both services are invoked from `entity_translations_helper_form_alter()` (`.module`). They are plain
service objects — you can fetch them from the container, but the module's value is the automatic form
behavior, so the important part below is the **trigger conditions**.

## `entity_translations_helper` — related-translations panel

`Drupal\entity_translations_helper\EntityTranslationsHelper` (args: `@request_stack`,
`@content_translation.manager`, `@entity_type.manager`). Uses `AjaxDetectionTrait`.

Public methods:

- `alterMainForm(array &$form, FormStateInterface $form_state): void` — the entry point. It builds the
  "Manage related translations" panel **only** when `alterMainFormGetValidEntity()` returns an entity,
  i.e. all of: the form object is a `ContentEntityFormInterface`; the entity is a
  `ContentEntityInterface`, **not new**, **translatable**, and **not the default translation**; and the
  bundle's content-translation settings have `untranslatable_fields_hide` truthy (the *"Hide non
  translatable fields on translation forms"* checkbox, read via
  `ContentTranslationManagerInterface::getBundleTranslationSettings($entity_type_id, $bundle)`).
  (`EntityTranslationsHelper.php:84`, `:166`.)
- `alterModalForm(array &$form): void` — when `alterModalFormAjaxCheck()` is true (the request
  `isAjaxRequest()` **and** query `entity_translations_helper === 'ajax'`), it adds a `#process`
  callback and turns the form's `actions.submit` button into an AJAX submit
  (`callback => alterModalFormAjaxCallback`, `event => click`, `disable-refocus => TRUE`).
  (`EntityTranslationsHelper.php:98`, `:185`.)
- `static alterModalFormProcess(array $element): array` — hides every action button except `submit`
  (`#access = FALSE`) so the modal submit cannot redirect. (`:118`.)
- `static alterModalFormAjaxCallback(array $form, FormStateInterface $form_state): AjaxResponse` — on
  a submit with **no** form errors: `CloseDialogCommand` on `.entity-translations-helper-modal`,
  rebuilds the entity's language link and `ReplaceCommand`s the `.entity-translations-helper-entity-<id>`
  element with it, and prepends `status_messages` before the outer `form`. On errors, prepends the
  messages inside the modal form instead. (`:139`.)

How the panel is built (all `protected`/`static`, for reference): `alterMainFormEntityBuidlFieldDetails()`
collects referenced entities into a `ReferencedEntitiesStore`, groups them by entity type into nested
`details` elements, and assigns them to `$form['entity_translations_helper']`;
`alterMainFormBuidlWrapperDetails()` wraps that in the outer "Manage related translations" details
(`#weight => -999`). `setReferencedEntitiesInStore()` walks `$entity->getFieldDefinitions()`, keeps
only `entity_reference`/`entity_reference_revisions` fields that are **not translatable and not empty**,
stores each referenced entity that is a translatable `ContentEntityInterface`, and recurses **only into
`paragraph`** references with `$level` capped at 5. `getRenderableArrayLink()` chooses `edit-form`
(label "Edit") when the target already `hasTranslation($langcode)`, else
`drupal:content-translation-add` (label "Add") with `source`/`target` route params; for non-node
targets it adds `use-ajax`, `data-dialog-type=modal`, `data-dialog-options` (75%×75%,
`ui-dialog-content => entity-translations-helper-modal`), attaches `core/drupal.dialog.ajax`, and sets
the `entity_translations_helper=ajax` query so the reopened modal form gets `alterModalForm`'s callback.

### AJAX modal convention

Links the panel generates for **non-node** entities carry `?entity_translations_helper=ajax` and open
as Drupal modals. On the modal request `alterModalForm()` recognises that query param and rewires the
submit to `alterModalFormAjaxCallback`, which closes the dialog and swaps the just-edited link in the
parent form without a page reload. Node links intentionally skip the modal and open in a new tab
(`target=_blank`) because a node edit form is too large for the dialog.

### Selector constants

`SELECTOR_BASE = entity-translations-helper`, `SELECTOR_MODAL = entity-translations-helper-modal`,
`SELECTOR_WRAPPER = entity-translations-helper-wrapper`,
`SELECTOR_FIELD_BASE = entity-translations-helper-field-` (suffixed with the referenced entity type
id), `SELECTOR_ENTITY_BASE = entity-translations-helper-entity-` (suffixed with the entity id). All are
run through `Html::cleanCssIdentifier()` when emitted as classes.

## `entity_translations.language_information` — creation-language notice

`Drupal\entity_translations_helper\EntityTranslationsLanguageInformation` (args: `@entity_type.manager`,
`@request_stack`, `@current_route_match`, `@language_manager`, `@renderer`). Uses `AjaxDetectionTrait`.
PHP-8 promoted-property constructor.

Public methods:

- `isTranslatableContentCreationForm(FormStateInterface $form_state): bool` — true when **all** hold:
  form object is a `ContentEntityFormInterface`; entity is a `ContentEntityInterface` and **new**; the
  request is **not** AJAX; the bundle's `ContentLanguageSettings` (`ContentLanguageSettings::loadByEntityTypeBundle`)
  is **not** language-alterable (`!isLanguageAlterable()`, i.e. no language selector on the form); the
  entity is **translatable**; entity type id is one of `node`, `media`, `taxonomy_term` and has a bundle
  entity type; and the route parameter for that bundle entity type is a `ConfigEntityBundleBase`.
  (`EntityTranslationsLanguageInformation.php:57`.)
- `addLanguageHelper(array &$form, FormStateInterface $form_state): void` — when more than one language
  exists, injects `$form['entity_translations_helper_language']`, a `details` titled *"You are creating
  this &lt;bundle&gt; in &lt;language&gt;. Do you want to create it on a different language?"* whose body
  is *"Switch language to: …"* with a `Link::createFromRoute()` per **other** language, reusing the
  current `route_name` and the bundle route parameter but with each language's URL option. (`:83`.)

## Container access (rarely needed)

```php
$helper = \Drupal::service('entity_translations_helper');            // EntityTranslationsHelper
$lang   = \Drupal::service('entity_translations.language_information'); // EntityTranslationsLanguageInformation
```

There is no PHP API here meant for reuse beyond the form-alter flow — no translation-loading helpers,
no fallback-resolution utilities. `ReferencedEntitiesStore` is an internal `final` collector
(`ReferencedEntitiesStore::create()`, `setReferencedEntity()`, `getReferencedEntities()`,
`ifReferencedEntities()`) that only keeps entity types whose definition `hasLinkTemplate('edit-form')`.
