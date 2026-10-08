<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Packages Drush commands

All functionality is CLI-only (no web routes). Commands are defined in `src/Commands/ContentPackagesCommands.php`.

| Command | Purpose |
|---|---|
| `content-packages:validate <source>` | Validate a package source against a package type (`--package-type`, default `node_markdown_body`). |
| `content-packages:import ...` | Import package(s) from a source (supports scheduling options). |
| `content-packages:export ...` | Export content to Markdown package files. |
| `content-packages:archive:export ...` | Export a full archive (content + assets + manifest). |
| `content-packages:archive:verify <archive>` | Verify an archive's integrity, references and structure. |
| `content-packages:archive:import <archive>` | Import an archive — always verifies first; supports dry-run/strict. |
| `content-packages:diff <source>` | Diff on-disk packages against current site content. |
| `content-packages:assets:cleanup` | Remove orphaned package assets (`--delete`). |

## Safety design
- **Import always verifies:** `ContentPackageArchiveImporter::importArchive()` runs `archiveVerifier->verify()` before any write; there is no verify bypass.
- **Path safety:** `ContentPackageArchiveReader::normalizePath()` rejects absolute paths, `..` segments, and null bytes; duplicate/unsafe entries are logged and skipped.
- **Zip-bomb guard:** per-entry and total-uncompressed caps (from the PHP memory limit) are enforced before extracting into a temp tree.
- **Package type plugins** (`ContentPackageType`) decide how each entity type is serialised; `node_markdown_body` stores the node body as canonical, HTML-stripped Markdown.
