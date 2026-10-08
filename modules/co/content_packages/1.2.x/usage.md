<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A Drush-driven toolset that serialises Drupal content entities into canonical, portable "content packages" (Markdown documents plus asset/reference archives) and imports, verifies and diffs them again.

---

The module is built from a plugin system (`ContentPackageType` plugins such as `node_markdown_body`) and a large set of services: a source locator, package parser, body/HTML processor, asset and media handlers, field and component handlers, a reference collector and graph validator, plus archive reader/writer/exporter/importer/verifier. All operations are exposed only as Drush commands (`content-packages:validate`, `:import`, `:export`, `:archive:export`, `:archive:verify`, `:archive:import`, `:diff`, `:assets:cleanup`) — there is no routing, no permissions file, and no web controller. The import path always runs verification first (`ContentPackageArchiveImporter` calls the verifier before writing; there is no verify bypass), and archives are opened through a hardened reader.

The archive reader is explicitly defensive: `normalizePath()` rejects absolute paths, `..` traversal segments, and null bytes, and the reader enforces decompression-bomb limits (per-entry and total uncompressed caps derived from the memory limit) before extracting entries into a temporary tree. Because the entire surface is CLI-only, it is reachable solely by an operator who already has shell/Drush access — there is no anonymous or web-facing import, no request-supplied URL fetch, and no access gap. The body processor uses CommonMark with an HTML-stripping environment for the canonical form. Typical use is exporting content to versioned Markdown/archives for review or migration, verifying an archive's integrity and references, then importing it into another site.
---
- Export nodes to canonical Markdown content packages
- Import content packages back into a site via Drush
- Export a full archive (content + assets + manifest)
- Verify an archive's integrity and references before import
- Dry-run an archive import to preview changes
- Diff on-disk packages against current site content
- Validate a package source against a package type
- Migrate content between environments as portable files
- Version-control content as Markdown in a repository
- Bundle referenced entities and media into one archive
- Detect missing reference targets during import
- Clean up orphaned package assets with a Drush command
- Resolve a package source from file or directory paths
- Enforce a package type (e.g. node_markdown_body) on import
- Rebuild a content graph with reference validation
- Strip raw HTML into safe canonical Markdown bodies
- Schedule content publish state via the scheduler service
- Round-trip nodes without database dumps
- Review content changes as readable Markdown diffs
- Guard imports against zip-bomb archives
- Reject path-traversal entries in untrusted archives
- Import only after mandatory verification passes