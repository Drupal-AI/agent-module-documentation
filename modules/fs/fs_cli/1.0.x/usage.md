<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
fs_cli exposes the Drupal `file_system` service through a set of Drush commands so files and directories can be inspected and manipulated from the command line.

---

The module registers a single Drush command class (`FsCliCommands`) via `drush.services.yml`; it has NO routes, controllers, forms, permissions or config. Every command wraps a method of core's `FileSystemInterface` (or a plain PHP `is_dir`/`file_exists`) and returns the result serialised (JSON by default) via the `serializer` service, which makes the output easy to consume from scripts. Because it is strictly CLI-only, access is governed entirely by who can run Drush on the server — there is no web-exposed surface and therefore no path-traversal or arbitrary-file-access endpoint. Destructive operations (`fs:move`, `fs:delete-dir`) act on whatever path the operator passes, so treat it like any other shell tool.

Typical use is in deployment/migration scripts or ad-hoc maintenance where you need to check for a file, create/scan a directory, or copy/move assets (e.g. into the public/private/S3 stream wrappers) without writing a one-off PHP snippet.
---
- Check whether a directory exists with `drush fs:directory-exists <dir>` (alias `fs-de`).
- Check whether a file exists with `drush fs:file-exists <file>` (alias `fs-fe`).
- Move a file to a new location with `drush fs:move <file> <destination>`.
- Copy a file with `drush fs:copy <source> <destination>`.
- Scan a directory against a regex mask with `drush fs:scan-dir <dir> <mask>`.
- Create a directory with `drush fs:mkdir <dir>`.
- Recursively delete a directory with `drush fs:delete-dir <dir>`.
- Get machine-readable JSON output for any command (default `--format=json`).
- Request other serializer formats via the `--format` option.
- Control overwrite behaviour on move/copy with the `$replace` argument (REPLACE/RENAME/ERROR).
- Operate on stream-wrapper URIs like `public://`, `private://` or `s3://` paths.
- Script existence checks before conditionally copying assets during a deploy.
- Prepare (auto-create) the destination directory automatically on move/copy.
- Use in CI to assert that generated files landed where expected.
- Clean up temporary directories after a batch job.
- Enumerate all matching files under a tree for a manifest.
- Wire the JSON output into `jq` for further processing.
- Replace bespoke PHP maintenance snippets with a repeatable command.
- Verify a private-files directory exists before a migration writes to it.
- Copy fixtures into place for automated tests.
