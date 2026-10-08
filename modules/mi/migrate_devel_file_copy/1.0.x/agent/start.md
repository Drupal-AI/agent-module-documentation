<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Devel FileCopy (migrate_devel_file_copy) — agent index
**A migrate process plugin `file_copy_or_generate` that works like core `file_copy` but generates a placeholder image/text file when the source file is missing.**

**Version:** 1.0.x  ·  **Core:** ^8.9 || ^9 || ^10 || ^11  ·  **Package:** Migration
- **Plugin:** `@MigrateProcessPlugin(id = "file_copy_or_generate")` → `Drupal\migrate_devel_file_copy\Plugin\migrate\process\FileCopyOrGenerate` (extends core `FileCopy`).
- **Fallback:** on a "File … does not exist" `MigrateException` (or non-local source) it returns an existing destination, else generates a `Random::image()` for jpg/jpeg/gif/png/bmp or a 4-char text file otherwise, via `FileSystem::prepareDirectory`/`move`.
- **Surface:** no routes, controllers, forms, services, permissions or config — used only from migration YAML (CLI/migrate runtime).
- **Security:** no web-facing surface. Source/destination paths come from developer-authored migration definitions, not request input; writes use core FileSystem APIs. No attacker-controlled path-traversal/arbitrary-write vector. Development/testing aid only. No security findings.

See [plugins/migrate_devel_file_copy.md](plugins/migrate_devel_file_copy.md)
