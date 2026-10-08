<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Use the Media library widget on a Custom Field column

## Prerequisite: a media entity_reference column

The widget only applies to a Custom Field `entity_reference` column whose `target_type` is
`media`. In the field storage `columns` setting:

```yaml
# field.storage.node.field_hero.settings.columns
image:
  name: image
  type: entity_reference
  target_type: media
```

Create it scriptably:

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;
FieldStorageConfig::create([
  'field_name' => 'field_hero', 'entity_type' => 'node', 'type' => 'custom', 'cardinality' => 1,
  'settings' => ['columns' => [
    'image' => ['name' => 'image', 'type' => 'entity_reference', 'target_type' => 'media'],
  ]],
])->save();
FieldConfig::create(['field_name' => 'field_hero', 'entity_type' => 'node', 'bundle' => 'article', 'label' => 'Hero'])->save();
```

## Set the column's widget to Media library

On `core.entity_form_display.<entity>.<bundle>.<mode>`, the parent field uses base widget
`custom_flex`/`custom_stacked`, and each column's input plugin is `settings.fields.<col>.type`.
Set it to `media_library_widget` (optionally restrict `media_types`):

```php
$fd = \Drupal::service('entity_display.repository')->getFormDisplay('node', 'article', 'default');
$fd->setComponent('field_hero', [
  'type' => 'custom_flex', 'weight' => 5, 'region' => 'content',
  'settings' => ['fields' => [
    'image' => [
      'type' => 'media_library_widget',
      'media_types' => ['image'],   // allowed media type IDs, in order; [] = all allowed
    ],
  ]],
])->save();
```

## Read it back

```bash
drush cget core.entity_form_display.node.article.default content.field_hero
# settings.fields.image.type => media_library_widget ; settings.fields.image.media_types => [image]
```

## UI path

*Structure → Content types → <type> → Manage form display* → the Custom Field's cog → for the
media column choose **Media library** as the widget, then set *Media types* if desired. Editing
a node then shows a "Add media" button opening the core Media Library modal.

## Notes

- The widget is offered **only** when the column's reference `target_type` is `media`; on any
  other entity_reference column it is not applicable.
- `media_types` is validated by the schema key added to `custom_field.field.*`
  (`hook_config_schema_info_alter()`). Empty = every bundle the reference allows.
- No new storage: selected media IDs are stored in the Custom Field's own `entity_reference`
  column, like any other custom_field entity_reference value.
