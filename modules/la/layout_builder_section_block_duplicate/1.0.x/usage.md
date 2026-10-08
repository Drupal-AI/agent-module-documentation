<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Section-Block Clone adds Clone actions to the Layout Builder editing UI so editors can duplicate a whole section or a single block instead of rebuilding it by hand.

---

Install it like any module — `composer require drupal/layout_builder_section_block_duplicate` then enable it (`drush en layout_builder_section_block_duplicate`) — and it works immediately with **no configuration page and no settings**; it only needs core **Layout Builder** enabled for the entity types whose layouts you edit. Once on, open a layout in Layout Builder and two new controls appear: a **Clone section** link sits beside each section's *Configure* control and, when clicked, drops an exact copy of that section — with every block, region assignment and setting — directly below the original; a **Clone block** contextual link on each block opens an off-canvas form where you choose the destination section and region, order the blocks with a draggable weight table, and press **Clone**. Both controls appear only inside the Layout Builder editing UI, so they follow the same permissions that let a user edit that layout in the first place. Changes are staged in the Layout Builder tempstore, so nothing is permanent until you press **Save layout** — with one exception: when you duplicate an *inline (content) block*, the module writes it out as a brand-new, independent `block_content` entity at clone time, so later edits to the copy never change the original (and vice versa). The module also detects the **Gin** admin theme's Layout Builder (`gin_lb`) and swaps in matching link styling when that module is present.

---

- Duplicate a single block inside a Layout Builder layout.
- Copy an entire section together with all its blocks.
- Build six identical feature cards from one configured block.
- Reuse a complex block's settings without re-entering them.
- Speed up building a long landing page.
- Keep repeated components visually and structurally consistent.
- Clone a block into a different section or region.
- Avoid reconfiguring a heavily styled block from scratch.
- Duplicate a styled section as the basis for a variant.
- Build a repeated feature row quickly.
- Reduce the number of clicks when assembling a page.
- Copy a block's configuration and visibility settings.
- Reproduce an established layout pattern across a page.
- Assemble a comparison grid of near-identical blocks.
- Clone an inline content block into an independent copy.
- Cut configuration mistakes by copying a known-good block.
- Duplicate a testimonial or call-to-action block.
- Prototype layout variations without starting over.
- Move a duplicated block into place with the weight table.
- Copy a section, then tweak only the parts that differ.
