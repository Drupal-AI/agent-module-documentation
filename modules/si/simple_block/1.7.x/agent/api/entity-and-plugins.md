<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: config entity, block derivative & formatter

## The `simple_block` config entity

`\Drupal\simple_block\Entity\SimpleBlock` (`@ConfigEntityType`, `config_prefix: simple_block`):

- entity keys: `id` = `id`, `label` = `title`.
- `config_export`: `id`, `title`, `content`.
- `content` is a `text_format` array `['value' => …, 'format' => …]`; `getContent()` falls back
  to `['value' => '', 'format' => filter_default_format()]`.
- `calculateDependencies()` adds a config dependency on the block's filter format.
- `postSave()` clears the block plugin manager's cached definitions so the derivative updates.
- Handlers: access = `SimpleBlockAccessControlHandler`, list builder = `SimpleBlockListBuilder`,
  forms `add`/`edit` = `SimpleBlockEditForm`, `clone` = `SimpleBlockCloneForm`, `delete` =
  core `EntityDeleteForm`.

Load / create in code:

```php
$block = \Drupal\simple_block\Entity\SimpleBlock::load('promo_notice');
$block->getContent();            // ['value' => …, 'format' => …]
```

## Block plugin `simple_block` (derived per entity)

`\Drupal\simple_block\Plugin\Block\SimpleBlockBlock` with
`deriver = \Drupal\simple_block\Plugin\Derivative\SimpleBlock`, so every `simple_block` entity
yields a plugin id **`simple_block:<id>`** (admin label = the block title, category "Simple
block"). `build()` returns:

```php
[
  '#type' => 'processed_text',
  '#text' => \Drupal::token()->replace($content['value']),
  '#format' => $content['format'],
  '#contextual_links' => ['simple_block' => ['route_parameters' => ['simple_block' => $id]]],
];
```

`getCacheTags()` merges the block entity's and filter format's cache tags. If the entity is gone,
`build()` shows an admin-only "add simple block" message.

Check/enumerate derivatives:

```php
\Drupal::service('plugin.manager.block')->hasDefinition('simple_block:promo_notice'); // bool
```

## Field formatter `simple_block_rendered_entity`

`\Drupal\simple_block\Plugin\Field\FieldFormatter\SimpleBlockEntityReferenceFormatter`
(`@FieldFormatter id = "simple_block_rendered_entity"`, field type `entity_reference`). For each
referenced `simple_block` it renders the same `processed_text` (token-replaced, with the entity's
cache tags). Use it on an `entity_reference` field targeting `simple_block` to embed a block's
content inline via Manage display.

## Notes

- No new **plugin type** is defined — these are plugin *implementations* (a block + a formatter)
  plus one config entity type.
- Token replacement is **global** only (no entity context).
