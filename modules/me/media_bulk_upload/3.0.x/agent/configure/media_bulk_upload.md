# Configure bulk-upload configurations & forms

## The `media_bulk_config` config entity

Each `media_bulk_config` defines one bulk upload form. Managed at
**Admin → Configuration → Media → Bulk upload media** (`/admin/config/media/media-bulk-config`,
route `entity.media_bulk_config.collection` — this is the module's `configure` route).

Routes:

| Route | Path | Access |
|---|---|---|
| `entity.media_bulk_config.collection` | `/admin/config/media/media-bulk-config` | `administer media_bulk_upload configuration` |
| `media_bulk_upload.add` | `/admin/config/media/bulk-upload/add` | `administer media_bulk_upload configuration` |
| `entity.media_bulk_config.edit_form` | `/admin/config/media/media-bulk-config/{id}/edit` | admin permission |
| `entity.media_bulk_config.delete_form` | `/admin/config/media/media-bulk-config/{id}/delete` | admin permission |
| `media_bulk_upload.list` | `/media/bulk-upload` | any usable config (redirects if only one) |
| `media_bulk_upload.upload_form` | `/media/bulk-upload/{media_bulk_config}` | `use {id} bulk upload form` |

## Configuration fields (`MediaBulkConfigForm`)

| Key | Type | Meaning |
|---|---|---|
| `label` | string | Human name; its machine `id` derives the per-config permission |
| `media_types` | sequence | Media type IDs whose files this form may create; allowed extensions & max size come from these types |
| `form_mode` | string | Media form mode embedded in the upload form (default `- None -`); shows fields shared by all selected types, falling back to the default form when a type lacks the mode |
| `upload_location` | string | Stream URI files are uploaded to before being moved into each type's target directory (default `temporary://media-bulk-upload`) |

`config_prefix` is `media_bulk_config`; `config_export` also lists `show_alt`/`show_title` but the form and schema
(`config/schema/media_bulk_config.schema.yml`) only cover `media_types`, `form_mode`, `upload_location`. Configs
export/deploy with `drush config:export`.

`upload_location` is validated on save: it must be a valid stream scheme; `private://` requires a configured private
directory, `temporary://` a temp directory, and the directory is created (`prepareDirectory`) with proper permissions.

## How a file becomes media

`MediaTypeManager` groups all media types by the file extensions declared on each type's source (file/image) field.
On submit, each uploaded file's extension is matched against the config's selected types; the file is validated
(extension, per-type `max_filesize`, and image `min/max_resolution` for image sources), moved into the media type's
target field directory, and saved as a new media entity via Drupal's Batch API. When multiple selected types share an
extension, the file is assigned to one of them automatically.
