Paragraphs Bundles is a suite of ready-made Paragraph types (bundles) for page building, each split into a **Content** tab (the actual fields) and a **Display** tab (per-instance colors, border, radius, margin, padding, width, box-shadow, and background opacity) built on Paragraphs and Field Group. The base module supplies the shared field types, styling machinery, and a `simple_bundle`; 26 submodules add specific bundles (accordion, carousel, hero, grid, tabs, image, modal, etc.).

---

The base module ships one paragraph type, `simple_bundle`, plus the shared infrastructure every bundle
reuses: two custom field types with widgets/formatters — `paragraphs_bundles_rgb` (a **Color Picker**
hex/RGB text field, widget `color_text_widget` validating with `Color::validateHex`, formatters
`color_text_formatter_hex`/`_rgb`/`color_swatch`) and `paragraphs_bundles_range` (a **BG Opacity Range**
0–100 integer, widget `range_number_widget`, formatter `range_number_formatter`) — and a Twig extension
adding the `decode_entities` filter. Each bundle's Twig template reads the `pb_display_*` fields and emits
them as CSS custom properties (e.g. `--pb-bg:rgba(...)`, `--pb-tx:#hex`) and utility classes on a
`.paragraph__inner` wrapper, so appearance is data-driven per paragraph instance without writing CSS.
`hook_preprocess_paragraph` normalizes the wrapper classes; helper functions in `paragraphs_bundles.module`
import each bundle's `config/optional` field storages/instances on demand and wire the shared
`pb_content_title` fields, so installing a submodule provisions its paragraph type and fields
automatically. Two special types come via submodules: **PB Content** (a `pb_content` node type with
disableable Solo-theme regions and full-width settings) and **PB Block** (a `pb_block` custom block type)
— both let you compose a whole page/region out of paragraph bundles. Bundles are added to any entity by
attaching a Paragraphs reference field and allowing the desired bundle types; several submodules depend on
`paragraph_bundle_image` or on contrib (`viewsreference`, `webform`, `contact_formatter`,
`link_attributes`). The suite is theme-agnostic (no jQuery) and integrates most fully with the Solo theme.

---

- Add a suite of prebuilt Paragraph types for page building without hand-modeling fields.
- Give every paragraph instance its own background, text, and border colors via the Display tab color pickers.
- Set per-instance border, border-radius, margin, padding, width, and box-shadow with no custom CSS.
- Control a paragraph's background opacity (0–100) with the BG Opacity Range field.
- Apply hover colors (background/text/border) that map to CSS custom properties.
- Compose a full landing page from accordion, hero, carousel, grid, tabs, and card bundles.
- Build responsive two- or three-column layouts with per-breakpoint behavior.
- Use the `simple_bundle` as a minimal titled/body content block with full Display styling.
- Reuse the `paragraphs_bundles_rgb` color field type in your own paragraph or entity.
- Render a stored color as hex text, RGB text, or a color swatch using the provided formatters.
- Validate author-entered colors as 3/6-digit hex automatically.
- Decode HTML entities in a template with the `decode_entities` Twig filter.
- Build a whole node's layout with the **PB Content** type (disable header/footer/side regions for full-width pages).
- Place a paragraph-driven **PB Block** custom block into any theme region.
- Enable only the bundle submodules you need, keeping the field set lean.
- Nest paragraph bundles inside layout/column bundles for structured sections.
- Provide editors a consistent Content/Display tab UX across every bundle type.
- Integrate tightly with the Solo theme for full-width, region-aware page building.
- Style bundles identically across any theme thanks to CSS-variable output (theme-agnostic, no jQuery).
- Auto-provision a bundle's fields on install via the module's `config/optional` import helpers.
- Add media, image, video-embed, icon, or link content through dedicated bundles.
- Embed a View, Webform, or core Contact form inside a paragraph via the matching submodule.
- Reference other nodes (with carousel/slideshow displays) using the Node Reference bundle.
- Extend the suite by cloning a bundle submodule's paragraph type + template as a starting point.
