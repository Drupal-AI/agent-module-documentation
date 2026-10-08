# Global settings, routes & profile switching

Configure route: `field_encrypt.settings` → `/admin/config/system/field-encrypt`
(form `\Drupal\field_encrypt\Form\SettingsForm`, permission `administer field encryption`).
Editable config object: `field_encrypt.settings`.

## `field_encrypt.settings` keys

| Key | Default | Meaning |
|---|---|---|
| `encryption_profile` | `''` | **Required** to enable any encryption. Machine name of an Encrypt-module `encryption_profile` entity. New entities/revisions always use this profile. The "Encrypt field" checkbox on field-storage forms only appears once this is set. |
| `make_entities_uncacheable` | `true` | Exclude entity types that have encrypted fields from persistent (render/entity) caches, so plaintext never lands in cache tables. Changing it re-runs `StateManager` cache-info updates. |
| `default_properties` | per-type map | Which properties are pre-checked per field type on the encrypt form, e.g. `string: [value]`, `text_with_summary: [value, summary]`, `link: [uri, title]`, `telephone: [value]`. |
| `batch_size` | `5` | Number of entities processed per batch step during re-encryption. |

Read/set examples:

```bash
drush cget field_encrypt.settings encryption_profile
drush cset field_encrypt.settings encryption_profile my_aes_profile -y
drush cset field_encrypt.settings make_entities_uncacheable 1 -y
```

## All routes (all require `administer field encryption`)

| Route | Path | Purpose |
|---|---|---|
| `field_encrypt.settings` | `/admin/config/system/field-encrypt` | Global settings form (profile, uncacheable, defaults, batch size). |
| `field_encrypt.settings.entity_type` | `/admin/config/system/field-encrypt/entity-types/{entity_type_id}` | Per-entity-type settings; update existing entities/revisions to the current profile. |
| `field_encrypt.update_encryption_profile_confirm` | `.../entity-types/{entity_type}/update_encryption_profile/{encryption_profile}` | Confirm switching an entity type's data to a new profile (key rotation). |
| `field_encrypt.process_queue` | `/admin/config/system/field-encrypt/process-queues` | Run the queued re-encryption updates now. |
| `field_encrypt.field_overview` | `/admin/config/system/field-encrypt/field-overview` | Overview of encrypted fields. |
| `field_encrypt.field_decrypt_confirm` | `.../field-decrypt/{entity_type}/{field_name}/{base_field}` | Decrypt a field back to plaintext. |

## Encryption profiles come from the `encrypt` module

`encryption_profile` values are `encrypt` module `encryption_profile` config entities (each
references an encryption method + a Key entity). Create them at
`/admin/config/system/encryption/profiles` (or via the `encrypt`/`key` config). Field Encrypt
itself defines no profiles or keys — it only *uses* the one you select here.

## Base-field encryption

Encrypting a base field (not a configurable field) is tracked in `field_encrypt.entity_type.*`
config entities (`base_fields` map of field → properties), managed from the entity-type route
above.
