<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# xntt_file_field — agent index

Submodule of **[external_entities](../../../../3.0.x/agent/start.md)**. Lets external entity **file and
image fields** be sourced from a **file path or URL** instead of a Drupal managed-file id, so remote
files work like local ones (image styles, formatters, Views, etc.). It adds a **`file` field mapper**
and a custom **`xntt://` stream wrapper** that resolves special file ids back to the external entity's
URI. Core `^9 || ^10 || ^11`. Depends on `external_entities`. No settings page, no permissions.

- **Map a file/image field to a remote URI (mapper, stream, hooks)** → [fields/file-field-mapper.md](fields/file-field-mapper.md)

Key facts:
- Field mapper id: `file` (`Plugin/ExternalEntities/FieldMapper/FileFieldMapper`), applies to `file`/`image` field types.
- Stream wrapper: scheme `xntt://` (service `stream_wrapper.xnttfiles` → `StreamWrapper\XnttStream`).
- Virtual file entity type `xnttfile` (`ExternalFileStorage`); special id `xntt-{type}-{id}-{field}#{delta}`.
- Config schema: `xntt_file_field.schema.yml`. Optional per-mapping regex to restrict allowed URIs.
- Services: `entity.query.xntt_file_field`, `xntt_file_field.file.usage` (decorates `file.usage`).
