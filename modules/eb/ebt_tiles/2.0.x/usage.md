<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EBT Tiles adds a ready-made "Tiles" custom block type — a responsive grid of cards, each a Paragraph with title, text, image and link — to the Extra Block Types (EBT) family.

---

EBT Tiles ships a `block_content` bundle (`ebt_tiles`) plus an `ebt_tiles_item` Paragraph type, wired together with pre-built fields and form/view displays, so enabling the module gives you a placeable "Tiles" block with no field building. Each tile item carries a title, a formatted-text body, a Media image and a link; a per-block setting picks a one/two/three/four-column layout, and the tile can be made fully clickable. It builds on EBT Core (shared `field_ebt_settings` design widget: spacing, borders, background, container width) and on Paragraphs. Place the block in Layout Builder, in Block layout, or as a reusable content block.

---

- Add a responsive grid of feature cards to a landing page.
- Build a "key items" / highlights row from image-and-text tiles.
- Create a services or products overview as clickable cards.
- Lay out tiles in one, two, three or four columns via the block Settings tab.
- Make each entire tile a clickable link, or show the link separately.
- Open tile links in a new browser tab when configured per block.
- Add a `rel="nofollow"` hint to tile links for SEO control.
- Attach a Media Library image to each tile.
- Give each tile a formatted title and rich-text body.
- Place a Tiles block through Layout Builder in a few clicks.
- Add a Tiles block under Structure → Block layout.
- Create a reusable Tiles block under Content → Blocks → Add content block.
- Reuse the shared EBT Core design options (margins, padding, borders, background, container width).
- Combine Tiles with other EBT block types on the same page.
- Reorder tiles with the Paragraphs drag-and-drop widget.
- Duplicate an existing tile item while editing (Paragraphs duplicate feature).
- Style the grid per column count via the module's bundled CSS libraries.
- Override the tile markup by copying `paragraph--ebt-tiles-item--default.html.twig` into your theme.
- Present a card grid without writing a custom field or Paragraph type.
- Use a standalone EBT block type without installing the whole EBT suite.
