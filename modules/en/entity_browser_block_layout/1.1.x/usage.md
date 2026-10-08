<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Browser Block Layout applies UX and CSS adjustments that make Entity Browser Block blocks easier to select, configure and place inside Layout Builder.

---

Entity Browser Block Layout is a small helper for sites that combine core Layout Builder with the contributed Entity Browser and Entity Browser Block modules. Working entirely through form-alter hooks (no new routes, permissions or block plugins of its own), it improves the block-placement panel in the Layout Builder sidebar: it hides redundant label/title fields for Entity Browser Block blocks, tidies the tiny "selected items" table so its cells stack vertically, adds an Edit button next to each selected content item, and auto-opens the entity browser modal when you add a new block so you do not have to click twice. On the content-type (and media-type) edit forms it adds a checkboxes group that lets you choose exactly which view modes editors may pick when they place referenced content of that bundle in a layout, saved as a third-party setting on the bundle. It also decorates the bundled Entity Browser views (node, block, media and bio browsers) with CSS and JavaScript so an entire table row is clickable to select an item and the selected row is highlighted. All access continues to be governed by Layout Builder's own layout-configuration access and by the standard content-type / media-type administration permissions.

---

- Make Entity Browser Block blocks easier to place in Layout Builder.
- Hide the redundant admin label / title fields on Entity Browser Block blocks in the sidebar.
- Tidy the selected-items results table so it fits the narrow Layout Builder sidebar.
- Stack the results table cells vertically for readability.
- Add an Edit button beside each item you have selected in a block.
- Jump straight from a placed block to editing the referenced entity.
- Auto-open the entity browser modal when adding a new Entity Browser Block block.
- Avoid the extra clicks normally needed to open the browser when creating a block.
- Restrict which view modes editors may choose per content type when placing referenced content.
- Suppress view modes that make no sense inside Layout Builder (for example show only Teaser).
- Configure allowed view modes per node type on the content-type edit form.
- Configure allowed view modes per media type on the media-type edit form.
- Default new placements to a preferred view mode (Teaser or Promo) when one is allowed.
- Keep the allowed-view-mode choice as a third-party setting on the bundle for config export.
- Make whole entity-browser table rows clickable, not just the checkbox.
- Highlight the currently selected row in entity-browser views.
- Improve the selection UX of node, block, media and bio entity-browser views.
- Relabel the exposed post-date operator in the node browser view for clarity.
- Ship ready-made optional Entity Browser views (node_browser, block_browser, media_entity_browser, bio_browser).
- Use it on editorial sites building landing pages with Layout Builder plus Entity Browser.
- Combine Entity Browser and Layout Builder for reference-based block content.
- Give content editors a cleaner reference-block placement workflow.
- Standardize how referenced content renders in layouts by curating view modes.
- Reduce mis-selection of unsuitable view modes during page building.
