# Configure the Webform media type

`webform_media` adds no settings form and no route of its own. You operate it entirely through
core's Media UI by creating a media type that uses the module's media source. There is nothing to
configure globally — configuration lives on each media type you create.

## Create the media type (UI)
1. Enable `webform_media` (pulls in `media`; also enable `media_library` for the library UI).
2. Structure → Media types → **Add media type** (`/admin/structure/media/add`).
3. Set **Media source** = *Webform*, fill label/id, Save.
4. On the second step Drupal creates and maps the **source field** — a Webform entity-reference
   field (field type `webform`). Save again.
5. On any entity with a media entity-reference field (and optionally the Media Library widget), add
   the new *Webform* bundle to the field's allowed target bundles.

## Add a webform as media
- Content → Media → **Add media** → the Webform type → pick a webform → Save; or
- Use the Media Library "quick add" tab for the Webform type, which shows a select of every webform
  (see [../plugins/media-source.md](../plugins/media-source.md)).

The media can then be selected in any media reference field / Media Library that allows the Webform
bundle, and embedded in CKEditor via the Media Library button.

## Config object & schema
Each media type using this source stores its source settings in the media type's
`source_configuration`, validated by:

| Item | Value |
| --- | --- |
| config schema id | `media.source.webform_media` |
| schema base type | `media.source.field_aware` (core) |
| `source_field` | machine name of the webform entity-reference field on the bundle |

Set the source on a media type via PHP (the source field is created by
`MediaSourceBase::createSourceField()` on save):

```php
$type = \Drupal\media\Entity\MediaType::load('webform');
$type->set('source', 'webform_media');
$type->save();
```

Read the webform a given media references (matches how the plugin resolves it):

```php
/** @var \Drupal\media\MediaInterface $media */
$source = $media->getSource();
$fieldName = $source->getConfiguration()['source_field'];
/** @var \Drupal\webform\WebformInterface|null $webform */
$webform = $media->get($fieldName)->entity;
```

## What happens at runtime
- The media's auto **name** (`default_name`) is produced by `Webform::getMetadata()`, which returns
  the referenced webform's `label()`, or `"Webform with ID @id deleted."` if the reference is
  dangling.
- No thumbnails are generated; the source declares `default_thumbnail_filename: no-thumbnail.png`.
- Rendering the media renders the referenced webform through Webform's own render pipeline, so the
  webform's own access and settings still apply.
