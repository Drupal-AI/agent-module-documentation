Entity Reference Filtering Link is a field formatter for entity-reference fields that renders each referenced entity's label as a link to a pre-filtered view (via query argument, double-bracketed multiple, autocomplete string, or facet syntax) rather than to the entity's own canonical page.

---

A reference field's default link goes to the referenced entity's canonical page — the term page, the node, the user. Often that is not the useful destination: a "Brand" reference on a product should lead to the product listing filtered by that brand; a "Region" reference to the events in that region; an "Author" reference to their article listing. What you actually want is a listing view with a contextual or exposed filter, and the reference's job is to be the link into it. This module supplies that as a configurable formatter so you avoid a Twig override or a bespoke per-field formatter. On the Manage Display screen you pick the base path (the view/page), the argument name (defaults to the field's machine name), and the URL "mode" that decides how the referenced entity's id or label is appended: a plain `?arg=id` query, PHP array forms `?arg[]=id` and `?arg[id]=id`, an autocomplete-style `?arg=Label (id)`, or Search API / Facets facet syntax `?f[0]=arg:id` (or `:Label`). Extra per-instance options let you skip the destination's access check (so an unprivileged visitor is still linked and bounced to login), suppress linking for a comma-separated allow-list of labels (rendering them as plain text), and gate link generation behind a permission (users lacking it see the plain label). The module ships two formatter plugins with identical behaviour; the second (`entity_reference_filtered_link_disable`) is hidden from the Field UI (`no_ui`) and exists for programmatic/legacy display configs. It pairs naturally with a Views page that reads the reference value as a contextual argument or exposed filter, making it a lightweight substitute for a facets module when a site needs only one or two facets.

---

- Link a "Brand" product reference to a product listing view filtered by that brand.
- Link a "Region" reference to a view of events in that region.
- Link an "Author" reference to that author's article listing instead of their user page.
- Turn a taxonomy-term reference into a facet link (`?f[0]=field_tags:7`) for a Search API / Facets page.
- Send a category reference to a filtered listing view rather than the sparse term page.
- Replace a hand-written Twig override that built a query-string link from a reference field.
- Provide lightweight one- or two-facet filtering without installing the Facets module.
- Feed a Views page that consumes the reference value as a contextual filter argument.
- Use `?tag=7` (Standard) mode when the destination view exposes a single-value filter.
- Use `?tag[]=7` (Standard Multiple) mode for a multi-value exposed filter that expects an array.
- Use `?tag[7]=7` (Double Bracketed) mode for legacy Drupal 9 multi-value exposed-filter shapes.
- Use Autocomplete mode (`?tag=Label (7)`) to prefill an entity-reference autocomplete filter.
- Use Facet-Label mode (`?f[0]=tag:StarTrek`) when the facet keys on the label rather than the id.
- Default the query argument name to the field's machine name to avoid configuring it explicitly.
- Point `view_url` at the internal `/node/123` form so links survive alias/path changes.
- Enable "Skip Access Check" so anonymous users are still linked to a permission-protected page and bounced to login.
- Suppress the link for specific labels (e.g. "Uncategorized", "Other") via the comma-separated Skip Linking list.
- Restrict link generation to users holding a chosen permission, showing everyone else the plain label.
- Apply a different formatter (linked vs. plain) between teaser and full view modes.
- Keep the referenced entity's cache tags on the rendered element so the link invalidates correctly.
- Fall back to a plain-text label automatically when the configured base path is invalid.
