<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set up asymmetric layout translations

There is **no settings form**. Setup is: enable Layout Builder overrides on a bundle, make
the bundle translatable, and place the `layout_builder_at_copy` widget.

## 1. Enable Layout Builder overrides on the bundle

*Manage display* → **Use Layout Builder** + **Allow each content item to have its layout
customized**, or:

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.page.default');
$vd->setThirdPartySetting('layout_builder', 'enabled', TRUE)
   ->setThirdPartySetting('layout_builder', 'allow_custom', TRUE)
   ->save();
```

Saving that creates the `layout_builder__layout` field storage. Because
`layout_builder_at_field_storage_config_presave()` runs on every `field_storage_config`
save, the storage comes out **translatable**:

```bash
drush php:eval '
  $fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "layout_builder__layout");
  print var_export($fs && $fs->isTranslatable(), TRUE);'   # -> true
```

On an existing site, `layout_builder_at_install()` re-saves every `layout_section` storage
named `layout_builder__layout` so already-created fields are converted too.

## 2. Enable translation

*Configuration → Regional and language → Content language and translation*
(`/admin/config/regional/content-language`) — enable translation for the entity type/bundle
and tick the **Layout** field. The module strips Layout Builder's "Non translatable" warning
from that page (`hook_theme_registry_alter()`), so the field can be ticked normally.

## 3. Place the copy widget on the form display

```yaml
# core.entity_form_display.node.page.default
content:
  layout_builder__layout:
    type: layout_builder_at_copy
    region: content
    weight: 90
    settings:
      appearance: checked      # unchecked | checked | checked_hidden
    third_party_settings: {  }
```

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.page.default');
$fd->setComponent('layout_builder__layout', [
  'type' => 'layout_builder_at_copy',
  'region' => 'content',
  'weight' => 90,
  'settings' => ['appearance' => 'checked'],
])->save();
```

Read it back:

```bash
drush cget core.entity_form_display.node.page.default content.layout_builder__layout
```

### `appearance` values

| Value | Effect on the *add translation* form |
|---|---|
| `unchecked` (default) | "Copy blocks into translation" is shown, unticked |
| `checked` | shown, ticked by default |
| `checked_hidden` | forced on and hidden from the editor (`#access: FALSE`) |

The widget summary reads `Appearance: <label>`.

The checkbox is only *effective* when the entity being saved is a **new, non-default
translation** (`$entity->isNewTranslation() && !$entity->isDefaultTranslation()`); on the
original-language form the element is present but inert.

### Do not use `layout_builder_widget`

Once `layout_builder__layout`'s `FieldConfig` is translatable,
`layout_builder_at_validate_form_display()` blocks saving the *Manage form display* form with
the core widget selected:

> You can not select the Layout Builder Widget, please select a different widget.

## 4. Optional: inline block language

New inline blocks created inside Layout Builder get the parent entity's langcode
(`layout_builder_at_form_layout_builder_add_block_alter()`). To turn that off:

```php
// settings.php
$settings['layout_builder_at_set_content_block_language_to_entity'] = FALSE;
```

## Sanity checks

```bash
# storage translatable?
drush php:eval 'print var_export(\Drupal\field\Entity\FieldStorageConfig::loadByName("node","layout_builder__layout")->isTranslatable(), TRUE);'
# widget in place?
drush cget core.entity_form_display.node.page.default content.layout_builder__layout type
# not co-installed with the symmetric module?
drush pm:list --status=enabled --filter=layout_builder_st
```
