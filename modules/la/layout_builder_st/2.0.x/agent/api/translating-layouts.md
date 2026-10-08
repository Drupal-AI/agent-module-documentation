# Enable and translate a Layout Builder override

There is no config form. "Configuration" means: enable overrides + content translation, then
translate a layout. The module wires up the storage automatically.

## The translation field

- Field name: **`layout_builder__translation`**, field type `layout_translation`
  (`OverridesSectionStorage::TRANSLATED_CONFIGURATION_FIELD_NAME`).
- It is **locked**, translatable, cardinality 1, `no_ui = TRUE`, and stores the translated
  labels/component config that differ per language. It sits beside core's
  `layout_builder__layout` override field (`OverridesSectionStorage::FIELD_NAME`).
- It is added **automatically**:
  - on module install, to every bundle that already has overrides
    (`layout_builder_st_install()` → `_layout_builder_st_add_translation_field()`), and
  - whenever overrides are newly enabled on a bundle — the module's
    `LayoutBuilderEntityViewDisplay::addSectionField()` calls `addTranslationField()`.

So the operational trigger is simply: **enable Layout Builder overrides on the bundle's view
display** (allow each entity to have its layout customised). The translation field appears
without any manual field creation.

## Enable overrides for a bundle (drush/PHP)

```php
$display = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.page.default');
$display->enableLayoutBuilder()->setOverridable(TRUE)->save();
// With layout_builder_st installed this ALSO creates field_config
// layout_builder__translation on node.page.
```

Verify the field exists:

```bash
drush php:eval 'var_export((bool) \Drupal\field\Entity\FieldConfig::loadByName("node","page","layout_builder__translation"));'
```

## Translate a layout (UI)

1. Enable **content translation** and add a language.
2. Enable Layout Builder **overrides** on the content type (Manage display → Layout options →
   "Allow each … to have their layout customized").
3. Create/override a node's layout in the default language.
4. Go to the node's **Translate** tab, edit the target-language translation, open **Layout**.
5. Because the layout is symmetric you cannot restructure it here; you get **Translate block**
   actions (routes `layout_builder.translate_block` for reusable/config blocks,
   `layout_builder.translate_inline_block` for inline content blocks via the block_content
   `layout_builder_translate` form) to translate labels and inline-block content.
6. Save. At view time `ComponentPluginTranslate` swaps in the translated component config for
   the active language.

## Notes

- Access to the translate routes is gated by `_layout_builder_translation_access` (only on a
  translation, i.e. not the default/original language) plus normal Layout Builder `view`
  access.
- Structural changes (add/remove/move sections & components) are shared across all languages;
  only translatable strings/inline content differ. That is the "symmetric" contract.
