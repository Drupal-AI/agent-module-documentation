Paragraph Bundle Content adds the `pb_content (node type)`, `pb_block (block_content type)` Paragraph type(s) to the Paragraphs Bundles suite — a page-building bundle with a Content tab for its fields and a Display tab for per-instance colors, spacing, border, and background styling.

---

This submodule of [Paragraphs Bundles](../../../../1.0.x/agent/start.md) ships the `pb_content (node type)`, `pb_block (block_content type)` paragraph type(s) as `config/optional` (paragraph type, field storages/instances, and default form/view displays), provisioned when the module is enabled. Like every bundle in the suite it reuses the base module's shared Display-tab fields (`pb_display_*`) and CSS-variable rendering: the template reads the color/opacity/spacing fields and emits CSS custom properties (`--pb-bg`, `--pb-tx`, `--pb-br`, …) plus utility classes on a `.paragraph__inner` wrapper, so appearance is data-driven per instance with no custom CSS and no jQuery. Add it to content by allowing the bundle in a Paragraphs reference field (on a node, or the suite's PB Content / PB Block). Depends on: `paragraphs_bundles`, `node`, `block`, `block_content`, `paragraph_bundle_image`.

---

- Build a full-width page with the **PB Content** node type.
- Disable Solo-theme regions (header/footer/sidebars) per page for full-bleed layouts.
- Set a maximum content width and background color/opacity for the page.
- Add any paragraph bundle into the PB Content body.
- Reference a Block Content entity from the content type.
- Create a paragraph-driven custom block with the **PB Block** block type.
- Place the PB Block into any theme region.
- Compose landing pages with unique color schemes per page.
- Use with the Image bundle for hero/background imagery.
- Craft region-less pages that work best with the Solo theme.
- Style this bundle per instance from the **Display** tab: background, text, and border colors plus their hover variants.
- Set border, border-radius, margin, padding, width, and box-shadow on the instance without writing CSS.
- Adjust the instance's background opacity (0–100) with the BG Opacity Range field.
- Place the bundle in a Paragraphs field on any node, or inside the suite's PB Content / PB Block.
- Nest the bundle inside a layout or column bundle to build structured page sections.
- Override its `paragraph--<bundle>.html.twig` template in your theme to customize markup.
- Enable just this submodule to add only this bundle type to the site.
