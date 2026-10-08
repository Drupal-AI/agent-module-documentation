Denormalizer flattens Drupal content entities and webform submissions into plain SQL tables that external BI/ETL tools can query without understanding Drupal's field storage.

---

The module lets an administrator define one or more "Denormalizer table" configuration entities. Each defines a source (an entity type + bundle, with base and bundle fields chosen individually, or a "non entity" plain table that is currently not implemented). Saving an entity-source table runs a batch that creates a dedicated `denormalizer_<id>` database table whose columns are `<field>__<property>` pairs derived from each field's own schema, then SELECTs every matching entity into it. From then on the table is kept in sync: `hook_entity_insert/update/delete` queue per-entity work items processed by the `denormalizer_queue` queue worker, and `hook_cron()` (when enabled) re-queues all rows either incrementally ("run every") or as a full reload ("reload every"). A global settings form at `/admin/config/development/denormalizer` chooses SQL mode (views vs tables), which database to target, prefixes, and cron cadence. All administration is gated by the restricted `administer denormalizer` permission. Webform submissions get special handling that flattens each element — including multi-value checkboxes and likert questions — into its own column.

---

- Feed a data-warehouse or BI tool (Tableau, Power BI, Metabase, Superset) flat tables of Drupal content without teaching it Drupal's entity/field joins.
- Expose node content of a specific bundle as a single wide table with one column per field property.
- Denormalize webform submissions so each form element becomes a queryable column for reporting.
- Flatten multi-value fields into comma-joined column values in one row per entity.
- Break multi-value webform checkboxes and likert questions into one column per option/question.
- Keep the denormalized table continuously in sync as editors create, update, and delete content (via the queue worker).
- Schedule incremental refreshes on cron with a configurable "run every" interval.
- Schedule periodic full reloads on cron with a "reload every" interval that rebuilds from scratch.
- Choose exactly which base fields and bundle fields land in the export, or include all of them by leaving the selection empty.
- Always include entity-key fields (id, uuid, bundle, etc.) automatically as they are force-selected and disabled in the form.
- Give each table its own primary key based on the source entity's id field.
- Index the chosen base-field columns for faster downstream querying.
- Point denormalized output at an external/separate database so a BI/ETL tool can be granted access to only that data.
- Apply a configurable database prefix (e.g. `dw_`) when writing to an external database.
- Use a view prefix to avoid clobbering existing tables when denormalizing into the local database.
- Review row counts of every denormalizer table from the collection list builder at `/admin/structure/denormalizer-tables`.
- Enable or disable an individual denormalizer table via its status radios without deleting it.
- Bulk-populate a newly created table across large datasets using chunked batch operations (1000 entities per chunk).
- Render cron intervals as human-friendly duration widgets when the `duration_field` module is installed.
- Automatically drop the backing `denormalizer_<id>` table when the config entity is deleted.
- Provide a data source for downstream tools such as Views Fast Field or Singer catalog exports.
