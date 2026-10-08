Salesforce Mapping defines how a Drupal entity type/bundle maps to a Salesforce object: it provides the `salesforce_mapping` config entity (the map), the `salesforce_mapped_object` content entity (a record link), and the field-mapping plugin system that push and pull use.

---

A **`salesforce_mapping`** config entity ties one Drupal `drupal_entity_type` + `drupal_bundle` to one `salesforce_object_type` (e.g. `user`/`user` ↔ `Contact`). It carries the `sync_triggers` (which of push_create/push_update/push_delete and pull_create/pull_update/pull_delete are active), the `field_mappings` array, a `key` (the Salesforce upsert key field), `async` and `always_upsert` flags, standalone/queue options, and push/pull limits and frequencies. Each `field_mappings` entry is a **SalesforceMappingField** plugin instance (`plugin.manager.salesforce_mapping_field`, `@SalesforceMappingField`) — shipped types are `properties` and `properties_extended` (map a Drupal field/property to an SF field), `record_type` (map the SF record type) and `broken` (a placeholder for an unavailable field). A **`salesforce_mapped_object`** content entity records the link between a specific Drupal entity and its Salesforce record (SFID), with revisions (capped by `salesforce.settings.limit_mapped_object_revisions`). Mapping itself does no I/O — it is configuration; `salesforce_push` and `salesforce_pull` read the mappings and triggers to move data. Three permissions gate it: `administer salesforce mapping`, `view salesforce mapping`, `administer salesforce mapped objects`. The UI to build mappings lives in `salesforce_mapping_ui`.

---

- Map Drupal Users to Salesforce Contacts (or Leads, Accounts, etc.).
- Map a content type to a custom Salesforce object.
- Choose which events sync: create, update, delete, in each direction (sync_triggers).
- Map individual Drupal fields/properties to Salesforce fields (field_mappings).
- Set the Salesforce upsert key field so records match on an external id.
- Push asynchronously via the queue (async) rather than synchronously on save.
- Always upsert instead of separate create/update.
- Map the Salesforce record type via the record_type field plugin.
- Track which Drupal entity corresponds to which Salesforce record (mapped object).
- Keep a revision history of mapped objects for auditing.
- Limit push batch size / retries / frequency per mapping.
- Filter pulled records with a pull_where_clause or record-type filter.
- Base pull on a trigger date field (pull_trigger_date).
- Restrict mapping administration with dedicated permissions.
- Provide the data model that push and pull operate on.
- Add a custom field-mapping plugin for special transforms.
- Represent an unavailable Salesforce field safely with the broken plugin.
- Map multiple Drupal bundles to different Salesforce objects.
- Export mappings as config for deployment across environments.
- Support standalone queue processing per mapping.
- Drive webform submissions into Salesforce (with salesforce_webform field plugins).
- Seed example mappings (see salesforce_example).
