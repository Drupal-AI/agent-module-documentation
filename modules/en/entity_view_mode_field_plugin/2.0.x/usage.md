<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Attaches computed entity metadata (bundle, ID, UUID, URL alias) to content entities as display pseudo-fields, driven by a small plugin type.

---

Entity View Mode Field Plugin defines an annotation-based plugin type, `EntityViewModeFieldPlugin`, whose plugins each compute a single value from a content entity. On every content entity type and bundle the module registers the applicable plugins as display pseudo-fields (extra fields) so they appear on the *Manage display* screen, and on each entity load it attaches the computed value to the entity object as a dynamic property named after the plugin ID. Five plugins ship out of the box, exposing the bundle, integer ID, UUID and URL alias of nodes, taxonomy terms, users, paragraphs and (for ID) commerce products. The module itself does not render these values into HTML; the attached properties are intended to be picked up when serializing entities, pairing with RESTful Web Services and the companion Entity View Mode Normalize module. Despite the project name it does not expose the render view mode itself. It has no settings form, permissions, routes or configuration, and works on Drupal 8 through 11.

---

- Add an entity's bundle to its serialized/API output as a computed value.
- Add an entity's integer ID as a pseudo-field on displays.
- Add an entity's UUID so consumers can reference it stably.
- Add a node's URL alias as a computed value.
- Add a taxonomy term's URL alias as a computed value.
- Expose node metadata (bundle, ID, UUID, alias) for a decoupled/REST front end.
- Expose taxonomy-term metadata (bundle, ID, UUID, alias) for a decoupled front end.
- Expose user metadata (bundle, ID, UUID) without writing a custom normalizer.
- Expose paragraph metadata (bundle, ID, UUID) to serialized parent output.
- Expose a commerce product's ID as a computed value.
- Pair with Entity View Mode Normalize to include these values in normalized JSON.
- Define your own `EntityViewModeFieldPlugin` to compute any scalar from an entity.
- Restrict a custom plugin to specific entity types via its `entity_type` annotation.
- Apply a custom plugin to all content entity types by leaving `entity_type` empty.
- Surface computed metadata rows on the *Manage display* form for content types.
- Read a computed value in code as a dynamic property on a loaded entity (e.g. `$node->entity_uuid`).
- Provide stable identifiers (UUID) alongside human-facing content in exports.
- Include canonical alias paths in feed or API responses for content and terms.
- Give a headless client the bundle so it can branch rendering by content type.
- Ship a lightweight, dependency-free plugin type other modules can extend.
