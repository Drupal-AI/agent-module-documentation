Custom Entity Id lets a privileged user type a specific numeric primary-key ID into the create form of chosen entity types/bundles, instead of accepting the auto-increment value.

---

The module implements `hook_form_alter()` to add an "Entity Id" textfield (max 15 chars, weight -50) to the create form of any entity-type/bundle an administrator has opted in on the settings page (`/admin/config/custom-entity-id`, config object `custom_entity_id.settings`). The field appears only when the current user holds the `custom_entity_id access` permission and only when the entity is new (its id key is not yet set). A form validate handler rejects non-numeric input and input that collides with an existing row in the entity's base table ("Entity id already exists."). On `hook_entity_presave()` the numeric value is written into the entity's id entity-key so the new entity is stored with that exact ID. The opt-in selection is stored as a PHP-serialized `entity_type => [bundle, ...]` map in the `fieldable_entity` config value. There is no dependency on any other module, no plugins, and no Drush commands; the only route is the settings form (permission `administer site configuration`).

---

- Assign a chosen node ID to a new article rather than the next auto-increment value.
- Preserve entity IDs when copying content from a staging site to production.
- Preserve entity IDs when migrating/mirroring content between two Drupal instances.
- Keep IDs stable so external systems that reference them by ID keep working.
- Support business logic that branches on specific entity IDs.
- Create placeholder/reserved entities at known IDs.
- Theme a specific entity by building a template keyed to its exact ID.
- Re-create a deleted entity at its original ID.
- Seed demo or test content at predictable IDs.
- Align IDs across multiple content types for a coordinated numbering scheme.
- Fill an intentional gap in an ID sequence.
- Let a data-import script set the taxonomy term ID it expects.
- Reconstruct legacy content at IDs that match an old system.
- Restrict who can set custom IDs via the `custom_entity_id access` permission.
- Enable the custom-ID field per entity type and bundle from one settings page.
- Turn the feature off for a bundle by unchecking it on the settings page.
- Keep the field hidden from ordinary editors (permission-gated, restrict-access).
- Guarantee uniqueness at entry time via the existing-ID collision check.
- Set custom IDs only on creation (the field is suppressed once an entity has an ID).
- Apply the feature to any fieldable entity type, not just nodes.
