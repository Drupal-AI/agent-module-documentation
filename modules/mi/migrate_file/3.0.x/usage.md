<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
Migrate File (extended) adds four migrate **process plugins** — `file_import`, `image_import`, `file_remote_url` and `file_remote_image` — that let a migration create a managed file (or image) entity from a local path or a remote URL *inline*, in the same migration row as the node/media/entity that references it, instead of needing a separate dedicated files migration first.

---

Core Migrate ships `file_copy` (copies/downloads a file and returns the destination URI) and `download`, but neither creates a `file` **entity**, so the classic pattern is to run a standalone files migration and then reference the already-migrated files by id from your content migration. `migrate_file` collapses that into one step: `file_import` extends core's `FileCopy`, does the copy/download/move/rename, then creates a `file` entity and returns an entityreference value (`['target_id' => N]`, or just the id with `id_only: true`) ready to drop into a file/image field. This makes it ideal when importing nodes straight from a CSV, JSON, XML or non-Drupal API whose fields contain file paths or URLs. `image_import` extends `file_import` and additionally populates the image field's `alt`, `title`, `width` and `height` sub-properties (with a `!file` shortcut to use the filename as alt/title). `file_remote_url` and `file_remote_image` are the "don't download" variants: they create a `file` entity whose URI is the remote URL itself (no HTTP fetch), which requires the [Remote Stream Wrapper](https://www.drupal.org/project/remote_stream_wrapper) module to serve those URIs; `file_remote_image` also lets you supply width/height so the image module doesn't fetch the remote image just to measure it. All the plugins support dynamic destinations and can reference other destination values with the `@property` syntax (quoted), and `file_import` exposes fine control over overwrite behaviour (`file_exists`: replace / rename / use existing), attribution (`uid`), local move-vs-copy (`move`), and resilience (`skip_on_missing_source`, `skip_on_error`, `source_check_method`, `guzzle_options`). Note the installed release is **3.0.0-alpha1** (alpha stability) and the module ships no schema, permissions, services or Drush commands — it is purely a set of process plugins consumed from migration YAML/config.

---

- Import a node from CSV where one column is a local file path, attaching it to a file field with `file_import`.
- Download a remote file referenced by URL in a source feed and store it as a managed file during the node migration.
- Import an image and set its `alt`/`title` from other source columns using `image_import`.
- Use the source filename as the image `alt` text with the `!file` shortcut in `image_import`.
- Copy an existing local file into `public://` and get a `file` entity without a separate files migration.
- Move (not copy) a local source file into the Drupal files directory with `move: true`.
- Automatically rename on collision (`file_exists: rename`) so re-imports don't overwrite existing files.
- Reuse an existing file entity/on-disk file instead of re-copying with `file_exists: 'use existing'`.
- Attribute imported files to a specific author by mapping `uid` (including `@uid` from the destination).
- Skip a row's file gracefully when the source file is missing via `skip_on_missing_source: true`.
- Speed up remote existence checks by choosing `source_check_method: HEAD` vs `GET`.
- Pass Guzzle options (auth headers, timeouts) for downloads with `guzzle_options`.
- Return only the file id (`id_only: true`) so you can manage other image sub-fields yourself.
- Build dynamic destination folders per row (e.g. `public://<category>/<year>/`) with a concat pseudo-field fed to `destination`.
- Reference the migrated file's filename to fill the image `title` field.
- Store a remote CDN URL as a file entity **without downloading** using `file_remote_url` (+ Remote Stream Wrapper).
- Register remote images with known dimensions via `file_remote_image` (supply `width`/`height`) to avoid slow remote measuring.
- Migrate a media entity's image source field from an external URL in the same run.
- Import product images from an external PIM/API feed directly onto Commerce product media.
- Pull avatar images from a legacy system into user picture fields during a user migration.
- Bulk-import PDF/document attachments from a spreadsheet of file paths.
- Handle mixed local + remote sources in one field mapping (local files copied, remote files downloaded).
- Fail fast on unexpected errors, or swallow them per-row, by toggling `skip_on_error`.
- Combine with `migrate_source_csv` / `migrate_plus` `embedded_data` sources for a self-contained file-import migration.
- Re-run a migration idempotently: `file_import` finds and reuses the existing file entity for an already-copied destination.
