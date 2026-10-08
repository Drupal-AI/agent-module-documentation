Paragraphs lets site builders define reusable, fielded content components ("Paragraphs types") that editors add, order, and nest inside an entity reference field, replacing a single freeform body with structured, mix-and-match content blocks.

---

Instead of giving editors one large WYSIWYG body field, Paragraphs lets you model content as discrete, typed components — a text block, an image, a slideshow, a call-to-action, a two-column layout — each defined as a Paragraphs type with its own fields and display settings. Content is stored as `paragraph` content entities referenced from a host entity through an Entity Reference Revisions field, so every paragraph is fully revisionable and travels with its parent's revisions. Editors work through a purpose-built widget (the modern "Stable" widget by default, plus a legacy "Legacy/Classic" widget) that supports adding, duplicating, collapsing, previewing, and drag-and-drop reordering — including reordering across nesting levels. Behavior plugins attach extra, non-field functionality to a type (layout options, CSS classes, container settings) that render around the paragraph without adding storage fields. Conversion plugins let one paragraph be transformed into one or more other paragraphs. Paragraphs supports nesting (paragraphs inside paragraphs), full multilingual translation of paragraph fields, and migration paths from Drupal 7 Paragraphs and Field Collection. Site builders configure types at Admin → Structure → Paragraphs types and per-field widget behavior on each form display. Bundled submodules add a reusable Paragraphs Library and per-type access permissions.

---

- Build flexible landing pages from stackable content blocks instead of one HTML body field.
- Define distinct component types (hero, text, image, quote, accordion, CTA) each with tailored fields.
- Let editors add, remove, duplicate, and reorder content sections without touching markup.
- Drag and drop paragraphs to reorder them, including moving them between nesting levels.
- Nest paragraphs inside paragraphs to model columns, grids, or grouped sections.
- Keep every content block revisionable and rolled into the host node's revision history.
- Give each paragraph type its own view display and Twig template for pixel-perfect theming.
- Collapse long forms with summary/closed edit modes so editors can manage many paragraphs.
- Preview paragraphs in a closed state using a dedicated preview view mode.
- Attach layout, spacing, or CSS-class options via behavior plugins without adding fields.
- Restrict which paragraph types are allowed in a given field.
- Set a default paragraph type that is pre-added when an editor opens the form.
- Provide translatable structured content while keeping the reference field non-translatable.
- Convert a paragraph of one type into one or more other types with conversion plugins.
- Reuse a single authored paragraph across many pages via the Paragraphs Library submodule.
- Grant or deny create/edit/delete rights per paragraph type with the type-permissions submodule.
- Migrate legacy Drupal 7 Paragraphs and Field Collection data into Drupal 10/11 paragraphs.
- Add a "duplicate" or "add above" affordance to speed up repetitive content entry.
- Render an at-a-glance summary of collapsed paragraphs so editors recognize each block.
- Embed a paragraph field on nodes, users, taxonomy terms, or any fieldable entity.
- Build reusable component libraries for design systems and marketing teams.
- Replace fragile inline HTML/shortcodes with governed, structured components.
- Control the add-item UX (dropdown, buttons, or modal dialog) per field.
- Hide unpublished paragraphs from anonymous users while showing them to privileged roles.
- Programmatically create and attach paragraphs to entities in custom code.
- Alter the widget's action buttons or a converted paragraph via alter hooks.
