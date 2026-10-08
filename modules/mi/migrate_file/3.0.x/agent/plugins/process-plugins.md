<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# The four process plugins

All are `@MigrateProcessPlugin`s in `Drupal\migrate_file\Plugin\migrate\process`. Use them
under a field mapping in a migration's `process:` section. Class hierarchy:
`ImageImport → FileImport → (core) FileCopy`, and `FileRemoteImage → FileRemoteUrl → ProcessPluginBase`.

## `file_import` (FileImport)

Copies/downloads/moves the source file **and creates a managed `file` entity**, returning an
entityreference value. This is the key difference from core `file_copy`, which only copies
and returns the destination **URI** (no entity). On a re-run, if a file entity already exists
for the destination URI it is reused (and re-marked permanent), so imports are idempotent.

- `source` (**required**): source path or URI — `/path/to/foo.txt`, `public://bar.txt`, or
  `https://…`. Remote sources are always downloaded (the `move` flag is ignored for them).
- `destination` (recommended): target path or URI. Default `public://`. A **trailing slash**
  means "directory" (original filename is appended); no trailing slash means the value is the
  full destination filename. Supports `@property` destination references (quoted) so you can
  build dynamic paths (see [../api/patterns.md](../api/patterns.md)). Static values need a
  `constants/…` source.
- `uid`: uid to own the file entity. Default `0`. Accepts `@uid` (destination reference).
- `move`: `true` = move instead of copy (local sources only). Default `false`.
- `file_exists`: overwrite behaviour when the destination exists — `replace` (default),
  `rename` (append `_N` until unique), or `use existing` (return the existing file, copy
  nothing). (Internally maps to core `FileExists::Replace|Rename|Error`.)
- `skip_on_missing_source`: `true` = skip the field if the source is missing/404 instead of
  failing the row. Costs one HTTP request per remote file. Default `false`.
- `source_check_method`: `HEAD` (default, faster) or `GET` — request method used for the
  remote existence check when `skip_on_missing_source` is set.
- `skip_on_error`: `true` = skip the field on any import error (throws
  `MigrateSkipProcessException`) instead of failing the row. Default `false`.
- `guzzle_options`: array of Guzzle request options (auth, timeout, headers) for remote
  fetches and existence checks.
- `id_only`: `true` = return just the file id (integer) instead of `['target_id' => N]`.
  Useful when you set other field sub-properties yourself. Default `false`.

Returns `['target_id' => N]`, or `N` if `id_only: true`.

## `image_import` (ImageImport)

Everything `file_import` does, plus it fills image-field sub-properties. Adds:

- `alt`, `title`: text for the image field. Accept a source key, a `@destination` ref, or the
  special `!file` value = use the imported file's **filename**.
- `width`, `height`: image dimensions.

Note: `image_import` forces `id_only` off internally (it must return the array of
sub-properties). Returns `['target_id' => N, 'alt' => …, 'title' => …, 'width' => …, 'height' => …]`.

## `file_remote_url` (FileRemoteUrl)

Creates a `file` entity whose **URI is the remote URL itself — nothing is downloaded**. You
must have something that can serve the external URI, e.g.
[`drupal/remote_stream_wrapper`](https://www.drupal.org/project/remote_stream_wrapper). Config:

- `uid`: uid to own the file entity. Default `0`.

Returns the `File` entity. (If the source value is empty it returns `NULL` so the destination
can stub it.)

## `file_remote_image` (FileRemoteImage)

Like `file_remote_url` but for image fields. Lets you declare the dimensions so the image
module doesn't fetch the remote image just to measure it. Config:

- `uid`: default `0`.
- `width`, `height`: optional. If **both** are set it returns
  `['target_id' => N, 'width' => W, 'height' => H]`; otherwise it returns the `File` entity.

## Minimal example (attach a downloaded image to a node)

```yaml
source:
  plugin: embedded_data
  data_rows:
    - { id: 1, img: 'https://example.com/logo.png', headline: 'Hello' }
  ids: { id: { type: integer } }
  constants: { dest: 'public://imported/' }
destination:
  plugin: 'entity:node'
  default_bundle: article
process:
  title: headline
  field_image:
    plugin: image_import
    source: img
    destination: constants/dest      # trailing slash → keep original filename
    uid: 1
    alt: headline
    skip_on_missing_source: true
```
