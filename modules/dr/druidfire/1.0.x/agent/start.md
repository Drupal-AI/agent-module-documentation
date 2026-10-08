<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Druidfire (druidfire) — agent index

Drush commands + a PHP service API that **alter existing entity field definitions in place**:
resize a field's max length, or convert its type (string→formatted, ERR→ER, ERR→Bricks,
string→taxonomy reference). Each operation rewrites the SQL storage schema, the `field.storage`/
`field` config and the form/view display config, then clears cached entity definitions. Package
`Development`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0.

**No admin UI, no config form, no permissions, no routes, no config schema, no hooks.** It runs
only from the CLI (Drush) or PHP — a developer/DevOps tool. Reshaping field storage is inherently
**destructive** (can drop columns/data): run as a trusted developer, test first, back up the DB.

- Requirements: Drupal core only (no `dependencies` in `druidfire.info.yml`, no `composer.json`).
  `err2bricks` needs the contrib **Bricks** field type present; ERR spells assume ERR fields
  (Paragraphs); `string2taxonomyReference` needs core Taxonomy. These are runtime assumptions of
  individual spells, not declared module dependencies.

## Solution docs

- **The `Spell` plugin type + how a transformation runs + writing your own** →
  [plugins/spell-type.md](plugins/spell-type.md)
- **The five shipped spells and exactly what each transforms** →
  [plugins/shipped-spells.md](plugins/shipped-spells.md)
- **The `druidfire` service, `FieldInspector`, `ConfigManager`, and the Drush commands** →
  [api/service-and-drush.md](api/service-and-drush.md)

## What it provides (from source)

- Plugin type **`Spell`** — manager `Drupal\druidfire\SpellManager` (`src/SpellManager.php`, service
  `plugin.manager.druidfire_spell`), annotation `Drupal\druidfire\Annotation\Spell`, interface
  `SpellInterface`, base `SpellBase`. Discovered in `Plugin/Spell`, alter hook
  `druidfire_spell_info`. (Note: `src/Plugin/SpellManager.php` is an unwired duplicate — the
  services file uses the top-level `SpellManager`.)
- Services (`druidfire.services.yml`): `druidfire` (`Drupal\druidfire\Druidfire`),
  `druidfire.field_inspector` (`FieldInspector`), `druidfire.config_manager` (`ConfigManager`),
  `plugin.manager.druidfire_spell`.
- Drush commands (`drush.services.yml` → `DruidfireCommands`): `druidfire:resize`,
  `druidfire:string2formatted`, `druidfire:err2er`, `druidfire:err2bricks`,
  `druidfire:string2taxonomyreference`, `druidfire:list-spells` (alias `druidfire:ls`).
- Shipped spells (`src/Plugin/Spell/`): `resize`, `string2formatted`, `err2er`, `err2bricks`,
  `string2taxonomyReference`.
