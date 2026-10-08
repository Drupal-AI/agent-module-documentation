<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Maps Drupal entities to remote OData objects: mapping config entities, revisioned mapped-object content entities, field-mapping plugins, and the sync event system.

---

`apisync_mapping` is the data-model core of the API Sync suite. An `apisync_mapping` config entity ties a Drupal entity type + bundle to a remote OData object type and holds the list of field maps, the sync triggers (push/pull create/update/delete), pull settings (trigger date, WHERE clause, frequency), and push settings (async, standalone, limit, retries). Each synced record is tracked by an `apisync_mapped_object` — a revisioned, fieldable content entity (bundle = `apisync_mapped_object_type`) that references the Drupal entity (via `dynamic_entity_reference`) and stores the remote API Sync ID, sync status, and an OData link field. Field values are converted in both directions by `apisync_mapping_field` plugins (properties, constant, token, related IDs/properties, etc.). The module also defines the suite's events (pull/push allowed, params, query, entity value) that `apisync_pull` and `apisync_push` dispatch, and provides Drush commands to prune revisions and purge mappings. It depends on `apisync`, `apisync_logger`, `dynamic_entity_reference`, and `typed_data`; the admin UI is in `apisync_mapping_ui`.

---

- Map a Drupal entity type + bundle to a remote OData object type.
- Store per-field mappings between Drupal fields/properties and remote fields.
- Track each synced record with a revisioned `apisync_mapped_object` entity.
- Reference the Drupal entity dynamically (any entity type) via dynamic_entity_reference.
- Record the remote API Sync ID, last sync action, status, and log message.
- Limit retained mapped-object revisions (`limit_mapped_object_revisions`).
- Convert field values with pluggable field-mapping types (properties, constant, token, related IDs/properties, related term string, Drupal constant).
- Configure sync triggers per mapping (push/pull × create/update/delete).
- Define pull trigger date and a custom pull WHERE clause per mapping.
- Configure async, standalone, push limit, retries, and frequencies per mapping.
- Dispatch pull/push lifecycle events for other modules to subscribe to.
- Validate mapped objects with constraints (unique API Sync ID, entity/type agreement).
- Build OData select queries for a mapping's pull fields.
- Provide `apisync_id`, `mapped_object_factory`, and `delete_provider` services.
- Prune mapped-object revisions and purge mappings via Drush.
- Gate mapping/mapped-object administration behind restricted permissions.
- Serve as the shared data model for `apisync_pull` and `apisync_push`.
