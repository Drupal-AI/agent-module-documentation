# acquia_contenthub_s3 — agent start

**DEPRECATED** (`lifecycle: deprecated`) and experimental. Integrated `s3fs`-stored files with
Acquia Content Hub. Requires `s3fs` (dev), `file`, `system`, `acquia_contenthub`. No UI,
permissions, Drush, or config schema. **Do not adopt for new sites.**

## What it did
- `hook_file_insert`/`hook_file_delete` maintain an `S3FileMap` (uuid → bucket, root folder,
  origin UUID) so `s3://` files don't need repeated location discovery on syndication.
- Services: `s3_file_entity.cdf.handler`, `acquia_contenthub_s3.file_map` / `.file_mapper` /
  `.file_storage`, `acquia_contenthub_s3.s3fs_stream.decorator`,
  `acquia_contenthub.s3_file.dependency_collector`, and an `s3` FileSchemeHandler plugin.

For current file syndication use the base module's file scheme handlers (see the parent
`agent/plugins/file-scheme-handler.md`). No solution docs for this deprecated module.
