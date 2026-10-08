# Encrypt (or decrypt) a specific field

Encryption is stored as a **third-party setting on the field STORAGE config entity**, not on
the field instance and not in a settings form.

## Where the setting lives

Config: `field.storage.<entity_type>.<field_name>` → third-party setting under key
`field_encrypt`:

```yaml
third_party_settings:
  field_encrypt:
    encrypt: true
    properties:
      - value          # which field properties to encrypt (per field type)
```

Schema: `field.storage.*.*.third_party.field_encrypt` (`encrypt` bool, `properties` sequence,
`placeholders` sequence). Read it with:

```bash
drush cget field.storage.node.field_fe_secret third_party_settings.field_encrypt
```

## Prerequisite: pick an encryption profile

The "Encrypt field" checkbox is **only added** to the field-storage edit form when
`field_encrypt.settings:encryption_profile` is non-empty (see
[settings.md](settings.md)). Without a profile selected, nothing encrypts. The default
properties checked per field type come from `field_encrypt.settings:default_properties`
(e.g. `string`/`text` → `value`, `link` → `uri`+`title`).

## Via the UI

1. Go to *Configuration → System → Field Encrypt* and select an **Encryption profile**; Save.
2. Edit the field (its **storage** settings — Manage fields → the field → the storage/edit form).
   Under **Field encryption**, tick **Encrypt field**.
3. Check the **Properties** you want encrypted (defaults are pre-selected per field type).
4. Save. If the field already has data you get a warning and a batch re-encryption runs.

## Via code / drush (scriptable)

```php
$storage = \Drupal\field\Entity\FieldStorageConfig::loadByName('node', 'field_fe_secret');
$storage->setThirdPartySetting('field_encrypt', 'encrypt', TRUE);
$storage->setThirdPartySetting('field_encrypt', 'properties', ['value']);
$storage->save();   // triggers ConfigSubscriber -> queues re-encryption if data exists
```

Saving `field.storage.*` fires `field_encrypt`'s `ConfigSubscriber::onFieldStorageChange()`,
which (a) installs the `encrypted_field_storage` base field on that entity type via
`StateManager::update()` and (b) if the field already `hasData()`, queues every affected
entity into `field_encrypt_update_entity_encryption` for re-encryption.

## Turn encryption OFF (decrypt)

- In code: `unsetThirdPartySetting('field_encrypt', 'encrypt')` and
  `unsetThirdPartySetting('field_encrypt', 'properties')`, then `save()`.
- In the UI: untick **Encrypt field**, or use the field-decrypt confirmation flow
  `field_encrypt.field_decrypt_confirm`
  (`/admin/config/system/field-encrypt/field-decrypt/{entity_type}/{field_name}/{base_field}`).
  Existing rows are re-written as plaintext via the queue/batch.

## Run the re-encryption queue

After a change to a populated field, process the queued updates immediately:
`/admin/config/system/field-encrypt/process-queues` (route
`field_encrypt.process_queue`) — otherwise cron processes them. Tune throughput with
`field_encrypt.settings:batch_size`.
