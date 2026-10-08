# Configure the Image Crop (Imager) widget

No global settings page (`configure` is null). You enable the editor per image field on the entity's
**Manage form display** tab, then set one option.

## Enable it

1. Go to *Manage form display* for the bundle (e.g. `admin/structure/types/manage/article/form-display`,
   or a Media type's form display).
2. For an **Image** field, set the widget to **"Imager Widget"** (`imagecroper`).
3. Open the widget cog to set **Type of update image**, then *Update* and *Save*.

The widget extends core `ImageWidget`, so all the usual image-widget settings (preview image style,
etc.) are still present; imagecroper only adds the one select below.

## The one setting

| Setting key | Type | Options | Default | Effect |
|---|---|---|---|---|
| `update_image_type` | string (select, required) | `replace`, `new` | code `defaultSettings()` = `new`; the settings form's `#default_value` falls back to `replace` if unset | How an edit is persisted on submit. |

- **`replace` — "Replace existing image":** decoded bytes are written over the original file's URI
  (`FileRepository::writeData(... EXISTS_REPLACE)`), the file entity's MIME type is updated from the
  client data-URI, and all image-style derivatives for that URI (plus their `.webp` siblings) are
  deleted so they regenerate. The `fid` and filename stay the same — existing references keep working.
- **`new` — "Create new image":** decoded bytes are written to `public://<original-filename>` with
  `EXISTS_RENAME` (so nothing is overwritten), a new managed file is created, and the field's value is
  repointed to the new `fid`.

The settings summary appends "Type of update image: …".

> Schema mismatch: `config/schema/imagecroper.schema.yml` maps `update_image` while the plugin reads/writes
> `update_image_type`. The stored value therefore has no matching schema entry — cosmetic, but it can emit a
> config-schema warning in tests/`drush config:inspect`.

## Store it with Drush (example)

```php
// drush php:eval — put the Imager widget on node.article field_image, replacing in place on edit.
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_image', [
  'type' => 'imagecroper',
  'region' => 'content',
  'settings' => ['update_image_type' => 'replace'] + \Drupal\imagecroper\Plugin\Field\FieldWidget\Imagecroper::defaultSettings(),
])->save();
```

## How editing works at runtime (for debugging)

- On the edit form, once a file is uploaded the widget's `#process` adds a **"Start Editing"** link, an
  `.imagers` container, and a hidden `imager_output` textarea, and attaches the `imagecroper/imagerjs`
  library (bundled ImagerJS + `js/imager_widget.js`, deps `core/jquery`, `core/drupal`).
- `imager_widget.js` fetches the preview image (via `XMLHttpRequest` → base64), instantiates
  `ImagerJs.Imager` with plugins `Rotate, Crop, Resize, Save, Toolbar, Undo`, and on ImagerJS "save"
  writes the base64 data-URI into the hidden textarea (an `alert()` reminds the user to save the form).
- On submit, `massageFormValues()` splits the data-URI, base64-decodes it, reads the MIME type from it,
  and writes the file per `update_image_type`. If the textarea is empty the original upload is kept
  unchanged.
