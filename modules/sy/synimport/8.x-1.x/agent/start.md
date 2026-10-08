<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SynImport (synimport) — agent index
**Drush-only import/export of Drupal content (nodes, commerce products, taxonomy, menus, blocks, media) to/from a directory of structured YAML files.**

- **Version:** 8.x-1.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Dependencies:** idna
- **Interface:** Drush commands only (`drush.services.yml` → `SynimportCommands`); no routes, no permissions, no config forms.
- **Key commands:** `synimport`, `synimport:{contact,node,menu,taxonomy,product,block,synlanding_config}`, `synexport`, `synexport:{node,product,taxonomy}`.
- **Services:** `synimport.import`, `synimport.export`, `synimport.import.files`, `synimport.import.redis`, `synimport.log`.
- **Security:** CLI/Drush-only; no web-exposed routes or permissions. Import sources are operator-supplied files and are treated as trusted. Notes: `src/Service/Import/Files.php` uses `@file_get_contents()` on any `http`-prefixed field value (remote fetch from import data); `src/Service/Import/Redis.php` contains a hardcoded salt and fetches from hardcoded external hosts.

See [drush/commands.md](drush/commands.md)
