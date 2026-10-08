Paragraph Bundle Node Reference adds the `node_reference_bundle`, `pb_node_reference (node type)` Paragraph type(s) to the Paragraphs Bundles suite — a page-building bundle with a Content tab for its fields and a Display tab for per-instance colors, spacing, border, and background styling.

---

This submodule of [Paragraphs Bundles](../../../../1.0.x/agent/start.md) ships the `node_reference_bundle`, `pb_node_reference (node type)` paragraph type(s) as `config/optional` (paragraph type, field storages/instances, and default form/view displays), provisioned when the module is enabled. Like every bundle in the suite it reuses the base module's shared Display-tab fields (`pb_display_*`) and CSS-variable rendering: the template reads the color/opacity/spacing fields and emits CSS custom properties (`--pb-bg`, `--pb-tx`, `--pb-br`, …) plus utility classes on a `.paragraph__inner` wrapper, so appearance is data-driven per instance with no custom CSS and no jQuery. Add it to content by allowing the bundle in a Paragraphs reference field (on a node, or the suite's PB Content / PB Block). Depends on: `paragraphs_bundles`, `paragraph_bundle_image`, `paragraph_bundle_3d_carousel`, `paragraph_bundle_slideshow`.

---

- Reference and display other nodes inside a paragraph.
- Build a 'related content' or 'featured articles' section.
- Show referenced nodes in a 3D carousel or slideshow display.
- Use the `pb_node_reference` node type as reference targets.
- Curate a list of promoted content on a landing page.
- Reuse the Image bundle for referenced-node imagery.
- Style the reference list from the Display tab.
- Display teasers of referenced nodes.
- Override the reference markup in a theme template.
- Style this bundle per instance from the **Display** tab: background, text, and border colors plus their hover variants.
- Set border, border-radius, margin, padding, width, and box-shadow on the instance without writing CSS.
- Adjust the instance's background opacity (0–100) with the BG Opacity Range field.
- Place the bundle in a Paragraphs field on any node, or inside the suite's PB Content / PB Block.
- Nest the bundle inside a layout or column bundle to build structured page sections.
- Override its `paragraph--<bundle>.html.twig` template in your theme to customize markup.
- Enable just this submodule to add only this bundle type to the site.
