<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Devel Wizard (devel_wizard) — agent index

**Generates Drupal boilerplate (modules, entity/content/block/taxonomy types, plugins, controllers, tests, Drush projects) from interactive "spell" forms and Drush commands.**

- **Version:** 3.x · **Core:** ^11.0 · **Depends on:** config
- **Routes:** `devel_wizard.spell_list` → `/admin/devel-wizard-spell`; per-spell form `/admin/devel-wizard-spell/{spell}`; `/devel-wizard/autocomplete/*` JSON endpoints; settings at `/admin/config/development/devel-wizard-settings`.
- **Permissions:** `devel_wizard.spell` and `devel_wizard.settings.admin` — both `restrict access: true`.
- **Services:** `plugin.manager.devel_wizard.spell`, `devel_wizard.shell_process_factory` (Symfony Process), `devel_wizard.utils`.
- **Shell exec:** package/Drush spells run `composer`/`drush` via `ShellProcessFactory::createInstance()` (array-form command, no shell interpolation) — `SpellTraitPackageManager.php:102`, `ProjectDrupalDrushSpell.php:410`.
- **Security:** entire surface is admin/developer-only behind restricted permissions; it executes shell processes by design, so treat as a dev-only tool and never enable on production. No anonymous endpoints.

See [drush/spells.md](drush/spells.md)
