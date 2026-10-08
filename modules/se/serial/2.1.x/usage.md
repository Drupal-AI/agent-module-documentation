Serial defines an atomic auto-increment field type for Drupal entities: each new entity of a bundle gets the next sequential integer (per entity-type + bundle + field), useful for invoice numbers, ticket IDs, membership numbers and similar counters.

---

The module provides a `serial` field type (`SerialItem`) with a hidden/automatic widget (`serial_default_widget`, label "Hidden (Automatic)") and a `serial_default_formatter`. The value is computed on save, not entered by editors: `SerialItem::preSave()` calls the `serial.sql_storage` service (`SerialSQLStorage`, implementing `SerialStorageInterface`) to allocate the next number atomically. Atomicity is achieved with a per-field **assistant table** named `serial_<md5(entityType_bundle_field)>` that has a real MySQL `AUTO_INCREMENT` (`sid`) column: a temporary row is inserted inside a transaction to claim a unique `sid`, and old rows are periodically pruned. Assistant tables are created/dropped automatically when a serial field is added/removed (`hook_ENTITY_TYPE_create/delete` on `field_config`, plus `hook_schema`). Two storage settings, set when the field is created, control it: `start_value` (default 1 — the first number) and `init_existing_entities` (0/1 — whether to back-fill existing entities of the bundle with serial values on creation). The field is not translatable-by-design and resets on node clone (`hook_clone_node_alter`). It depends only on core's Field module, provides config schema for its storage settings, and has no admin settings page, permissions, Drush commands, or plugin types of its own.

---

- Auto-number invoices with a sequential invoice number field.
- Generate incrementing ticket or case IDs on a support content type.
- Assign membership numbers to new member entities automatically.
- Produce sequential order or reference numbers independent of Drupal's internal entity IDs.
- Give each submission of a form/content type a human-friendly running number.
- Start a counter at a specific number (e.g. invoices beginning at 1000) via `start_value`.
- Back-fill an existing content type's entities with serial numbers using `init_existing_entities`.
- Keep a per-bundle sequence so different content types have independent counters.
- Guarantee uniqueness and atomicity under concurrent creates via the AUTO_INCREMENT assistant table.
- Display the serial value read-only with the serial default formatter.
- Keep the number out of the edit form (the widget is hidden/automatic).
- Number catalog items sequentially as they are added.
- Assign sequential certificate or badge numbers.
- Create a running registration number for event signups.
- Provide a stable public-facing sequential identifier separate from node IDs.
- Sort or reference content by its creation sequence via the indexed serial column.
- Number taxonomy terms or users sequentially by attaching a serial field to those entities.
- Reset the serial value when cloning a node so the copy gets a fresh number.
- Build an audit/log entity where each record carries an incrementing sequence number.
- Migrate legacy sequential identifiers by choosing an appropriate starting value.
