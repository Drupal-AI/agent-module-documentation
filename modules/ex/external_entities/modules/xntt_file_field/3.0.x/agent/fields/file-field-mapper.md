# File / image fields for external entities

Drupal file and image fields normally reference a managed-file id, but external sources only expose a
path or URL. This submodule bridges that: add a normal `file` or `image` field to your external entity
type, then in the type's Field mapping section choose the **File field mapper** (`file`). You map the
source URI to the field's **External file URI** (`real_uri`) property; you may also map Title / Alt.

## How it works

- Field mapper `Plugin/ExternalEntities/FieldMapper/FileFieldMapper` (id `file`, for field types
  `file`/`image`).
- On load, `xntt_file_field_entity_storage_load()` sets each file field item's `target_id` to a
  synthetic id `xntt-{xntt_type}-{entity_id}-{field_name}#{delta}`.
- `hook_entity_preload` (`xntt_file_field_entity_preload`) intercepts those ids (regex
  `ExternalFileStorageInterface::XNTT_FILE_ID_REGEX`) and loads them as `xnttfile` entities via
  `ExternalFileStorage::loadExternalFile()`.
- The `xntt://` stream wrapper (`StreamWrapper\XnttStream`, service `stream_wrapper.xnttfiles`,
  scheme `xntt`) resolves the synthetic path back to the external entity's real URI so Drupal can read
  the file (e.g. to generate an image-style derivative). It provides read access only — no writes to
  the original file.
- Field storage `target_type` is transparently switched from `file` to the `xnttfile` entity type
  (`xntt_file_field_entity_field_storage_info_alter`, and the field-config edit-form entity builder),
  and file validation/reference constraints are swapped for external-file-tolerant versions
  (`xntt_file_field_field_info_alter` → `ExternalFileValidation`, `ExternalReferenceAccess`).
- The edit widget's `managed_file` element is replaced by an `external_file` element
  (`Element\ExternalFile`) that adds the URI field and hides upload/remove.
- `xntt_file_field.file.usage` decorates core `file.usage` to no-op on external files.

## Mapper settings

- **External file URI** (`real_uri`) — required mapping; the source field holding the path/URL.
- **Regular expression to filter allowed URI (optional)** — restrict which URIs are accepted (e.g.
  `https?://some\.server\.com/.*`); the pattern is wrapped as `#^…$#`.
- **Force file extension (optional)** — virtually append an extension when the URL lacks one so Drupal
  can determine the MIME type / apply image styles.

Config schema keys live in `xntt_file_field.schema.yml`. Once mapped, image styles and file/image
formatters work on the remote files, and remote images are processed locally into cached derivatives.
