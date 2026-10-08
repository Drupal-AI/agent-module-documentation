Schema.org Blueprints uses Schema.org types and properties as the blueprint for a Drupal site's content architecture: you map a Drupal entity type/bundle to a Schema.org type, and the module creates the bundle and fields (named and configured from the corresponding Schema.org properties).

---

The base module ships the full Schema.org vocabulary (types, properties, and their relationships) as CSV data and exposes it through a set of services. A `schemadotorg_mapping` config entity records the link between a Drupal entity type + bundle and a Schema.org type, plus which fields map to which Schema.org properties; a `schemadotorg_mapping_type` config entity declares, per entity type (node, user, …), which Schema.org types are recommended/default and how names are generated. When you create a mapping, `SchemaDotOrgEntityTypeBuilder` creates the bundle if needed and `SchemaDotOrgEntityFieldManager` creates fields for the selected properties (choosing sensible field types, widgets, and formatters), while `SchemaDotOrgNames` converts CamelCase Schema.org names into Drupal-safe machine names within length limits. `SchemaDotOrgSchemaTypeManager` answers questions about the vocabulary (is-a checks, type/property lookups, hierarchy/breadcrumbs, range includes), and `SchemaDotOrgMappingManager` orchestrates building mapping defaults and creating/deleting types programmatically. Global settings (`schemadotorg.settings`) tune default types, property→field-type behavior, ignored properties, and naming rules. Everything is gated by a single `administer schemadotorg` permission; the admin landing page is at `/admin/config/schemadotorg`. A rich set of alter hooks lets other modules adjust field types, field definitions, bundle values, and mapping defaults. The base module has **no UI for adding mappings** (that lives in the `schemadotorg_ui` submodule) — programmatic use is via Drush (`schemadotorg:create-type`) and the mapping manager service. Dozens of submodules integrate JSON-LD output, JSON:API, and many contrib field/UX modules; none are enabled in this pass and are out of scope here.

---

- Model a "Person" content type by mapping `node:Person` and auto-creating its fields.
- Build a consistent content architecture across a site straight from Schema.org types.
- Create multiple types at once with `drush schemadotorg:create-type node:Person node:Organization node:Event`.
- Map paragraphs to value types like `paragraph:PostalAddress` / `paragraph:ContactPoint`.
- Map media bundles to `media:ImageObject`, `media:VideoObject`, `media:AudioObject`.
- Map the user entity to `user:Person` to give profiles a Schema.org shape.
- Generate Drupal-safe machine names from CamelCase Schema.org names within length limits.
- Look up a Schema.org type's properties, parents, children, and breadcrumbs programmatically.
- Check type relationships in code (is-a Thing, is-a subtype of, enumeration membership, etc.).
- Decide the default field type for a Schema.org property (range includes → widget/formatter).
- Configure which Schema.org properties are ignored globally so they never become fields.
- Set default/recommended Schema.org types per Drupal entity type via mapping-type config.
- Delete a mapped type and optionally its fields or the whole bundle via `schemadotorg:delete-type`.
- Alter which field type a property maps to with `hook_schemadotorg_property_field_type_alter`.
- Adjust a generated field's definition with `hook_schemadotorg_property_field_alter`.
- Change bundle-entity values (labels, descriptions) with `hook_schemadotorg_bundle_entity_alter`.
- Tweak mapping defaults before creation with `hook_schemadotorg_mapping_defaults_alter`.
- React after a mapping is applied with `hook_schemadotorg_mapping_apply`.
- Keep the Schema.org data current with `drush schemadotorg:update-schema`.
- Provide the foundation layer that JSON-LD / JSON:API / metatag submodules build structured output on.
- Introspect existing mappings (which bundle maps to which type, which field maps to which property).
- Establish a repeatable, standards-based naming convention for fields across a large content model.
- Bootstrap a demo/starter content model from recommended Schema.org type sets (quick-start/common/web).
- Use the mapping manager service to build mapping defaults for a given entity type + Schema.org type.
