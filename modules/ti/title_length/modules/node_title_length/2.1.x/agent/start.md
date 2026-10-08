# Node title length — agent index

The `title_length` submodule that widens the **node `title`** column above 255 (default 500).
Depends on `node` + `title_length`. No UI, no config object, no permissions.

- **The `node_title_length.node` service, settings override, install/uninstall behavior** →
  [api/node.md](api/node.md)

Key facts:
- Class `Drupal\node_title_length\NodeTitleLength extends EntityTitleLength`; entity type `node`,
  title field `title`. Service id: `node_title_length.node`.
- Default length **500** (`EntityTitleLengthInterface::DEFAULT_LENGTH`); original 255.
- Override before/after install: `$settings['node_title_length_chars'] = <n>;` in `settings.php`.
- Re-apply after a change: `drush title_length:update node` (command lives in the parent).
- Effect lives in the DB schema: `node_field_data.title` / `node_field_revision.title` become
  `varchar(<length>)`; a `hook_entity_base_field_info_alter()` sets the base-field `max_length`.
- Uninstall shrinks back to 255 but throws if any node/revision title already exceeds 255.
- Shared machinery (abstract service, Drush command, the `changeLength()` internals) is in the
  parent: [../../../../2.1.x/agent/start.md](../../../../2.1.x/agent/start.md).
