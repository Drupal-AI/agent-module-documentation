<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group 2 to 3 upgrade (group2to3) — agent index

**Provides the update pipeline that migrates Group 2.x data and config to Group 3.x when you run `drush updb`.**

- **Version:** 3.0.x (dev-3.0.x checkout)
- **Core:** ^9 || ^10 || ^11
- **Depends on:** group:group
- **No routes / no permissions.** Work runs inside `hook_update_N` via the batch/update runner.
- **Services:** `group2to3.migrate.upgrade` (runs the ordered steps), `group2to3.migrate.entity_type`, `plugin.manager.step_migrate_group2to3` (step plugin manager).
- **Plugin type:** `@StepMigrateGroup2To3` (annotation `Drupal\group2to3\Annotation\StepMigrateGroup2To3`); core steps live in `src/Plugin/StepMigrateGroup2To3/`.
- **Submodule:** `group2to3_step_examples` (experimental, ^9||^10 example steps — not documented here).

**Security:** admin/operator-only; the migration executes with database-update privileges and exposes no web endpoints, no anonymous surface, and no user-supplied input. No security findings.

See [drush/upgrade.md](drush/upgrade.md).