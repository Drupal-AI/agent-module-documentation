# Media source plugin: `webform_media`

The module provides one core media-source plugin (it does not define a new plugin type).

Class: `Drupal\webform_media\Plugin\media\Source\Webform`, extends core `MediaSourceBase`.
Plugin id is the constant `Webform::PLUGIN_ID = 'webform_media'`.

## Plugin definition (`#[MediaSource]` attribute)
| Property | Value |
| --- | --- |
| `id` | `webform_media` |
| `label` | "Webform" |
| `description` | "Use webforms as media." |
| `allowed_field_types` | `['webform']` — the source field must be a Webform entity reference |
| `default_thumbnail_filename` | `no-thumbnail.png` |
| `thumbnail_alt_metadata_attribute` | `thumbnail_alt_value` |
| `forms['media_library_add']` | `Drupal\webform_media\Form\WebformMediaAddForm` |

## Metadata
- `getMetadataAttributes()` returns `[]` — no extra metadata attributes are exposed for field
  mapping.
- `getMetadata($media, 'default_name')` reads the source field name from
  `$this->configuration['source_field']`, takes the first item (an `EntityReferenceItem`), and
  returns the referenced `WebformInterface::label()`. If the media has no such field it throws
  `\Exception`; if the referenced webform is gone it returns `"Webform with ID @id deleted."`. Any
  other attribute falls through to `MediaSourceBase::getMetadata()`.

## Media Library "quick add" form
`WebformMediaAddForm` extends `media_library`'s `AddFormBase`; form id
`webform_media_library_webform_add`.

- `buildInputElement()`: if the Media Library state reports no available slots it returns the form
  unchanged. Otherwise it adds a container with a `select` named `field_media_webform_media` whose
  `#options` are every webform (`entityTypeManager->getStorage('webform')->loadMultiple()`, keyed by
  id → `label()`), its `#title`/`#description` taken from the source field definition, plus an AJAX
  **Add** submit button wired to `media_library.ui`.
- `addButtonSubmit()` passes the selected webform id to `AddFormBase::processInputValues()`, which
  creates the media entity referencing that webform.
- The form only renders where `media_library` is enabled and is reachable only by users allowed to
  add media of this type.
