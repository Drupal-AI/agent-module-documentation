<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate generator (migrate_generator) — agent index

**Generates `migrate_plus` migration configs from source CSV files, driven by Drush; companion submodule exports content back to CSV.**

- **Version:** 8.x-2.x  •  core: `^9 || ^10 || ^11`  •  package: Migration
- **Depends on:** `migrate`, `migrate_plus:migrate_plus`, `migrate_source_csv:migrate_source_csv`, `migrate_skip_on_404:migrate_skip_on_404`.
- **Drush:** `migrate_generator:generate_migrations <dir> [--pattern --delimiter --enclosure --values_delimiter --date_format --relative_filepath --update --tag]`.
- **Services:** `migrate_generator.scanner` (Scanner), `migrate_generator.generator` (Generator), `plugin.manager.migrate_generator.process` (GeneratorProcessPlugin manager). CSV names: `{entity_type}-{bundle}.csv`.
- **Submodule `migrate_generator_export`:** routes `/admin/content/migrate-generator-export` (+ `/download/{uri}`) gated by perm *access csv export* (`restrict access: true`); config entity `entity_type_export_config` at `/admin/config/content/migrate-generator-export`.

**Security:** the base module is **Drush/CLI-only — no routes, permissions, forms or config** — so there is no web route letting a non-admin run/generate migrations. The export submodule's routes are all permission-gated (*access csv export*, restricted); its download controller validates a CSRF token, or a `state`-stored token via `hash_equals` for Drush downloads (`migrate_generator_export/src/Controller/ExportController.php:83,88`), before streaming a `temporary://` file. No raw SQL / TLS-disable / unverified callbacks observed.

See [drush/migrate-generator.md](drush/migrate-generator.md)
