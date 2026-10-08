Paragraph Blocks exposes each value of a multi-value paragraph field (and paragraph fields on related entities) as an individual Layout Builder block, so editors can place specific paragraph items into a layout instead of rendering the whole field at once.

---

The module derives a Layout Builder block plugin — base id `paragraph_field`, category "Paragraphs" — for every entity/paragraph-reference-field/delta/bundle combination via `ParagraphBlocksDeriver` (plugin ids look like `paragraph_field:node:field_paragraphs:0:page`). Fields with cardinality 1 are skipped (render them as a normal field); unlimited fields are capped at the configurable `max_cardinality` (default 10) for how many delta blocks are offered. It adds an `admin_title` base field to paragraph entities so each item is identifiable in the block-placement UI, and lets each Paragraphs type define a `default_admin_title` (token-aware when the Token module is present). A per-field checkbox (third-party setting `paragraph_blocks.status` on the paragraph reference field's config) enables or disables block exposure for that field, and an entity-view-display alter integrates with Layout Builder Restrictions so you allow/deny paragraph blocks per display. Global behavior lives in `paragraph_blocks.settings`: `max_cardinality`, `individual_block_ui` (show per-item checkboxes in Layout Builder Restrictions), `suppress_label` (hide the redundant block label field on placement, since the admin title is used), and `library_items_only` (only offer paragraphs referencing the Paragraphs Library). Configuration is at `/admin/config/content/paragraph_blocks` (permission `administer paragraphs settings`). Requires the Paragraphs and ctools modules.

---

- Place a single paragraph item (e.g. the 3rd "section") from a multi-value paragraph field into a Layout Builder region.
- Build a page layout from individual paragraph blocks rather than one monolithic field render.
- Reorder paragraph items freely across layout regions instead of their storage order.
- Expose paragraph fields from a related/referenced entity as blocks in a layout.
- Give each paragraph an admin title so editors can tell the blocks apart when placing them.
- Set a default admin title per paragraph type (with tokens like `[paragraph:field_text]`) so titles auto-populate.
- Cap how many delta blocks an unlimited paragraph field offers via `max_cardinality`.
- Enable or disable paragraph-block exposure per field with the "Enable Paragraph Blocks" checkbox.
- Restrict which paragraph blocks are allowed on a given entity view display via Layout Builder Restrictions.
- Show granular per-item checkboxes in Layout Builder Restrictions with `individual_block_ui`.
- Hide the redundant block label field during placement with `suppress_label` (the admin title is the label).
- Only offer paragraphs that reference the Paragraphs Library with `library_items_only` to reduce UI clutter.
- Compose landing pages where marketing places reusable paragraph components block-by-block.
- Keep paragraph storage on the entity while giving layout freedom in Layout Builder.
- Place a hero paragraph in one region and CTA paragraphs in another from the same field.
- Let editors drag specific testimonials or cards (individual paragraph items) into a layout.
- Integrate paragraph content with Layout Builder without custom block code.
- Auto-name paragraph blocks from their content via token-based default admin titles.
- Avoid exposing single-value paragraph fields as blocks (cardinality-1 fields are intentionally skipped).
- Reduce editor confusion by suppressing duplicate label fields on block placement.
- Curate a library-driven page builder where only library paragraphs are placeable.
- Manage layout order safely across Workspace publishing (the module skips reordering during sync).
