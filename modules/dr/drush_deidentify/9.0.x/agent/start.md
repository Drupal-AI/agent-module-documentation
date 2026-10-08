<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush De-Identify (drush_deidentify) — agent index
**Drush commands to export a (cache-stripped) DB dump and to Faker-clean sensitive `table~column` values.**

- **Version:** 9.0.x
- **Core:** ^8 || ^9 || ^10 — CLI/Drush only, no routes, no permissions.
- **Service:** `drush_deidentify.commands` (`DrushDeidentifyCommands`, args `@database`, `@module_handler`).
- **Commands:** `drush_deidentify:db-export` (`ice-export`, options `--result-file`, `--gzip`, `--omit_tables`); `drush_deidentify:db-clean` (`ice-clean <table~column,...>`).
- **Extension point:** `hook_drush_deidentify_export(&$default_tables)`.
- **Security:** no HTTP surface; operates via Drush over `@database`/`SqlBase`. Treat exported dumps as sensitive until de-identified. No web-exploitable findings.

See [drush/commands.md](drush/commands.md).
