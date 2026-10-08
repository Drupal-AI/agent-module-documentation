Layout Paragraphs Restrictions lets you control which Paragraph (component) types are allowed or prohibited inside Layout Paragraphs layouts and their regions, by matching contextual conditions such as the parent layout type, region, layout plugin, field name, entity type, or bundle.

---

The module adds no UI of its own beyond a single settings form. Restrictions are authored as YAML at `/admin/config/content/layout-paragraphs/restrictions` (route `layout_paragraphs_restrictions.settings`, guarded by the `administer site configuration` permission) and stored in the `layout_paragraphs_restrictions.settings` config object under a `restrictions` key. Each named rule pairs a `context` (one or more condition sets) with an allow list (`components`) or deny list (`exclude_components`). Enforcement happens server-side through an event subscriber (`LayoutParagraphsRestrictions`) that listens to Layout Paragraphs' `LayoutParagraphsAllowedTypesEvent` (priority -100) and intersects/diffs the allowed component types before the "add component" dialog is built. A companion JS behavior (`js/restrictions.js`) re-checks the same rules during drag-and-drop moves so disallowed drops are blocked live, and supports an optional `transform` map that morphs a component into a variation on drop via the `TransformComponentController` (route `layout_paragraphs_restrictions.builder.transform_item`, gated by `_layout_paragraphs_builder_access`). Context values support `!` negation (e.g. `region: '!_root'`), and `_root` denotes the top level of a Layout Paragraphs field. Rules can also target Mercury Editor templates by using `me_template_<id>` component IDs. It depends only on the `layout_paragraphs` module and ships a config schema plus an `example.layout_paragraphs_restrictions.yml` reference.

---

- Allow only a specific set of Paragraph types inside a given layout Paragraph (allow list).
- Forbid specific Paragraph types inside a layout while allowing everything else (deny list).
- Restrict a Paragraph type to a single region of a multi-column layout.
- Allow a "Hero" component only in a one-column layout or a full-width region.
- Prevent a layout Paragraph from being nested inside other layouts (`region: '!_root'`).
- Restrict components only at the top level of a field using `region: _root`.
- Scope restrictions to a specific Layout Paragraphs field via `field_name`.
- Apply restrictions only on a specific entity type (e.g. `entity_type: node`).
- Apply restrictions only on a specific bundle (e.g. `entity_bundle: blog`).
- Combine field, entity type, and bundle conditions into one targeted rule.
- Match by the layout plugin ID (e.g. `layout: twocol`) and region together.
- Match by parent component type (`parent_type`) or sibling type (`sibling_type`).
- Apply one rule to several context sets at once using an array of contexts.
- Negate any context value with a `!` prefix.
- Keep certain components out of specific regions during drag-and-drop moves.
- Give editors live "This component cannot be moved here" feedback in the builder.
- Auto-transform a component into an allowed variation when dropped into a region.
- Limit which Mercury Editor templates can be placed in a context (`me_template_<id>`).
- Author and edit all rules as YAML in one admin settings form.
- Enforce component rules server-side so the add-component dialog only offers valid types.
- Standardize page-building structure across a content model without custom code.
- Prevent editors from placing unsupported components that break a design system.
- Store restrictions as exportable, deployable configuration.
