<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Page Title Block provides a placeable block that renders the current page/node title as a hero header with a background color, an optional background image and subtitle text.

---

Advanced Page Title Block ships one block plugin (`advanced_title_block`) that outputs the page title inside a styled hero banner. Each block instance is configured on the block-placement form: pick a background color from an admin-defined palette, upload a fixed background image with alt text, and enter subtitle "copy" text. Instead of fixed values, the image and subtitle can be sourced from the current node — you choose which node image/entity-reference field supplies the background and which text/string field supplies the subtitle, so a single block placement produces a per-node header. The title itself is resolved from the node title on node routes, or from the route's title on other routes. A small settings form (`/admin/config/user-interface/advanced-title-block`, permission `administer site configuration`) defines the list of selectable background colors, stored in the `advanced_title_block.settings` config object. It depends on core Block and Image.

---

- Render the page title as a styled hero header block.
- Add subtitle "copy" text under the title.
- Choose a background color from an admin-defined palette.
- Upload a fixed background image per block instance.
- Set alt text for the background image.
- Inherit the background image from a node image field.
- Inherit the background image from a media entity-reference field (`field_media_image`).
- Inherit the subtitle text from a node text/string field.
- Show the node title automatically on node pages.
- Show the route title on non-node pages.
- Place one block that adapts its header per node.
- Build hero banners without writing custom theme code.
- Customize the selectable color list on the settings form.
- Restrict color choices to on-brand HEX values.
- Store background uploads under `public://background/`.
- Reuse the block across multiple content types.
- Override the `advanced-title-block.html.twig` template in a theme.
- Style the banner via the module's `advanced-title-block.css` library.
- Place the block in any theme region (typically a header/hero region).
- Provide a fallback fixed image when a node has no image field value.
