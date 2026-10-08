<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# What the module overrides

All of this is implicit — there is no API to call, but knowing the seams explains the
behaviour and the conflicts.

## Hooks (`layout_builder_at.module`)

| Hook | Effect |
|---|---|
| `hook_ENTITY_TYPE_presave()` for `field_storage_config` | `setTranslatable(TRUE)` on any `layout_section` storage named `OverridesSectionStorage::FIELD_NAME` (`layout_builder__layout`) |
| `hook_layout_builder_section_storage_alter()` | Repoints the `overrides` section-storage definition at `Drupal\layout_builder_at\Plugin\SectionStorage\TranslatableOverridesSectionStorage` |
| `hook_module_implements_alter()` | Removes `layout_builder`'s `form_entity_form_display_edit_form_alter` so this module can decide when to call it |
| `hook_form_FORM_ID_alter()` for `entity_form_display_edit_form` | Calls Layout Builder's original alter **only** when the bundle's layout field is *not* translatable; otherwise adds `layout_builder_at_validate_form_display` |
| `hook_theme_registry_alter()` | Drops `layout_builder_preprocess_language_content_settings_table()` so the "Non translatable" warning disappears on the content-language form |
| `hook_form_alter()` | Reveals the layout field on entity forms and retitles the checkbox to *"Copy blocks into translation"* when `#layout_builder_at_access` is TRUE |
| `hook_form_FORM_ID_alter()` for `layout_builder_add_block` | Sets the new inline block's `langcode` to the host entity's language (unless the `settings.php` flag is FALSE) |
| `hook_entity_translation_delete()` | Deletes the `layout_builder.section_storage.overrides` shared tempstore entry `<type>.<id>.default.<langcode>` |
| `hook_install()` | Re-saves existing `layout_builder__layout` storages to make them translatable |

## Section storage

`TranslatableOverridesSectionStorage extends OverridesSectionStorage` and overrides exactly
one method:

```php
protected function handleTranslationAccess(AccessResult $result, $operation, AccountInterface $account): AccessResultInterface {
  return $result;   // core would forbid the Layout tab on a non-default translation
}
```

That is the whole reason the *Layout* tab works on a translation.

## Service provider

`Drupal\layout_builder_at\LayoutBuilderAtServiceProvider::register()` swaps the class of
`layout_builder.get_block_dependency_subscriber` for
`Drupal\layout_builder_at\EventSubscriber\SetInlineBlockDependencyWithContextTranslation`,
so inline-block dependency calculation is translation-aware.

## The copy widget

`Drupal\layout_builder_at\Plugin\Field\FieldWidget\LayoutBuilderCopyWidget`
(`#[FieldWidget(id: "layout_builder_at_copy", field_types: ["layout_section"], multiple_values: FALSE)]`)
does the real work in `extractFormValues()`, and only after validation is complete:

1. Skip unless `#layout_builder_at_access` is TRUE (new, non-default translation).
2. Pick the source translation — `$form_state->getValue('source_langcode')['source']` if the
   translation form supplied one, else `$entity->getUntranslated()`.
3. For each section: clone it, empty its components, sort the originals by weight.
4. For each component whose plugin id starts with `inline_block:`:
   - load the `block_content` revision, `createDuplicate()` it (also duplicating any
     `entity_reference_revisions` targets, e.g. paragraphs);
   - keep only the target language's values, remove other translations, set `langcode`;
   - save, then rewrite the component's `block_id`, `block_revision_id` and (if present)
     `block_uuid`;
   - register usage via `inline_block.usage->addUsage()`.
   If duplication fails the component is dropped and a message is shown.
5. Give every cloned component a fresh UUID and append it.
6. `$items->setValue($new_sections)` — or `setValue(NULL)` when the checkbox was off, which
   is what leaves the translation with an empty layout.

## Compatibility

- Requires `layout_builder` + `content_translation`.
- **Incompatible with `layout_builder_st`** (symmetric translations) on the same site.
- Because the field storage is made translatable globally, every bundle using Layout Builder
  overrides on that entity type is affected.
