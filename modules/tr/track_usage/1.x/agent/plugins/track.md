<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types: Track & BlockTarget

The module defines two plugin types. Both are discovered by PHP attribute.

## Track plugins

- **Namespace** `Plugin/TrackUsage/Track`; **attribute** `Drupal\track_usage\Attribute\Track`
  (`id`, `label`, `fieldTypes[]`); **interface** `TrackPluginInterface`
  (`getTargetEntities(FieldItemListInterface $itemList): iterable`); **base**
  `TrackPluginBase` (de-duplicates, delegates to abstract `getItemTargetEntities($item)`);
  **manager** `TrackPluginManager` (`Drupal\track_usage\Plugin\TrackUsage\TrackPluginManagerInterface`,
  cache `track_usage.track_plugins`, alter hook `file_track_usage_info`).
- A plugin declares the **field types** it can read (`fieldTypes`). `Tracker` only descends fields
  whose type is claimed by an *enabled* plugin (`getApplicableFieldTypes()`), then runs each
  applicable plugin (`getApplicablePlugins($fieldType)`). Enabled set = a config's `trackPlugins`,
  or all plugins if that is empty.
- Returned entities are then classified by the config as target (recorded) and/or traversable
  (recursed into) — see [../api/services.md](../api/services.md).

Shipped Track plugins (`src/Plugin/TrackUsage/Track/`), id — field types:

- `entity_reference` — `entity_reference`, `entity_reference_revisions`,
  `entity_reference_entity_modify`, `file`, `image`, `webform` (loads the referenced entity).
- `dynamic_entity_reference` — dynamic entity reference fields.
- `link` — core `link` fields (resolves the URI to an entity via the guesser).
- `html_link` — `text`, `text_long`, `text_with_summary`: parses `<a href>` in rich text (running
  the `filter_url` filter first if the format enables it) and resolves each href through
  `EntityGuesser`.
- `linkit` — Linkit-authored links in text fields.
- `entity_embed` — `<drupal-entity>` embeds in text.
- `media_embed` — `<drupal-media>` embeds in text.
- `ckeditor_image` — `<img>` in text, resolved to file entities.
- `comment` — the commented entity (paired with the `comment_insert` hook).
- `block_field` — entities referenced by a block placed in a Block Field.
- `layout_builder` — entities referenced by blocks in a Layout Builder layout.

Text-parsing plugins extend `TextFieldBase` (xpath over parsed HTML). `EntityReference` and
`html_link` are representative: they yield only entities that actually load, never raw
request/markup strings.

## BlockTarget plugins

- **Namespace** `Plugin/TrackUsage/BlockTarget`; **attribute**
  `Drupal\track_usage\Attribute\BlockTarget` (`id`, `label`, `blockPlugins[]` — the block plugin
  base IDs it handles); **interface** `BlockTargetPluginInterface`
  (`getTargetEntities(BlockPluginInterface $block): iterable`, yielding entity-type → ID lists);
  **base** `BlockTargetPluginBase`; **manager** `BlockTargetPluginManager`.
- Purpose: extract referenced entities out of a **block plugin instance**, so the `block_field`
  and `layout_builder` Track plugins can reach entities embedded via blocks.

Shipped BlockTarget plugins (`src/Plugin/TrackUsage/BlockTarget/`): `block_content` (Block Content
custom blocks), `inline_block` (Layout Builder inline blocks), `entity_browser_block` (Entity
Browser Block — requires the `entity_browser_block` module).

## Extending

Add a Track plugin by placing an attribute-annotated class under your module's
`src/Plugin/TrackUsage/Track/` extending `TrackPluginBase` and implementing
`getItemTargetEntities()`. Add a BlockTarget plugin the same way under
`src/Plugin/TrackUsage/BlockTarget/`. For URL-to-entity resolution the guesser cannot handle,
implement `hook_track_usage_entity_guess()` instead (`track_usage.api.php`).
