# The H5P field type & `h5p_content` entity

## Field type `h5p`

Defined by `Drupal\h5p\Plugin\Field\FieldType\H5PItem`:

```php
@FieldType(
  id = "h5p",
  label = "Interactive Content – H5P",
  category = "reference",
  default_widget = "h5p_upload",
  default_formatter = "h5p_default",
)
```

- Storage column: `h5p_content_id` (int, unsigned) — a reference to an `h5p_content` entity id.
- Extra (computed) properties: `h5p_content_revisioning_handled`, `h5p_content_new_translation`
  (used to manage revision/translation duplication of the underlying content in `preSave()`).
- Widgets: `h5p_upload` (upload a `.h5p` package; shipped by this module) and `h5p_editor`
  (in-browser authoring; shipped by the **h5peditor** submodule).
- Formatter: `h5p_default` (renders the interactive content / iframe).

Add the field programmatically (works without any H5P content-type library installed):

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_interactive', 'entity_type' => 'node', 'type' => 'h5p',
])->save();
FieldConfig::create([
  'field_name' => 'field_interactive', 'entity_type' => 'node',
  'bundle' => 'article', 'label' => 'Interactive',
])->save();
```

## `h5p_content` entity

`Drupal\h5p\Entity\H5PContent` — content entity, base table `h5p_content`, entity key `id`. Base
fields include:

| Field | Meaning |
|---|---|
| `library_id` | The H5P library (content type) this content instantiates |
| `parameters` | Raw/unsafe content parameters (JSON, `string_long`) |
| `filtered_parameters` | Safe, filtered parameters used for rendering |
| `disabled_features` | Bitmask of disabled display features |

Load/inspect: `\Drupal::entityTypeManager()->getStorage('h5p_content')->load($id)`. The entity is
created/updated by the widgets when a package is uploaded or authored; rendering it fully requires
the H5P core/editor libraries and installed content-type libraries.

## Views & AJAX

- Views access plugin `h5paccessuserpoints` gates viewing a user's H5P result points
  (checks `access all h5p results` / `access own h5p results`).
- AJAX routes: `/h5p-ajax/set-finished.json` (xAPI results), `/h5p-ajax/content-user-data/…`
  (resume state), `/h5p/{id}/embed` (embeddable render).
