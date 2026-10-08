<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Fallback Value resolves a content-entity value from a prioritized list of fields, returning the first non-empty one, and exposes it through a PHP service, a Twig function and tokens.

---

Entity Fallback Value is a developer-oriented module that adds a fallback (cascade) system for reading content-entity values. You describe a value as an ordered list of field paths — for example "use the override title field, else the real title" — and the module walks the list and returns the value of the first field that is non-empty. Each field path may traverse entity references and nested typed data (dot syntax such as `field_override_title.value` or `paragraph_thumbnail.field_description`), and a path entry may also be a PHP callable. Fallback chains can be supplied ad hoc to the `entity_fallback_value.manager` service, or declared once per entity-type/bundle in an EntityFallbackValue plugin (scaffold one with `drush generate plugin:entity_fallback_value`). Once a plugin exists, the resolved values become available in Twig via the `getEntityFallbackValues()` function and as tokens named `[<entity>:efv_<key>]`. The module ships no configuration UI, no permissions and no plugins of its own; it is a small API plus a plugin type, a Twig extension and a token integration. It works on Drupal 8.8 through 11.

---

- Show an optional "override title" field when set and otherwise fall back to the node's real title.
- Display the first non-empty of several description fields (long description, description, chapô) in a single template variable.
- Define a per-bundle fallback chain once in a plugin instead of repeating `if empty` logic in many templates.
- Read a value from a referenced entity (e.g. a paragraph or referenced node) when the host entity's own field is empty.
- Traverse nested field paths with dot syntax, such as `field_media.field_image` or `field_override_title.value`.
- Expose a computed "effective value" to editors and themers through a token like `[node:efv_title]`.
- Pull fallback values into meta tags, path patterns or e-mail bodies via the token integration (with the Token module enabled).
- Access fallback values directly in a Twig template with `{% set data = getEntityFallbackValues(node) %}`.
- Retrieve only selected keys of a chain by passing a `keys` argument to the Twig function or service.
- Build custom fallback definitions at runtime in PHP with `getEntityCustomFallbackValues($entity, $definitions)`.
- Use a PHP callable as one step of a chain to compute a value when no field applies.
- Resolve values in the current interface language, or in the entity's own language, via the Twig function's language flag.
- Scaffold a new fallback plugin quickly with the bundled Drush generator.
- Restrict a plugin to specific entity types and bundles through its `applies_on` annotation (e.g. `node.page`).
- Apply a plugin to every bundle of an entity type by listing the type with no bundle.
- Provide themers a single, stable variable name regardless of which underlying field holds the content.
- Reduce duplicated "coalesce" logic across preprocess functions and templates.
- Support multilingual sites by returning the translated value of the resolved field.
- Combine several optional CTA/link fields into one effective link for display.
- Fall back from a bundle-specific field to a shared base field for consistent listings.
- Feed a consistent value into Views or other display logic through tokens.
- Let content editors leave optional fields empty and rely on sensible defaults at render time.
