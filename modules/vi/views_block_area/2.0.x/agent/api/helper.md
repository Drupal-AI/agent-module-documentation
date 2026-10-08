<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The render helper service & block support

## Service

`views_block_area.creation_helper` → `Drupal\views_block_area\ViewsBlockCreationHelper`
(args: `plugin.manager.block`, `renderer`, `module_handler`, `string_translation`, `current_user`,
`entity.repository`). Both Views handlers call it for `defineOptions()`, `buildOptionsForm()`,
`adminSummary()`, and `render()`.

## What `render()` does

1. Instantiate the block plugin from `block_id` via `BlockManager::createInstance()`.
2. Return **NULL** if the block is missing/broken or the current user lacks access
   (`$block->access($currentUser)`).
3. Build the block, then render it through the standard `#theme => 'block'` element (mirrors
   `BlockViewBuilder`), applying `block_title` and `hide_label`.
4. Invoke `hook_block_view_alter()` / `hook_block_view_BASE_alter()` and add the block as a cacheable
   dependency.

## Block support / limitations (`getBlockDefinitions()` + `getBlock()`)

- **Context-aware blocks are excluded** — any block definition with a non-empty `context` is filtered
  out of the selectable list (a view can't provide that runtime context).
- A `broken` block plugin returns NULL.
- For a `block_content` derivative, the referenced content block entity is loaded by UUID via
  `entity.repository`; if it no longer exists, `getBlock()` returns NULL (renders nothing).

There is no other public API; interact with the module through the two Views handlers and their
`block_id` / `block_title` / `hide_label` / `empty` options.
