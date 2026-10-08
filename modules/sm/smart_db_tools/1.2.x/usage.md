<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Smart DB Tools is an enhanced command-line DbTools application whose dump command can write a database export as one PHP script per table instead of a single monolithic file.
---
Drupal core's `db-tools.php` exports a whole database to a single PHP fixture script, which is slow and noisy to review when only a few tables changed. Smart DB Tools subclasses core's `DbToolsApplication` and replaces its `DbDumpCommand` with `SmartDbDumpCommand`, adding a `--split-destination` option that generates a directory of per-table PHP scripts (each table in its own file, wired together with `include` statements). To keep memory bounded, tables with more than `--subsplit-limit` (default 1000) rows are further split into paged sub-files. Extra options control the generator comment (`--no-generator-comment`, `--file-comment`).

This is a developer/testing tool run exclusively from the CLI: `scripts/smart-db-tools.php` bootstraps Drupal and refuses to run under any non-CLI SAPI (`if (PHP_SAPI !== 'cli') return;`). It defines no routes, permissions, services, forms or configuration — there is no web-facing surface. The dump reads table data with `SELECT * FROM {table}` where the table name comes from the schema's own table list (not user input) and paging uses integer-cast limits, so there is no request-driven SQL injection vector. Setup: run the script from the site root, e.g. `php modules/contrib/smart_db_tools/scripts/smart-db-tools.php dump --database <conn> --split-destination path/to/db-dump.php`.
---
- Dump a database to per-table PHP scripts instead of one file.
- Reduce noise in fixture diffs by isolating each table's export.
- Split large tables into paged sub-files to bound memory use.
- Tune the sub-split threshold with `--subsplit-limit`.
- Disable sub-splitting by setting the limit below 1.
- Export selected tables as schema-only via `--schema-only`.
- Omit the generator comment with `--no-generator-comment`.
- Add a custom file comment with `--file-comment`.
- Generate importable fixtures for kernel/functional tests.
- Regenerate a changed fixture quickly by re-dumping.
- Run backward-compatibly as a drop-in for core's db-tools dump.
- Point the dump at a specific database connection with `--database`.
- Keep exports reviewable in version control per table.
- Bootstrap Drupal from the CLI to access the live schema.
- Use it as a drop-in replacement for core's single-file db-tools dump.
