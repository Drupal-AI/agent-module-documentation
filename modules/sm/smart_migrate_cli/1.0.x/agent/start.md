<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart Migrate CLI (smart_migrate_cli) — agent index
**Enhanced, multi-threaded Drush replacements for core `migrate:*` commands.**

- **Version:** 1.0.x (info.yml `1.0.0-alpha14`)
- **Core:** ^9 || ^10 || ^11 ; requires Drush ^11
- **Surface:** Drush commands only — no routes, no permissions, no config UI.
- **Key services:** `smart_migrate_cli.commands`, `migrate_runner.commands` (drush.command tags); `smart_migrate_cli.migrate_mail_overrider` (config override); `cache.backend.smc_null`.
- **Submodule:** `smart_migrate_fixes` (migration definition helpers).
- **Security:** CLI-only; no HTTP surface. Access is limited to operators with Drush/shell access; runs migrations via `account_switcher`. No anonymous or mutating web endpoints.

See [drush/commands.md](drush/commands.md)
