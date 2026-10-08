<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Static Suite (static_suite) — agent index

**A decoupled static-site pipeline: export Drupal data → build with an SSG → deploy releases, driven from Drupal.**

- **Version:** 1.2.x
- **Core:** ^9.1 || ^10 || ^11 — dep `locale`
- **Configure:** `/admin/config/.../static_suite` (route `static_suite.settings`)
- **Submodules:** `static_export` (data → files, pluggable resolvers), `static_build` (SSG build via `Cli/CliCommand` proc_open), `static_deploy` (deployers e.g. S3), `static_preview` (+ `static_preview_gatsby_instant`).
- **Key services:** `static_suite.cli_command_factory`, `static_suite.release_manager` (symlink swap), `static_suite.file_path_sanitizer` (traversal-strip), async task/toolbar services.
- **Drush:** export/build/deploy command sets across submodules.

**Security:** All `exec()`/`proc_open` are admin-only build tooling — shell strings from config, plugin annotations, and validated internal release paths (`../`/realpath guards); no request input reaches them (by design). Settings/export/build/deploy config forms require `administer site configuration`. Request-facing surfaces: sanitizer+permission-gated `static_export.file_viewer` (`view static export files`), `_role: authenticated` running-data endpoints, and `access content`-gated `static_preview_gatsby_instant` page resolvers taking `pagePath`. No `verify=>false`/TLS-disable; the single `unserialize()` (`FileCollectionWriter.php:801`) uses `allowed_classes`. No `_access: TRUE` anywhere.

See [configure/pipeline.md](configure/pipeline.md)
