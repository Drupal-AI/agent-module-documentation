<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — the Inline frame media source

`media_iframe` provides no admin settings page (`configure = null`). You "configure" it by
creating a **media type** that uses its source, exactly like any core media source.

## The source plugin

`src/Plugin/media/Source/InlineFrame.php`:

```php
@MediaSource(
  id = "inline_frame",
  label = @Translation("Inline frame"),
  allowed_field_types = {"iframe"},
  default_thumbnail_filename = "iframe.png",
  forms = { "media_library_add" = MediaIframeAddForm::class },
)
```

- `PLUGIN_ID = 'inline_frame'`.
- `getMetadataAttributes()` returns `[]` (no extractable metadata).
- `createSourceField()` returns the parent field with **label overridden to `Inline Frame URL`**.
- `prepareViewDisplay()` sets the source field component to formatter `iframe_default`,
  label `visually_hidden`.

The source field type comes from the contrib **`iframe`** module (`type: iframe`). The default
generated source-field name is **`field_media_inline_frame`**.

## Create the media type (UI)

Admin → Structure → Media types → Add media type → **Media source: Inline frame** → Save.
Drupal auto-creates the `field_media_inline_frame` source field and sets the view display.

## Create the media type (code / Drush)

The source-field storage must be created explicitly before the field (creating the type alone
leaves `source_configuration.source_field` pointing at a non-existent field, which then errors):

```php
use Drupal\media\Entity\MediaType;
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

MediaType::create(['id' => 'remote_page', 'label' => 'Remote page', 'source' => 'inline_frame'])->save();
FieldStorageConfig::create([
  'entity_type' => 'media', 'field_name' => 'field_media_inline_frame', 'type' => 'iframe',
])->save();
FieldConfig::create([
  'entity_type' => 'media', 'field_name' => 'field_media_inline_frame',
  'bundle' => 'remote_page', 'label' => 'Inline Frame URL', 'required' => TRUE,
])->save();
MediaType::load('remote_page')
  ->set('source_configuration', ['source_field' => 'field_media_inline_frame'])
  ->save();
```

## Resulting config

- `media.type.<id>`: `source: inline_frame`, `source_configuration.source_field: field_media_inline_frame`.
- `field.storage.media.field_media_inline_frame`: `type: iframe`.
- `field.field.media.<id>.field_media_inline_frame`: `label: Inline Frame URL`.
- Config schema entry `media.source.inline_frame` (extends `media.source.field_aware`).

## Media Library add form

`src/Form/MediaLibrary/MediaIframeAddForm.php` (`getFormId()` → `..._iframe`) renders a single
`#type => 'url'` "Iframe URL" input plus an AJAX **Add** button, so editors can mint iframe
media from inside the Media Library modal. Nothing to configure — it is wired via the source
plugin's `forms.media_library_add`.
