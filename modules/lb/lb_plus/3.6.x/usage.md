<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder + replaces core's Layout Builder editing interface with a drag-and-drop, tool-and-sidebar UI and adds nested sections.

---

Core Layout Builder is capable, but its editing UI is what people complain about: every operation is a modal, sections cannot contain sections, and moving a block means a dialog rather than a drag. Layout Builder + swaps that interface for a set of Photoshop-like tools — Place block (`b`), Move (`m`), Layout (`l`), Configure (`o`), Duplicate (`d`) and Remove (`t`) — driven from a left-hand block palette. These tools are navigation_plus "Edit Mode" plugins, and each maps to an AJAX route under `/lb-plus/…` that mutates the section storage in the shared Layout Builder tempstore.

The substantive addition is **nested sections**: a Layout Block (an inline block type whose display itself uses Layout Builder) can contain its own sections, so you can build columns inside a row inside a full-width band without writing a custom layout plugin per arrangement. A tree index over the whole nested structure lets any block or section be addressed by a stable UUID, and blocks (with their nested content) can be duplicated or moved between nesting levels in place.

Adoption is a stack decision. It requires `navigation_plus` and `tempstore_plus` and shares navigation_plus's settings route (UI colours live there), so you are adopting a small family of modules that jointly replace parts of the editing experience. The top-level project is Drupal `^11` only — no Drupal 10 path. Access on the editing routes uses core's own `_layout_builder_access: 'view'`, the same requirement core Layout Builder carries, so authority comes from the entity's layout access rather than a new permission. Its two own permissions are `administer layout builder + configuration` and `promote layout builder + blocks`.

Three submodules ship with it: `lb_plus_section_library` (save and reuse sections/pages as templates), `lb_plus_lb_block_decorator` (nested-layout support for Layout Builder Block Decorator), and the deprecated `lb_plus_edit_plus`, which exists only so a database update can uninstall it.

---

- Replace the Layout Builder editing UI with drag-and-drop tools.
- Place blocks from a left-hand sidebar instead of a modal.
- Promote frequently-used blocks so editors find them first.
- Nest sections inside sections via Layout Blocks.
- Build a column arrangement inside a full-width band without a custom layout.
- Move a block between sections — or into a nested layout — by dragging.
- Duplicate a block (and its nested content) in place.
- Add an empty section quickly, then pick its layout.
- Change a section's layout options in place.
- Configure a default section and default block config per display.
- Give content editors a faster page-building experience.
- Track inline blocks and their usage, including nested ones.
- Preserve chosen fields when editing a display.
- Save a page or section to a reusable Section Library template.
- Drag a saved template back into any layout.
- Add nested-layout styling support via Layout Builder Block Decorator.
- Restrict who may administer LB+ configuration.
- Restrict who may promote blocks.
- Plan a Drupal 11-only page-building stack around the +Suite modules.
- Uninstall the deprecated `lb_plus_edit_plus` submodule via database updates.
