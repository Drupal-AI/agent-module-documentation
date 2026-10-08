<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simpsons sample data (Drush + recipe)

Optional testing aids for exercising a node-to-CRM migration with realistic content. Neither is
required to use the migration UI.

## Recipe: `crm_migrate_node_simpsons`
`recipes/crm_migrate_node_simpsons/recipe.yml` (type "Sample Data") installs
`crm_migrate_node`, `name`, `telephone`, `address`, then applies bundled config that defines three
node types — **person**, **organization**, **household** — with fields (`field_name`, `field_email`,
`field_telephone`, `field_address`, `field_first_name`, `field_last_name`, `field_preferred_name`,
`field_aliases`, etc.) and their form/view displays, plus ready-made node **content** YAML under
`content/node/*.yml`. Apply it with core's recipe runner
(`php core/scripts/drupal recipe recipes/crm_migrate_node_simpsons`) to get sample nodes you can then
migrate into CRM.

## Drush command: `Commands\CrmMigrateNodeCommands`
Registered in `drush.services.yml` as `crm_migrate_node.commands` (autowired; constructor args
`@extension.path.resolver`, `%app.root%`).

- **Command:** `crm-migrate-node:generate-simpsons-recipe` (**alias `cmnsr`**).
- **Options:** `--csv-path` (default: the CRM module's `tests/simpsons/contact.csv`),
  `--output-dir` (default: the recipe's `content` dir).
- **Effect:** `doGenerate()` clears existing `node/*.yml` in the output dir, reads the CSV
  (`readCsv()`), and writes one recipe content YAML per row (`createNodeYaml()` +
  `writeYaml()`/`arrayToYaml()`). It is a **content-generation / CLI authoring** tool — it rewrites
  files inside the module's `recipes/` tree, it does not import anything into the running site.

Row handling: `contact_type` selects the node bundle; `person` rows parse a full name into
title/given/middle/family (`parseFullName()`, splitting on spaces when explicit first/last aren't
given) and set name, first/last, preferred name, aliases; email/phone/address fields are populated
when present; `status` is coerced with `FILTER_VALIDATE_BOOLEAN`. UUIDs come from the CSV `uuid`
column or a deterministic v5 UUID (`generateUuid()` over namespace
`6ba7b810-9dad-11d1-80b4-00c04fd430c8`), so regenerating is stable.

Typical flow: `drush cmnsr` to (re)generate content YAML → apply the recipe → build a
person→person migration in the UI → `drush migrate:import <id>`.
