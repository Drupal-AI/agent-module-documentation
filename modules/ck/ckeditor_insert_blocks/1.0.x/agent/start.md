<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Insert Blocks (ckeditor_insert_blocks) — agent index

A CKEditor 5 toolbar dropdown that inserts a **Drupal block** (custom module block, views block,
or content block) into body content. Version **1.0.3**, core `^10 || ^11 || ^12`, package "CKEditor 5".
Depends on core `ckeditor5`; the display-time filter additionally needs `symfony/dom-crawler` on
Drupal 10/11/12 (already in core on Drupal 9).

## What it actually does (read the mechanism before reasoning about it)

1. **Editor plugin** — a dropdown button (`insertBlocks`) added to a text format's CKEditor 5 toolbar.
   Its per-format settings form (`InsertBlockSettings`, a `CKEditor5PluginConfigurable`) is a
   checkboxes list of block plugin definitions; **an empty selection offers every block on the site.**
2. **Insert-time fetch** — picking a block calls the route
   `/get-block-content/{block_id}` → `InsertBlockController::showBlockContent()`, which renders that
   block and returns its HTML. The JS wraps it as
   `<div class="insert-block" data-block-id="PLUGIN_ID">…rendered HTML…</div>` and inserts it. A
   balloon form can add an HTML class and a comma-separated `data-library` list.
3. **What is stored** — that div (rendered snapshot **plus** the `data-block-id` marker) is saved in
   the field, through the text format's normal filters (e.g. `filter_html`).
4. **Display-time re-render** — the `insert_block` filter (`InsertBlockFilter`, must be enabled on
   the format) uses a `symfony/dom-crawler` XPath sweep for `div.insert-block[data-block-id]`, and
   **re-renders each referenced block server-side against the viewing user** via the block's own
   `access()`, replacing the div body and attaching `data-library` assets with `renderInIsolation()`.
   The stored text never changes; the filter reconstructs current block output on each render.

So this is a **placeholder-resolved-server-side** model (not static admin HTML): the body carries a
block reference, resolved to live block output per request when the filter is on. With the filter
**off**, only the insert-time snapshot is shown (see the solution-type notes).

## Why the gate matters more than a normal WYSIWYG button

- A block renders **arbitrary markup and can attach JavaScript libraries**, so placing any block into
  body text is closer to a **site-building** capability than an editing one.
- A **views block runs a view inline**, with its own access and filters — so embedded results
  **vary by viewer**, and the host content's cache metadata must account for that.
- **Which blocks the button offers is the real control.** An unrestricted (empty) list = every block
  on the site; a curated per-format list is a far smaller grant. **Check that first.**

Grant it to people who would otherwise place blocks in block layout. Compare **`ck5_block_embed`**,
which does the same job behind an explicit permission.

## Files
- `agent/editor/toolbar-and-insertion.md` — enabling the button, per-format block list, insert flow, the JS.
- `agent/config/filter-and-rendering.md` — the `insert_block` filter, `symfony/dom-crawler`, the route/controller, caching.

## Provides
- CKEditor 5 plugin `InsertBlocks` (toolbar item `InsertBlocks`, PHP `InsertBlockSettings`).
- Text-format filter `insert_block` (`TYPE_TRANSFORM_IRREVERSIBLE`).
- Route `ckeditor_insert_blocks.get_block_content` at `/get-block-content/{block_id}` (`_permission: access content`).
- Config schema `ckeditor5.plugin.ckeditor_insert_blocks_blocks` (a `blocks` sequence).
- No permissions of its own, no Drush commands, no submodules.
