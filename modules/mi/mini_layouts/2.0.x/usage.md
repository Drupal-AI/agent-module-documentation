Mini Layouts is a spiritual successor to "Mini Panels", built on core Layout Builder: it lets administrators define reusable layout sections (blocks arranged in a layout) and place each one as a single block anywhere block placement is available.

---

The module defines a `mini_layout` **config entity** whose sections are stored using Layout Builder's `SectionListInterface`/`SectionListTrait` (config key `sections`, schema type `layout_builder.section`). Each mini layout is edited in two steps: a form (`MiniLayoutForm`) for the admin label, machine name, category, and optional **required contexts**, and a Layout Builder canvas (`MiniLayoutLayoutBuilderForm` on route `layout_builder.mini_layout.view`) where you add sections and blocks. A `MiniLayoutSectionStorage` plugin (`@SectionStorage` id `mini_layout`, weight 20) bridges the entity to Layout Builder. A `MiniLayoutBlockDeriver` exposes every mini layout as a derived block plugin (`mini_layout:<id>`) with the configured `admin_label`, `category` (default "Layouts"), and any required contexts turned into block context definitions. The `MiniLayout` block plugin loads the entity, assembles contexts (its own required contexts plus the available context repository, plus `display`/`layout_builder.entity` pointing at the mini layout), fires `hook_layout_builder_view_context_alter`, then renders each section's `toRenderArray()` with accumulated cacheability. Managed at *Structure → Mini Layouts* (`entity.mini_layout.collection`); gated by the single permission `administer mini layouts`. Requires core `layout_builder`.

---

- Build a reusable "call to action" section (heading + text + button blocks in a layout) and drop it into multiple pages as one block.
- Recreate the old Mini Panels pattern on Drupal 9/10/11 using core Layout Builder.
- Compose a footer region out of several blocks arranged in columns, placed as a single block.
- Create a promo/marketing band that editors can place in Block Layout or in a Layout Builder section.
- Define a sidebar "widget stack" (recent posts + social + newsletter) as one placeable unit.
- Group a set of blocks with a specific multi-column layout for consistent reuse across the site.
- Assign each mini layout a category so it groups sensibly in the block chooser.
- Require an entity context (e.g. a node) so the mini layout's blocks can render context-aware content.
- Pass contextual data into the contained blocks via configured required contexts.
- Place a mini layout block in a theme region through core Block Layout.
- Place a mini layout block inside another Layout Builder layout (section of a page/node).
- Centrally edit a shared section once and have every placement reflect the change.
- Standardize hero sections across landing pages without duplicating block config.
- Use Layout Builder layouts (one/two/three column, etc.) inside a reusable block.
- Export mini layouts as config for deployment across environments.
- Give site builders a no-code way to assemble multi-block components.
- Restrict who can create/manage reusable sections via the `administer mini layouts` permission.
- Replace bespoke "custom block with embedded blocks" hacks with a supported section storage.
- Provide branded, layout-consistent content blocks to content editors to reuse.
- Build a "related links + banner" combo unit once and reuse site-wide.
