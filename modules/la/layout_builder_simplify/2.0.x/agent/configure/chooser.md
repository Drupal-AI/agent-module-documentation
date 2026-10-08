<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Layout Builder Simplify chooser

## What changes
Enabling the module immediately alters the Layout Builder "Choose a block" screen everywhere. There is no settings form.

- `RouteSubscriber::alterRoutes()` re-points `layout_builder.choose_block` to `\Drupal\layout_builder_simplify\Controller\ChooseBlockController::build`, which lists block **categories** as links.
- Clicking a category opens `layout_builder_simplify.choose_individual_block` (`/layout_builder_simplify/choose/block/{section_storage_type}/{section_storage}/{delta}/{region}/{category}`) showing that category's blocks with a name filter and a "Back" link.
- The `Custom` category calls `getRecentContentBlocks()` (20 most-recently-changed content blocks) and attaches `layout_builder_simplify/search` for the autocomplete.

## Autocomplete endpoint
`POST /block-search.json` with body param `keyword` returns `[{title, uuid, type}]` matching `block_content_field_data.info LIKE %keyword%`. Requirement: `_permission: 'access content'`.

## Operating
- No config export/import artifacts are produced.
- Placement itself still routes through core `layout_builder.add_block`, so entity/block access is unchanged.
