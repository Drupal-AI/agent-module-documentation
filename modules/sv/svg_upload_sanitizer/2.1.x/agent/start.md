<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SVG Upload Sanitizer (svg_upload_sanitizer) — agent index

Cleans script and other active content out of uploaded SVG files. It implements
`hook_file_insert()`: whenever a **managed `File` entity** is first saved, the module checks whether
its MIME type is `image/svg+xml` and, if so, rewrites the file **in place on disk** with the sanitised
output of the `enshrined/svg-sanitize` library, then updates the stored file size. Because it hooks the
`File` entity layer rather than a specific field or form, it covers every upload path that produces a
managed file — file/image fields, the media library, Webform file elements, and the REST/JSON:API file
upload resource. There is no settings form: the underlying sanitizer runs with its default allow-list
configuration and is tuned (if needed) by **decorating the `svg_upload_sanitizer.sanitizer.svg`
service** (see the README's `removeRemoteReferences` example).

- Depends on: `drupal:file` (core File module).
- Core: `^10 || ^11`. Package: `Media`. PHP: `^8.1`.
- Library: `enshrined/svg-sanitize ~0.22` (installed: `0.22.0`) — a real allow-list SVG sanitiser, not
  a regex.
- No configure route, no settings form, no permissions, no config schema, no plugin types, no drush,
  no routes, no field widgets/formatters. Its entire surface is one hook + a small service graph.

## What you'd do → where

- **Understand exactly when sanitisation runs and what it touches (upload paths, MIME gate, in-place
  rewrite, size update)** → [hooks/file-insert.md](hooks/file-insert.md)
- **Change how SVGs are cleaned (strip remote references, minify, adjust the allow-list) or call the
  sanitiser/helpers from code** → [api/services.md](api/services.md)

## Key facts (real machine names)

- Hook: `svg_upload_sanitizer_file_insert(FileInterface $file)` = `hook_file_insert()`
  (`svg_upload_sanitizer.module`). It dispatches to
  `Drupal\svg_upload_sanitizer\HookHandler\FileInsertHookHandler::process()` via `class_resolver`.
  (Note: the docblock mislabels it "hook_entity_type_insert" — the function name makes it
  `hook_file_insert`.)
- Services (`svg_upload_sanitizer.services.yml`):
  - `svg_upload_sanitizer.sanitizer.svg` — class `enshrined\svgSanitize\Sanitizer` (the library; the
    intended decoration point).
  - `svg_upload_sanitizer.helper.sanitizer` — `Helper\SanitizerHelper` (args: `@file_system`,
    `@svg_upload_sanitizer.sanitizer.svg`).
  - `svg_upload_sanitizer.helper.file` — `Helper\FileHelper` (arg: `@file_system`).
  - `logger.channel.svg_upload_sanitizer` — logger channel `svg_upload_sanitizer`.
- MIME gate: `SanitizerHelper::sanitize()` returns early (does nothing) unless
  `$file->getMimeType() === 'image/svg+xml'` (`src/Helper/SanitizerHelper.php:60`).
- All classes are marked `@internal`. There are no public API stability guarantees beyond the service
  ids.
