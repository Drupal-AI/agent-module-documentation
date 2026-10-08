Entity Reference Link adds a field formatter that renders an entity_reference field as a fully customizable link, pointing at a Drupal route or custom URL built from the referenced and referencing entity IDs rather than at the referenced entity's own page.

---

The module provides one field formatter plugin, "Entity Reference Custom Link" (id `entity_reference_link`), available on any core `entity_reference` field from *Manage display*. For each referenced item it constructs a link whose URL is generated either from a named Drupal route — with the referenced entity ID and/or the referencing entity ID placed into route parameters or query parameters — or from a custom `href` template. The link text, any extra HTML attributes, and how multiple values are wrapped (separator, wrapper element, or ordered/unordered list) are each driven by short inline Twig templates that can use three tokens: `{{ id }}` (the referenced entity's ID), `{{ referencing_id }}` (the ID of the entity that holds the field), and `{{ label }}` (the referenced entity's label). This lets a site builder turn an entity reference into a link to a view filtered by that ID, a form URL that prepopulates a value, a report or dashboard page, or any other route keyed by the ID — all from the display settings, with no custom code. The module has no routes, services, permissions, configuration form, config schema, or dependencies beyond core `field`; everything is configured per view-display.

---

- Link an entity reference to a **view** filtered by the referenced entity's ID (route + query parameter).
- Link an entity reference to a view using the referenced ID as a **contextual/route parameter**.
- Build a link that prepopulates a **webform or form field** with the referenced entity's ID via a query parameter.
- Point a reference at a **custom report or dashboard route** keyed by the referenced entity ID.
- Use the **referencing** entity's ID (the host entity) as a route or query parameter instead of, or in addition to, the referenced ID.
- Combine both IDs — referenced and referencing — as two route/query parameters on the same link.
- Render a reference as a link to a **non-canonical path** via a custom `href` template like `/{{ id }}` or `/catalog/{{ id }}`.
- Produce links whose **href mixes both tokens**, e.g. `/compare/{{ referencing_id }}/{{ id }}`.
- Customize the **visible link text** with a Twig template such as `{{ label }}` (default), `View {{ label }}`, or `Item #{{ id }}`.
- Add arbitrary **HTML attributes** to the anchor (for example `class`, `target`, `rel`, `title`) one per line in `key=value` form, with token substitution.
- Render multiple referenced values as a **comma- or custom-separated** inline list.
- Render multiple values wrapped in a chosen **HTML element** (`div`, `p`, `span`, `h1`–`h6`).
- Render multiple values as an **ordered list** (`<ol>`) with configurable list and list-item CSS classes.
- Render multiple values as an **unordered list** (`<ul>`) with configurable list and list-item CSS classes.
- Choose whether a **single value** bypasses list markup or still uses the list logic.
- Apply **CSS classes** to list wrappers and list items for theming.
- Show a **fallback label** for a missing/deleted referenced entity (the formatter emits a "Missing <type> Entity <id>" placeholder rather than erroring).
- Replace core's default *"Rendered entity"* / *"Label"* entity-reference formatters where you need the link target to differ from the entity's canonical URL.
- Drive links to **taxonomy-term listing pages**, media libraries, or catalog filters keyed by the term/media ID.
- Configure everything from **Manage display** (UI) or export the settings into `core.entity_view_display.*` config for deployment.
- Reuse the same formatter across many reference fields, each with its **own route/template and list style**.
