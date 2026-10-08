# Field Encrypt — agent index

Transparently encrypts selected **field properties** at rest using an Encrypt-module
encryption profile. Depends on `encrypt` (and `field`). Configure route
`field_encrypt.settings` (`/admin/config/system/field-encrypt`). One restricted permission:
`administer field encryption`. Config schema present; no Drush; no plugin types.

Core state model: encryption is a **third-party setting on the field STORAGE**
(`field.storage.<entity>.<field>.third_party.field_encrypt`: `encrypt: true`, `properties: [...]`).
A global `encryption_profile` must be selected first or the encrypt checkbox never appears.

- **Encrypt/decrypt a specific field — where the setting lives, UI + config + batch** →
  [configure/encrypt-a-field.md](configure/encrypt-a-field.md)
- **Global settings form, encryption profile, uncacheable option, entity-type profile switch, routes** →
  [configure/settings.md](configure/settings.md)
- **How it works at runtime (services, placeholders, `encrypted_field_storage` base field, queue)** →
  [api/services.md](api/services.md)
- **`hook_field_encrypt_allow_encryption()` — veto encryption per entity** →
  [hooks/allow-encryption.md](hooks/allow-encryption.md)
- **The `administer field encryption` permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- No encryption happens until `field_encrypt.settings:encryption_profile` is set to a valid
  encryption profile (an `encrypt` module entity, typically Key-backed).
- Turning encryption on/off for a field that already has data **queues a batch re-encryption**
  (`field_encrypt_update_entity_encryption`), run at
  `/admin/config/system/field-encrypt/process-queues` or via cron.
- Ciphertext is stored in an `encrypted_field_storage` base field the module installs on each
  affected entity type; the real SQL columns hold a placeholder. Affected entity types are
  excluded from persistent caches when `make_entities_uncacheable` is TRUE (default).
