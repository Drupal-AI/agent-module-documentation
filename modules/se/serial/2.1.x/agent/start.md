# Serial (serial) — agent index

Defines an **atomic auto-increment field type** (`serial`): new entities of a bundle get the
next sequential integer. No admin settings page, no permissions, no Drush, no plugin types
(`configure` = null). Depends only on core `field`. Configuration is per-field (add a Serial
field to a bundle via Field UI / config).

- **Adding a serial field, its storage settings (`start_value`, `init_existing_entities`),
  widget/formatter** → [configure/field.md](configure/field.md)
- **How allocation works (assistant tables, the `serial.sql_storage` service, atomicity)** →
  [api/storage.md](api/storage.md)

Key facts (grounded in `src/`):
- Field type **`serial`** (`SerialItem`); default widget **`serial_default_widget`**
  ("Hidden (Automatic)"); default formatter **`serial_default_formatter`**.
- Storage settings: **`start_value`** (default 1) and **`init_existing_entities`** (0/1),
  schema `field.storage_settings.serial`.
- Value assigned in `preSave()` via service **`serial.sql_storage`** using a per-field
  AUTO_INCREMENT assistant table `serial_<md5(entityType_bundle_field)>`.
