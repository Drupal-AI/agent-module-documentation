<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field type, widget, Views field & settings

There is **no admin settings page** (`configure: null`). You configure the module by adding
its field and choosing its widget on a bundle's *Manage fields* / *Manage form display*.

## Field type: `entity_reference_entity_modify`

Label "Media with contextual modifications". Extends core `EntityReferenceItem`.

- Default storage setting `target_type: media` (the storage-settings form hard-codes media;
  the base field is still a normal entity reference so `target_type` can be other types when
  created via API, but the UI is media-oriented).
- Default widget: `media_library_media_modify_widget`. Default formatter:
  `entity_reference_entity_view` (rendered entity). Any entity_reference formatter works —
  `hook_field_formatter_info_alter()` adds `entity_reference_entity_modify` to every
  formatter that supports `entity_reference`.
- Extra DB column `overwritten_property_map` (`type: text`, `size: big`) storing a JSON map
  of `{field_name: override_value}`. Applied to a **clone** of the referenced entity at load
  time (see api/service.md).

Create via API:

```php
FieldStorageConfig::create([
  'field_name' => 'field_context_media',
  'entity_type' => 'node',
  'type' => 'entity_reference_entity_modify',
  'settings' => ['target_type' => 'media'],
])->save();
FieldConfig::create([
  'field_name' => 'field_context_media', 'entity_type' => 'node',
  'bundle' => 'article', 'label' => 'Contextual media',
])->save();
```

## Widget: `media_library_media_modify_widget`

Label "Media library extra". Extends core `MediaLibraryWidget`, `multiple_values: TRUE`,
`field_types: [entity_reference, entity_reference_entity_modify]`.

Settings (config schema `field.widget.settings.media_library_media_modify_widget`, which
extends `field.widget.settings.media_library_widget`):

| Setting | Default | Effect |
|---|---|---|
| `form_mode` | `default` | Form mode used by the per-item override form. Only shown for the `entity_reference_entity_modify` field type. |
| `multi_edit_on_create` | `false` | After creating several new media items, show one combined form applied to all of them. Mutually exclusive with `no_edit_on_create`. |
| `no_edit_on_create` | `false` | Skip the edit form after creating a new media item. Mutually exclusive with `multi_edit_on_create`. |
| `check_selected` | `false` | Pre-check items already in the field when the library reopens (cardinality ≠ 1 only). |
| `replace_checkbox_by_order_indicator` | `false` | Replace the library selection checkbox with an order indicator (cardinality ≠ 1 only). |

On an `entity_reference_entity_modify` field the widget adds an "Override … in context of
this …" button per selected item (opens the override modal). On a plain `entity_reference`
field it instead adds a simple "Edit media item" link to the media's edit form.

Set the widget via API:

```php
$fd = \Drupal::service('entity_display.repository')->getFormDisplay('node', 'article', 'default');
$fd->setComponent('field_context_media', [
  'type' => 'media_library_media_modify_widget',
  'settings' => ['form_mode' => 'default', 'multi_edit_on_create' => TRUE],
])->save();
```

Read back: `drush cget core.entity_form_display.node.article.default content.field_context_media`.

## Views field: `media_library_media_modify_edit_link`

Title "Edit link for the Media Library" (help: "Provides a link for editing media entities
from within the media library"). Attach it to the **media library view's widget display**
(real field `mid` on the `media` base table). It renders an AJAX "Edit" button that opens the
media edit form inside the library modal. Which fields are shown there is controlled by the
media type's `media_library` form display.

## Routes (no permission)

- `media_library_media_modify.form` → `/media_library_media_modify` (the override form;
  custom access = the referenced entity's `view` access, keyed by a tempstore hash).
- `media_library_media_modify.ui` → `/media-library-media-modify` (builds the edit UI).
