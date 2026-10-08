<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Section-Block Clone (layout_builder_section_block_duplicate) — agent index

Adds two "clone" actions to the Layout Builder editing UI. **Clone section** duplicates a whole
section, with every component and setting, and inserts the copy directly below the original. **Clone
block** duplicates a single component, letting the editor choose the destination section/region and
the new block's weight. The section link is a GET Ajax link injected next to each section's
"Configure" control through a `#pre_render` alter on the `layout_builder` render element; the block
action is a contextual link that opens an off-canvas form. Inline (content) blocks are deep-copied —
the code calls `createDuplicate()` + `enforceIsNew()` + `save()` and mints fresh UUIDs, so a cloned
inline block is an independent `block_content` entity rather than a second reference to the same one.

All edits are staged in the Layout Builder tempstore (`layout_builder.tempstore_repository`) and
become permanent when the editor clicks **Save layout** — the one exception is duplicated inline
blocks, which are `save()`d to the database at clone time.

- Depends on: `drupal:layout_builder` (core).
- Core: `^10 || ^11`. Package: `Layout Builder`.
- No settings page / `configure` route, no permissions of its own, no drush, no config schema, no
  plugin types. One service (`…hook_manager`), two routes, one library, one contextual link.
- Access is delegated to Layout Builder. The block route uses `_layout_builder_access: 'view'` — the
  same requirement core puts on its own update/remove/move-block routes. The section route uses
  `_permission: 'administer node layout'` (a plain permission string). See
  [api/routes.md](api/routes.md) for the exact requirements and a behavior note about that permission.

## What you'd do → where

- **Understand the two routes, their access, and the controller/form that back them** →
  [api/routes.md](api/routes.md)
- **See how the clone links are injected into the Layout Builder UI (render alter + contextual link)** →
  [api/routes.md](api/routes.md)

## Key facts (real machine names)

- Routes: `layout_builder_section_block_duplicate.clone_section`
  (`/layout-builder-clone/clone/{section_storage_type}/{section_storage}/{delta}`, controller
  `Drupal\layout_builder_section_block_duplicate\Controller\CloneSectionController::clone`);
  `layout_builder_section_block_duplicate.clone_block`
  (`/layout-builder-clone/clone-block/{section_storage_type}/{section_storage}/{delta}/{region}/{uuid}`,
  form `Drupal\layout_builder_section_block_duplicate\Form\CloneBlockForm`, title callback
  `CloneBlockForm::title`).
- Form id: `layout_builder_section_block_duplicate_block_clone`.
- Service: `layout_builder_section_block_duplicate.hook_manager`
  (`Hook\BlockDuplicateHooks`) — backs the two thin `.module` hook wrappers.
- Hooks: `hook_page_attachments` (attaches the CSS library), `hook_element_info_alter` (appends the
  `#pre_render` callback to the core `layout_builder` element).
- Pre-render callback: `LayoutBuilderAlter::addCustomLink` (`TrustedCallbackInterface`) — renders the
  "Clone section N" off-canvas link.
- Contextual link: `layout_builder_section_block_duplicate.clone_block` (group `layout_builder_block`).
- Library: `layout_builder_section_block_duplicate/layout_builder_section_block_duplicate_css`
  (`css/layout-builder-clone.css`); icon `icons/clone.svg`.
- Core services used: `layout_builder.tempstore_repository`, `uuid`, `entity_type.manager`.
- Optional soft integration: `gin_lb` (swaps the link CSS class when the Gin Layout Builder module
  is present).
