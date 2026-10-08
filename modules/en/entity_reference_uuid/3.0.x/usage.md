<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference UUID adds an `entity_reference_uuid` field type that stores the reference as the target entity's UUID instead of its numeric entity ID, so the reference survives migrations, content deployments and multi-environment moves.

---

The field type is `EntityReferenceUuidItem`, a subclass of core's `EntityReferenceItem`. It keeps the same `target_type` storage setting, the same `handler`/`handler_settings` field settings and the same `entity` computed property, but its main property is `target_uuid` (a `varchar_ascii(128)`, indexed) rather than `target_id`, and that is the only column persisted to the field table — the integer ID is never stored. Because it extends the core item, it works with the ordinary reference plumbing: the default widget is `entity_reference_autocomplete` and the module's `hook_field_widget_info_alter` also opts the field into `options_select`/`options_buttons`, the tags autocomplete, inline entity form, `select2_entity_reference` and `chosen_select`; the default formatter is core's `entity_reference_label`, and the module adds its own `entity_reference_uuid_entity_view` ("Rendered entity") formatter. Save-time integrity is enforced the same way core does it — the field item list (`EntityReferenceUuidFieldItemList`) adds core's `ValidReference` constraint (checking the target exists, matches the target type/bundle, and passes reference access) on top of the dynamic `EntityType` constraint on the `entity` property, so an arbitrary UUID cannot silently be referenced. Reading works by resolving the UUID back to an entity: `referencedEntities()` and the item's `onChange()` call `loadByProperties(['uuid' => ...])`, and `preSave()`/`hasNewEntity()` handle the autocreate case where a freshly created entity is saved and its UUID captured only as the host is saved. The rendered-entity formatter renders through core's `getEntitiesToView()` and the entity view builder, so referenced-entity `view` access is checked exactly as it is for core entity reference; default-value processing and the taxonomy filter run their entity queries with `accessCheck(TRUE)`. For querying, a `ServiceProvider` swaps the SQL entity-query `Tables` class so that entity queries can join a `entity_reference_uuid` field to the target's base table on `uuid` rather than the id column, and the Views hooks register forward and reverse relationships (handlers `entity_standard_uuid` and `entity_reverse_uuid`), a UUID-aware taxonomy filter (`entity_reference_uuid_taxonomy_index_uuid`) and a reusable `EntityReferenceUuidEntityViewsTrait` for base fields. Trade-offs to note: a UUID lookup is a 36-character string compare instead of an indexed-integer lookup, so per-row resolution in large listings is measurably slower; the target may legitimately not exist yet during a deployment, so rendering tolerates an unresolvable reference; and `^11.1` is a hard core requirement (Drupal 11.1+ only).

---

- Reference content that will be deployed to another environment.
- Keep references valid after a migration renumbers entity IDs.
- Share entity references between staging and production.
- Export default content with references that resolve on import.
- Reference entities across sites in a multisite.
- Keep a reference stable across separate databases.
- Add a UUID-based reference field to a content type via Field UI.
- Add an `entity_reference_uuid` base field in custom entity code.
- Reference taxonomy terms by UUID and filter a View on them.
- Build a View with a forward relationship to the referenced entity by UUID.
- Build a View with a reverse relationship back to referencing entities.
- Render a referenced entity in a chosen view mode with the "Rendered entity" formatter.
- Use the autocomplete, select, checkboxes/radios, Select2 or Chosen widget on a UUID reference.
- Auto-create a referenced entity inline and have its UUID captured on save.
- Set a deployable default value that stores UUIDs rather than IDs.
- Support a content-staging / content-deployment workflow.
- Reference an entity before the target exists on the destination.
- Query entities by an `entity_reference_uuid` field with the entity query API.
- Avoid broken references after a full site rebuild or restore.
- Move fixtures or sample content between installs without remapping IDs.
- Keep references intact in a repeatable, config-driven site build.
- Reference content by a portable identifier in a decoupled pipeline.
