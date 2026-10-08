<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lets Canvas (Experience Builder) component props reference Drupal content entities by adding an `x-entity-type` annotation to the component's JSON Schema, auto-wiring an autocomplete entity_reference field with live-preview transforms.

---

Canvas Entity Reference plugs into the Canvas prop-shape pipeline (`hook_canvas_storable_prop_shape_alter`) so that a Single-Directory Component prop declared with `x-entity-type: <entity_type>` (or the legacy `taxonomy-term-reference` `$ref` URI) becomes a real entity_reference field in the Canvas editor — no custom field config or PHP. Built-in definitions cover taxonomy terms, nodes, users, media, and block content, and any other entity type works through `x-entity-type`. Per-prop annotations pick which entity value is returned (`x-entity-field`, e.g. the label or a numeric ID), which bundles are selectable (`x-entity-type-bundles`), and which widget is used (`x-entity-widget`). A settings form at `/admin/config/content/canvas-entity-reference` sets the default single-value widget, restricts target vocabularies, and toggles taxonomy auto-creation. The `entity_render()` Twig function renders a referenced entity in a chosen view mode from a component template. The module is experimental and ships several example test components.

---

- Add a taxonomy term picker to a Canvas component by declaring `x-entity-type: taxonomy_term` on a prop.
- Reference a node from a component prop and print its title.
- Reference a user from a component and show the display name.
- Reference a media entity and render its image with `entity_render('media', media_id, 'default')`.
- Reference a block_content entity from a component prop.
- Return a numeric entity ID instead of a label with `x-entity-field: nid` (or `tid`, `uid`, `mid`).
- Build a multi-value tags field (`type: array` + `items` with `x-entity-type`) for selecting several terms.
- Restrict a node prop to only `article` bundles with `x-entity-type-bundles: 'article'`.
- Limit a taxonomy prop to specific vocabularies per-prop, overriding the global setting.
- Allow content editors to create new taxonomy terms on the fly from the autocomplete field.
- Disable term auto-creation so only existing terms can be selected.
- Choose the tags autocomplete widget for a single prop via `x-entity-widget`.
- Integrate a contrib entity-reference widget (Tagify, Entity Browser) that registers Canvas transform metadata.
- Set the default single-value widget site-wide (Autocomplete vs Autocomplete tags) on the settings page.
- Constrain which vocabularies are globally available for taxonomy term props.
- Render a full entity display (view mode) inside a component's Twig template.
- Migrate legacy components using the `taxonomy-term-reference` `$ref` URI to the equivalent `x-entity-type`.
- Cap multi-value cardinality on non-tags array props with `maxItems`.
- Wire up a "related content" prop referencing multiple nodes across bundles.
- Use the shipped test components as working examples of each annotation.
- Keep component authoring declarative — the entity reference is defined in the component YAML, not in separate field config.
