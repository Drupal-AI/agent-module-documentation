<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field as Block — agent index

One block plugin (`fieldblock`) + a deriver → `fieldblock:<entity_type>` blocks that render a
field of the entity on the current route. Depends on core `block`.

- **Which entity types get field blocks (`fieldblock.settings`), the config form, permission,
  orphan cleanup** → [configure/entity-types.md](configure/entity-types.md)
- **Place a field block and set its field / formatter (UI + config + PHP)** →
  [configure/place-a-field-block.md](configure/place-a-field-block.md)
- **How the block finds the entity, when it is hidden, cache metadata, dependencies** →
  [api/block-behavior.md](api/block-behavior.md)

Key facts:

- Plugin id `fieldblock`, deriver `Drupal\fieldblock\Plugin\Derivative\FieldBlockDeriver`;
  derivative ids are `fieldblock:node`, `fieldblock:user`, `fieldblock:taxonomy_term` by default.
- Block settings: `label_from_field` (bool, default TRUE), `field_name`, `formatter_id`,
  `formatter_settings` — stored on the normal `block.block.<id>` config entity.
- Config object `fieldblock.settings` has one key, `enabled_entity_types` (sequence). **It does
  not exist until the settings form is saved**; the fallback default is `node`, `user`,
  `taxonomy_term`.
- Configure route `fieldblock.field_block_config_form` → `/admin/config/fieldblock/fieldblockconfig`,
  permission `administer fieldblock`.
- Service `fieldblock.block_storage` (`Drupal\fieldblock\BlockEntityStorage`) — helper storage for
  loading/deleting the blocks this module created.
- No Drush commands, no new plugin *types*, no hooks of its own.
