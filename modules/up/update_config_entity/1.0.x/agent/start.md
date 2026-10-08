<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Update Config Entity (update_config_entity) — agent index

A developer repair tool. One Drush command removes a stale bundle entry from Drupal's
`entity.definitions.bundle_field_map` key-value store. Fixes the fatal *"A non-existent config
entity name returned by FieldStorageConfigInterface::getBundles()"* raised when the field map still
lists a bundle that no longer exists (deleted comment/content type, uninstalled module, failed
migration).

- **Dependencies:** none declared in `.info.yml`; needs **Drush** at runtime (the module's only surface is a Drush command). Core `^9.4 || ^10 || ^11`.
- **Configure route:** none — no settings page, no config object, no schema, no permissions.
- **Provides:** 1 Drush command. No hooks, plugins, services-for-others, routes, blocks, or events.

Solutions:
- **Repair the stale bundle field map / clear the getBundles() error** → [drush/commands.md](drush/commands.md)

Key facts:
- Drush service `update.commands` → `Drupal\update_config_entity\Commands\UpdateCommands` (extends `DrushCommands`), classic-style commandfile registered in `drush.services.yml` (tag `drush.command`), injecting the `@keyvalue` factory.
- Command **`update:correct-field-config-storage <entity_type> <bundle> <field_name>`** — no aliases, no options, no confirmation, no dry-run.
- Edits key-value collection `entity.definitions.bundle_field_map`.
