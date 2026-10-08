<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Packages (content_packages) — agent index

**A Drush toolset that exports/imports/verifies/diffs Drupal content as canonical Markdown + asset archive packages.**

- **Version:** 1.2.x (1.2.0)
- **Core:** ^10 || ^11
- **Depends:** filter, text
- **Surface:** Drush only (`drush.services.yml` → `ContentPackagesCommands`): `content-packages:validate|import|export|archive:export|archive:verify|archive:import|diff|assets:cleanup`.
- **Plugin type:** `ContentPackageType` (`node_markdown_body`, `ContentEntityPackageType`).
- **Key services:** `content_packages.manager`, `archive_exporter`, `archive_importer`, `archive_verifier`, `archive_reader`, `graph_validator`, `source_locator`, `body_html_processor`.
- **No routing.yml, no permissions.yml, no web controllers.**

**Security:** CLI-only — reachable only by an operator with Drush/shell access; no anonymous or web-facing import, no access gap, no request-driven URL fetch. Hardened archive handling: `ContentPackageArchiveReader::normalizePath()` rejects absolute paths, `..` traversal and null bytes (`:117`, `:122`), plus decompression-bomb limits before extraction. Import always verifies first — `ContentPackageArchiveImporter::importArchive()` calls `verify()` before writing, no bypass. No TLS/credential handling. No security findings.

See [drush/commands.md](drush/commands.md)