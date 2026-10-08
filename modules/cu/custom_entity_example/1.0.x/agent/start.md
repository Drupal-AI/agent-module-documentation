<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# custom_entity_example — agent orientation

Reference module: a full custom content entity type (`custom_entity_example`) + config-entity bundle + a Drush scaffolding command.

- Admin perm `administer custom_entity_example`; entity-access driven. Bundle-granular perms via Entity API.
- Drush codegen `replaceInFile()` does local file `str_replace` (scaffolding), not a web route — no runtime web surface.
- Collection at `entity.custom_entity_example.collection`. Sound; developer boilerplate.
- Read: `src/`, `drush.services.yml`.
