Layout Paragraphs Limit adds an admin settings form that restricts which Paragraph types (and how many components) may be placed into each region of each Layout Paragraphs layout.

---

The module extends [Layout Paragraphs](https://www.drupal.org/project/layout_paragraphs) (2.x or 3.x) with per-layout, per-region rules. Its single configuration page (`/admin/config/content/layout_paragraphs/limit`, route `layout_paragraphs_limit.settings_form`) lists every layout used by your layout-enabled Paragraph types and, for each region, offers three controls: a radio to *include* only the checked types or *exclude* the checked types (`negate`), a checkbox list of Paragraph types, and a numeric "limit total number of components" field. All of this is stored in the config object `layout_paragraphs_limit.settings` under `disallowed_types[<layout_id>][<region>]`. At edit time an event subscriber listens to `LayoutParagraphsAllowedTypesEvent`; for the layout and region being edited it intersects or diffs the allowed Paragraph types against the configured list, and if the region already holds `numeric_limit` or more components it allows nothing further. The module defines no permissions of its own (the form is gated by core's `administer site configuration`), no plugins, and no Drush commands — it is purely a configuration-driven filter over Layout Paragraphs' built-in "allowed types" extension point.

---

- Allow only "Card" and "Callout" paragraphs in the sidebar region of a two-column layout.
- Forbid nested "Section" paragraphs inside the content region of a one-column layout.
- Cap a hero region at a single component so editors cannot stack multiple banners.
- Restrict a call-to-action region to just the CTA paragraph type.
- Exclude a heavy "Carousel" paragraph from narrow layout regions while allowing it elsewhere.
- Enforce a maximum of three cards in a "Cards" region.
- Keep a footer region limited to link-list paragraphs only.
- Let a full-width region accept any paragraph type but block it in constrained columns.
- Prevent editors from adding text paragraphs into an image-only gallery region.
- Standardise which components are valid per region across an editorial team.
- Use "include" mode to whitelist an approved short list of paragraph types for a region.
- Use "exclude" mode to blacklist a few disruptive paragraph types while allowing the rest.
- Limit the number of components in a region to control page length.
- Combine a type restriction and a numeric cap on the same region.
- Deploy region rules as configuration (`layout_paragraphs_limit.settings`) across environments.
- Differentiate allowed paragraph types between the "first" and "second" columns of a layout.
- Block a "Block reference" paragraph in regions where embedded blocks are not wanted.
- Ensure a promoted-content region only ever contains one featured item.
- Reduce editor confusion by hiding irrelevant paragraph types from a region's add menu.
- Roll out different component palettes per layout without writing custom event subscriber code.
- Guardrail a landing-page builder so marketers stay within an approved component set.
- Prevent accidental deep nesting by disallowing layout paragraphs inside certain regions.
- Constrain a testimonial region to testimonial paragraphs and nothing else.
- Apply a hard component ceiling to a region used in a performance-sensitive template.
- Curate the "add component" experience region-by-region for a governed design system.
