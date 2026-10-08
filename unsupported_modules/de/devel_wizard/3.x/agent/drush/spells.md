<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Spells & Drush (devel_wizard)

## UI
- Overview: `/admin/devel-wizard-spell` (permission `devel_wizard.spell`).
- A spell form: `/admin/devel-wizard-spell/{spell}` — `{spell}` resolved by `devel_wizard:spell` param converter.
- Autocomplete JSON: `/devel-wizard/autocomplete/{library,module,theme,profile,extension-all,entity_type_id/{types},config_entity_instance/{entityTypeId}}`.

## Drush
Each spell has a matching Drush command (services tagged `drush.command` in `drush.services.yml`), e.g. node-type, block-content-type, taxonomy-vocabulary, entity-type, module, project-drupal-drush spells. Run the spell non-interactively from CI or a dev shell.

## Shell execution
`ProjectDrupalDrushSpell` and `SpellTraitPackageManager` build an argument **array** and run it through `ShellProcessFactory::createInstance($command, $cwd, $env)` → Symfony `Process::run()`. Because commands are arrays (not shell strings) there is no shell-metacharacter injection, but the tool does invoke `composer`/`drush`, so keep it dev-only.

## Writing a spell
Implement an `@DevelWizardSpell` plugin under `Plugin/DevelWizard/Spell/` (extend `SpellBase`); templates live in `templates/spell/`.
