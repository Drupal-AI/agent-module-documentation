<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the unified form is built and each translation is saved

All logic lives in `entity_translation_unified_form.module` plus
`Hook\EntityTranslationUnifiedFormHooks`. There are **no routes or permissions of its own** — it
piggybacks on the existing entity add/edit forms.

## 1. Ordering

`hook_module_implements_alter()` moves this module's `form_alter` to the **end** of the list so it
runs *after* `ContentTranslationHandler::entityFormAlter()` has already marked fields.

## 2. Injecting the other-language fields (`formAlter` → `add_fields`)

`EntityTranslationUnifiedFormHooks::formAlter()`:
- Returns early unless the form object is an `EntityForm`; also skips `layout_builder`,
  `revisions`, `scheduled_transitions`, `node_type_add_form`, `_book_outline_form` form ids.
- Adds the `saveonly` button if configured (see settings doc).
- If the bundle has ETUF enabled: finds `::save` in `$form['actions']['submit']['#submit']`, and
  **splices in** `entity_translation_unified_form_node_form_submit` *before* it and
  `entity_translation_unified_form_node_form_post_save` *after* it. Mirrors this for the `preview`
  button (`…_node_form_preview`) and the `saveonly` button. If "Replace node edit" is on it also
  adds `…_nondefault_language_adjust_redirect` after post-save.
- Calls `entity_translation_unified_form_add_fields($form, $form_state)`.

`entity_translation_unified_form_add_fields()` picks the mode plugin
(`…_bundle_display_mode`; **forced to Inline when side-by-side is enabled**), collects
`EntityFormDisplay::collectRenderDisplay($entity, 'default')`, and for each field calls
`entity_translation_unified_form_node_insert_other_language_fields()`. It also, when a menu link is
enabled on the form, adds a `link-title-etuf-{langcode}` textfield per other language pre-filled
from the menu link's / node translation's title.

`…_node_insert_other_language_fields()` (per field): only for **translatable, non-hidden** fields,
loops `EtufHelper::getOtherTranslationLanguages($entity)` and calls
`entity_translation_unified_form_build_field()` to clone the widget for that language, renames it
`{field}-etuf-{langcode}` (via `EtufHelper::getEtufFieldName()`), fixes `#parents` / `add_more`
`#name`, attaches the mode plugin's theme wrappers, and stores it at `$form[$field][$langcode]`.
Marks `$form[$field]['#multilingual'] = TRUE`. When side-by-side is on it also wraps
non-translatable fields in `<div class="etuf-sbs-none">` and injects `etuf-{field}-sep` spacers.

`entity_translation_unified_form_build_field()` builds each per-language widget from the source
`$form_display->getRenderer($field_name)->form($items, …)`, loading the correct translation's items
(and, for nodes with content moderation, the *latest translation-affected revision* via
`getLatestTranslationAffectedRevisionId()`). When `…_translate_labels` is on it temporarily flips
`languageManager()->setConfigOverrideLanguage()` (and clears cached field definitions) so labels
render in the target language, restoring afterward. It also re-applies field default values for new
entities.

## 3. Saving each translation (`…_node_form_submit`)

Runs just before core `::save`. For the resolved `EntityForm` entity:

```php
$other_languages = EtufHelper::getOtherTranslationLanguages($entity);
foreach ($other_languages as $other_langcode => $other_language) {
  $translation = $entity->hasTranslation($other_langcode)
    ? $entity->getTranslation($other_langcode)
    : $entity->addTranslation($other_langcode);
  foreach ($fields as $field_name => $field_definition) {
    $etuf_name = EtufHelper::getEtufFieldName($field_name, $other_langcode); // {field}-etuf-{lang}
    if (isset($values[$etuf_name])) {
      // …type-specific handling…
      $translation->set($field_name, $values[$etuf_name]);
    }
  }
}
```

So the single core save persists the source language **and** every other translation. Per-field
special-casing: `metatag` (flattened + `serialize()`), `moderation_state` (see below),
`created` (timestamp fix, bug #3117164), `image`/`file` (copies `fids[0]` → `target_id`). Menu-link
titles for other languages are saved here too by loading `menu_link_content` by uuid and
`->save()`-ing the translation. Missing titles are back-filled from the source title.

## 4. Moderation / revision handling

When a `moderation_state` value is present for a translation, the handler sets a new revision, marks
`setRevisionTranslationAffected(TRUE)`, copies the revision log message and user, and stores a
`entity_translation_unified_form_post_save` array on the form state (`moderation_state` +
`interface_langcode` per langcode).

`…_node_form_post_save()` runs **after** core `::save` (when the entity is saved and its revision id
is authoritative) and calls `…_custom_shutdown()` per stored langcode. `…_custom_shutdown()` loads
the exact saved revision (`loadRevision($vid)`), and if a moderation state was set does
`setSyncing(TRUE)` + `set('moderation_state', …)` + `save()` on that translation. It registers two
shutdown functions: `EtufHelper::postCreateOrUpdateAutoTranslate` (auto-translates the node's menu
link title) and `…_custom_shutdown_menu` (updates/creates the pathauto alias per language via
`pathauto.generator`).

`js/sync.js` (library `etuf-moderation-sync`, attached in `page_attachments` unless
`…_moderation_sync_disable`) keeps the per-language moderation-state selects in sync in the browser.

## 5. Preview

`…_node_form_preview()` mirrors the submit logic to populate translations on the previewed entity;
`hook_library_info_alter` strips core `drupal.node.preview` JS, and the README notes a core preview
patch is needed for correct language preview.

## 6. "Replace node edit" route

`Routing\RouteSubscriber::alterRoutes()` (when any node bundle enables it) overrides the
`entity.node.edit_form` route **defaults** (`_controller` →
`ReplacementNodeEditController::getReplacementNodeEditPage`, `_title_callback` → EntityController)
and adds `load_latest_revision => TRUE` to the `{node}` param. The controller builds the
default-language edit form so translatable fields hidden on non-default-language edit forms remain
editable. The core route **requirement** `_entity_access: node.update` is not modified, so reaching
the form still requires node update access.

## Access model

The unified form is reached through the **standard** entity add/edit route and is therefore gated
by that route's normal entity access (`node.create` / `node.update`). Because all languages' fields
live on that one form, saving it writes every enabled translation in a single submission — this is
the module's intended behaviour, so enable it per bundle for editors who are meant to maintain all
languages' content together (the README frames "Replace node edit" the same way).

## Helper reference (`EtufHelper`)

- `getEtufFieldName($field, $langcode)` → `"{field}-etuf-{langcode}"` (the form-element name scheme).
- `getOtherTranslationLanguages($entity)` / `getOtherEnabledLanguages()` — all enabled languages
  except the entity's / current interface language.
- `getLang()`, `getDefaultLangcode()`.
- `translateLinkIfNotTranslated()` / `postCreateOrUpdateAutoTranslate()` — auto-translate a node's
  menu link title from the node translation.
- `addToLog($msg, $debug=FALSE)` — logs to the `etuf` channel only when `$debug` is TRUE.
