<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set Author — agent index

One import processor plugin for **Entity Share Client**. As an entity is imported from a remote
site, it resolves and sets the local author (`uid`). No admin page (`configure` null), no
permissions, no config schema, no Drush, no submodules. Depends on
`entity_share:entity_share_client` (`drupal/entity_share ^3.0`); Drupal 10/11.

- **The `set_author` processor: settings (`shared_author`, `create_author`), author-resolution order,
  stage/weight, and how to enable it on an import config** → [configure/processor.md](configure/processor.md)

Key facts:
- Single class: `src/Plugin/EntityShareClient/Processor/SetAuthor.php`
  (`@ImportProcessor id = "set_author"`, stage `process_entity` weight `110`, `locked = false`).
- Configured **per import config** in the Entity Share Client processor settings, not a global form.
- Resolution order for the imported `uid`: local UUID match → remote lookup by email → by username →
  (optional) create local user → configured `shared_author` fallback (anonymous by default).
- `set_author.install`: `set_author_update_8001()` renames the legacy `set_node_author` setting key to
  `set_author` on existing `import_config` entities.
