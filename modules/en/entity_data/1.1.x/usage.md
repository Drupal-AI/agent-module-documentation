<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Data provides a developer API and service to store arbitrary custom data per content entity.

---

Entity Data adds a key/value store keyed by module, entity type, entity id and a name, so code can attach
extra data to any content entity without adding fields or altering the entity schema. It works like Drupal
core's `user.data` service but is not limited to user entities. A single service (`entity.data`) exposes
`get()`, `set()` and `delete()` methods; scalar values are stored directly while arrays and objects are
serialized automatically. Values live in a dedicated `entity_data` database table, are cleaned up when their
entity is deleted, and can be surfaced through a Views field handler. An admin settings form lets you allow
specific PHP classes to be unserialized when reading complex object values. It requires PHP 8.1 and Drupal
10 or 11 and is in the Entity package.

---

- Store scalar flags per entity (for example a per-node "send notifications" boolean).
- Attach a small array of settings to a group, term or user without creating fields.
- Persist per-entity moderation or workflow preferences from a custom module.
- Keep per-entity social-media links or handles outside the content model.
- Cache computed per-entity metadata that should not pollute the entity's fields.
- Record per-entity feature toggles keyed by your module name.
- Store third-party integration ids (external system references) per entity.
- Save per-entity display or layout hints consumed by a custom theme/preprocess.
- Track per-entity counters or timestamps maintained by a background process.
- Namespace data by module so multiple modules can store data on the same entity without collision.
- Retrieve a single value with `get($module, $entity_id, $name, $entity_type)`.
- Fetch all name/value pairs for one entity with `get($module, $entity_id, NULL, $entity_type)`.
- Fetch a value across many entities for one name with `get($module, NULL, $name)`.
- Bulk-delete data for several entities or modules by passing arrays to `delete()`.
- Automatically purge an entity's stored data when the entity is deleted (via `hook_entity_delete`).
- Expose stored values in a view using the "Entity data: value" Views field.
- Filter, sort or argue on entity data columns in Views (value, module, name).
- Store complex objects and control which classes are safe to unserialize via the settings form.
- Replace ad-hoc custom key/value tables with one shared, indexed store.
- Provide a lightweight alternative to fields for developer-only side data.
- Swap the storage backend via the `backend_overridable` service tag if needed.
