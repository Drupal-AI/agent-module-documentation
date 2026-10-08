Context Entity Field adds an "Entity Field" condition to the Context module, letting a context activate its reactions based on whether an entity's field is empty, filled, or equal to a given value.

---

The module is a single Context condition plugin (`entity_field`) derived per entity type that has bundles (`EntityFieldDeriver` extends core `EntityBundle`), so there is one derivative per content-entity type (node, taxonomy_term, media, etc.), each taking that entity type as a plugin context. In a Context's condition configuration you pick a field on the entity, a field state — **Filled**, **Empty**, or **Value is** — and, for the value state, the string to compare against. At evaluation time (`EntityFieldCondition::evaluate()`) the condition reads the contextual entity, checks the chosen field, and returns TRUE when it is empty/filled, or when any field item's `getString()` strictly equals the configured value. It is intended to be used from the Context UI: `context_entity_field_plugin_filter_condition_alter()` deliberately removes the `entity_field` condition from the core Block UI and Layout Builder condition lists so it only appears inside Context. There is no admin settings page, no permissions, no schema, and no Drush; it depends on the contrib `context` module.

---

- Show blocks (via a Context reaction) only when a node field has a specific value.
- Activate a context when a given field on the current entity is empty.
- Activate a context when a given field is filled (non-empty).
- Match an exact string value in a text field to trigger reactions.
- Toggle a theme/region reaction based on a taxonomy term field value.
- Drive breadcrumb or menu reactions from a node field state.
- Gate a context on a boolean/list field equaling a chosen option.
- Build "if field X is set, then do Y" rules without custom code.
- Distinguish content variants by a field value for display logic.
- Apply different sidebars depending on whether a field is populated.
- Condition media-related reactions on a media entity's field value.
- Condition user-related reactions on a user field value (any bundled entity type with bundles).
- Combine with other Context conditions to build compound visibility rules.
- Hide promotional blocks when a "sponsored" field is empty.
- Enable a call-to-action region only when a CTA field is filled.
- Switch layouts by reading a "layout" field value through Context.
- Reuse one condition across all bundles of an entity type (derived per type).
- Keep the condition out of Block UI / Layout Builder so it is Context-only.
- Base content-type-agnostic rules on shared field machine names.
- Prototype field-driven display logic entirely through the admin UI.
