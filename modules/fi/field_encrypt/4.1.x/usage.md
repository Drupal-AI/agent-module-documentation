Field Encrypt extends the Field API so that selected properties of a field are transparently encrypted before being written to the database and decrypted when loaded, using an Encrypt module encryption profile. It protects sensitive field data at rest without changing how fields are used in code or the UI.

---

The module works by storing per-field-storage **third-party settings** (`field.storage.<entity>.<field>.third_party.field_encrypt`: `encrypt: true` plus a list of `properties`) that mark which field properties to encrypt. A checkbox "Encrypt field" (and a properties checklist) is added to the *field storage* edit form — but only after you pick a global **encryption profile** at `/admin/config/system/field-encrypt` (`field_encrypt.settings:encryption_profile`), which is required before any encryption happens. At runtime the `ProcessEntities` service hooks entity load/save (`hook_entity_storage_load`, presave) and, per encrypted field, replaces the real value in the SQL columns with a placeholder while the ciphertext is kept in a dedicated `encrypted_field_storage` base field that Field Encrypt installs on each affected entity type. Because unencrypted values must not leak into caches, `make_entities_uncacheable` (default TRUE) excludes affected entity types from persistent render/entity caches. Changing a field's encryption settings on a field that already has data queues a **batch/queue re-encryption** (`field_encrypt_update_entity_encryption` queue, processed at `/admin/config/system/field-encrypt/process-queues` or via cron); entity-type-wide updates and profile switches are driven from `/admin/config/system/field-encrypt/entity-types/*`. A single permission, `administer field encryption` (restricted), gates all of this. `hook_field_encrypt_allow_encryption()` lets other modules veto encryption for a given entity instance. Base fields can also be encrypted, tracked in `field_encrypt.entity_type.*` config entities.

---

- Encrypt a "Social Security number" or national-ID text field so its value is unreadable in the database.
- Protect stored API keys or access tokens held in a custom entity field.
- Encrypt the body/summary of unpublished draft content that contains sensitive notes.
- Store customer PII (phone, email, address `link`/`string` properties) encrypted at rest for GDPR.
- Encrypt only specific properties of a field — e.g. a link field's `uri` but not its `title`.
- Turn on encryption for an existing populated field and run the batch to re-encrypt all rows.
- Switch every encrypted field on an entity type to a new encryption profile after key rotation.
- Decrypt a field back to plaintext via the field-decrypt confirmation flow when encryption is no longer needed.
- Choose which field properties are encrypted by default per field type on the settings form.
- Keep encrypted entity types out of persistent caches so plaintext never lands in cache tables.
- Encrypt a base field (e.g. a node's title) via the entity-type settings, not just configurable fields.
- Comply with "encryption of data at rest" audit requirements without a database-level TDE solution.
- Prevent a leaked database dump from exposing sensitive field contents (ciphertext only).
- Use a Key-module-backed encryption profile (AES) so key material lives outside the codebase.
- Conditionally skip encryption for published nodes using `hook_field_encrypt_allow_encryption()`.
- Encrypt medical or financial notes fields on a healthcare/fintech Drupal site.
- Add field-level confidentiality to a commerce order's custom fields.
- Queue and process re-encryption of large data sets through cron rather than a blocking batch.
- Configure the re-encryption batch size (`batch_size`) to tune performance on big tables.
- Read back which fields on a site are encrypted by inspecting `field.storage.*` third-party settings.
- Protect free-text "internal comments" fields visible only to staff, encrypted in storage.
- Migrate a site to encrypted storage for a subset of fields while leaving others in plaintext.
- Ensure exported configuration records exactly which properties of which fields are encrypted.
- Provide defense-in-depth alongside filesystem/disk encryption for the most sensitive columns.
