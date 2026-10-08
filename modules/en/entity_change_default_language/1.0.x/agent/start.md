<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Change Default Language — agent index

Developer/CLI utility to change which translation is the *default (original) language* of a
translatable content entity, optionally creating the target translation and pruning others. No routes,
permissions, config, or UI.

- **The `entity_change_default_language` service & `update()` semantics** → [api/service.md](api/service.md)
- **Drush commands (`ecdl:cdl`, `ecdl:dlet`) + the queue worker** → [drush/commands.md](drush/commands.md)

Key facts:
- Service id `entity_change_default_language` (`EntityChangeDefaultLanguageInterface::update()`).
- Saves with `setSyncing(TRUE)` and no new revision; recurses into `entity_reference` /
  `entity_reference_revisions` fields.
- Drush: `ecdl:cdl <type> <id> <langcode>` (single, interactive confirm);
  `ecdl:dlet <type> <langcode> [--bundle]` (whole entity type → enqueues onto the
  `entity_change_default_language` queue, run on cron).
