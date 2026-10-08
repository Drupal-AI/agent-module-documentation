# The `representative_image` field, its widget and settings

The module's entry point is a field type you add to a fieldable bundle. It does **not** store an image
of its own — the widget is deliberately empty. Instead its per-field settings point at *another*
field on the same bundle (an image field or an entity-reference field) and define a fallback, and the
picker service resolves the actual image at display time.

## Field type — `representative_image`

`Drupal\representative_image\Plugin\Field\FieldType\RepresentativeImageItem` extends the core `image`
field type (`ImageItem`). Attribute: `#[FieldType(id: 'representative_image', category: 'general',
default_widget: 'representative_image', default_formatter: 'representative_image')]`. Add it to any
fieldable bundle (content type, term, user, comment, media, …); one instance per bundle is expected.

## Widget — `representative_image`

`Plugin/Field/FieldWidget/RepresentativeImageWidget` extends the core `ImageWidget` but overrides
`formElement()` and `formMultipleElements()` to both `return []`. There is **no data-entry element** —
the whole configuration is done through the field's *settings*, not by uploading an image. This is why
the field never appears on the node edit form.

## Field settings (the actual configuration)

`RepresentativeImageItem::defaultFieldSettings()` adds two keys on top of the inherited image settings
(`file_directory`, `default_image`, `alt_field`, etc.). Set them under **Manage fields → (the
representative image field) → settings** (`fieldSettingsForm`, `RepresentativeImageItem.php:35`).

| Setting key | Type | Meaning |
|---|---|---|
| `representative_image_field_name` | string | Machine name of the source field to pull the image from. Options come from `RepresentativeImagePicker::getSupportedFields()`. Empty = "None". |
| `representative_image_behavior` | string | What to do when the chosen source field is empty. |

Config schema: `field.field_settings.representative_image` (extends `field.field_settings.image`),
`config/schema/representative_image.schema.yml:41`.

### Source-field options — `getSupportedFields($entity_type, $bundle)`

`RepresentativeImagePicker::getSupportedFields()` (`RepresentativeImagePicker.php:165`) returns the
fields eligible to be a source: every field whose type is `image` **or** `entity_reference` and whose
target type resolves to a content entity class (`ContentEntityInterface`). This is what lets the field
follow a reference — e.g. point at a `media` reference field, and the module will in turn read the
media entity's own representative image field.

### Behavior values — `representative_image_behavior`

The settings form (`RepresentativeImageItem.php:50`) offers an empty option labelled **"Do nothing"**
plus three explicit values. Resolution happens in `RepresentativeImagePicker::getImageFieldItemList()`
(`RepresentativeImagePicker.php:84`):

| Value (submitted) | UI label | Effect when the source field is empty |
|---|---|---|
| `first` | Use the first image found on the entity | `getFirstAvailableImageField()` — first non-empty supported image/reference field. |
| `default` | Use the default image | `getDefaultImage()` — the field's / storage's `default_image` (by UUID). |
| `first_or_default` | Use the first image on the entity, or the default | first available, else the default image. |
| `''` (empty, "Do nothing") | Do nothing | Falls into the `else` branch → `getDefaultImage()`. See note. |

**Note (code detail, not a config option):** `getImageFieldItemList()` returns `NULL` only when the
behavior is the literal string `'nothing'`, but the widget's empty option submits `''`, not
`'nothing'`. So choosing "Do nothing" does **not** short-circuit to NULL — it falls through to the
default-image branch (`RepresentativeImagePicker.php:97-111`). If the source field is populated, the
behavior is irrelevant; it only matters as a fallback.

### Resolution pipeline

`getImageFieldItemList()` (a) uses `representative_image_field_name` if that field exists and is
non-empty, else applies the behavior above; (b) fires `hook_representative_image_alter()` on the
resolved item list (see [../api/service.md](../api/service.md)); (c) calls
`getImageFieldFromReference()` — if the resolved list is an entity reference (e.g. media), it follows
the reference and reads the referenced entity's own `representative_image` field recursively, so image
fields and media references are handled uniformly.

`getDefaultImage()` clones the item list into a runtime-only object and sets a synthetic item with
`_is_default => TRUE` so the fallback renders without mutating the stored entity
(`RepresentativeImagePicker.php:193`).

## Add the field from code

```php
// Storage (once per entity type).
\Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'field_representative_image',
  'entity_type' => 'node',
  'type' => 'representative_image',
])->save();

// Instance (per bundle) + settings pointing at an existing image field.
\Drupal\field\Entity\FieldConfig::create([
  'field_name' => 'field_representative_image',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Representative image',
  'settings' => [
    'representative_image_field_name' => 'field_image',
    'representative_image_behavior' => 'first_or_default',
  ],
])->save();
```

Exception thrown when a bundle has no representative image field:
`Drupal\representative_image\Exception\RepresentativeImageFieldNotDefinedException` (a `\RuntimeException`).
