Classy Paragraphs lets site builders define reusable named sets of CSS classes ("styles") and lets editors pick one from a drop-down/checkbox field to style individual Paragraph items on the front end.

---

The module stores each style as a `classy_paragraphs_style` **config entity** (a `label` plus a newline-separated `classes` string), managed from a simple admin UI at `/admin/structure/classy_paragraphs_style`. To use styles you add a core **entity reference field** to a Paragraph type (or any fieldable entity) whose target type is `classy_paragraphs_style`; the module provides a custom `classy_paragraphs` EntityReferenceSelection handler for filtering/sorting the options, and editors typically pick values with a select list or checkboxes widget. On render, `hook_entity_view_alter()` inspects each entity for reference fields targeting `classy_paragraphs_style`, reads the referenced styles' classes, and merges them into the render array's `#attributes['class']` — so the classes land in the `{{ attributes.class }}` Twig variable of the paragraph template with no code. Because styles are config entities they are exportable/deployable via the config system. The module adds no new field type of its own (the README's "Class list field" is a normal entity-reference field), no permissions of its own (the style UI is gated by core's *administer site configuration*), and no Drush commands. It does not integrate with Display Suite or Panelizer.

---

- Give editors a drop-down of approved background colors to apply to paragraphs.
- Offer a set of button styles (e.g. `btn btn-primary`) selectable per call-to-action paragraph.
- Apply responsive width utility classes (e.g. Bootstrap `col-md-6 col-12`) to card paragraphs.
- Let content builders toggle light/dark section themes without touching code.
- Add spacing/margin utility classes (e.g. `mt-5 mb-3`) to individual paragraphs.
- Provide text-alignment options (`text-center`, `text-end`) as a picker.
- Apply multiple classes at once by storing several classes in one style (one per line).
- Standardize a design system's component variants as named, reusable styles.
- Style hero/banner paragraphs with named gradient or overlay classes.
- Let editors mark paragraphs as "featured" via a class that CSS keys off.
- Expose animation trigger classes (e.g. `fade-in`, `slide-up`) to editors.
- Give a select field of container widths (`container`, `container-fluid`).
- Provide print/screen visibility utility classes per paragraph.
- Deploy the full catalog of styles across environments via config export/import.
- Restrict which styles a specific field offers using the selection handler's filter (by machine-name prefix or by chosen bundles).
- Sort the style options shown to editors by label or machine name.
- Reuse the same style catalog across many Paragraph types with one field per type.
- Apply classes to non-paragraph entities (nodes, blocks) by adding the same reference field there.
- Add a "no style / default" empty option by leaving the reference field optional.
- Let a single paragraph carry several stacked styles via an unlimited-cardinality field.
- Theme paragraphs consistently by relying on `{{ attributes.addClass(classes) }}` in Twig.
- Migrate legacy per-hook paragraph styling to a managed, UI-driven catalog.
- Empower non-developers to choose layout treatments within guardrails set by site builders.
- Version-control the approved class list so design changes go through review.
- Build an editorial style guide surfaced directly in the paragraph edit form.
