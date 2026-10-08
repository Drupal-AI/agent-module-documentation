# Runtime mechanism & services

Two services (both autowired), plus one event subscriber. No plugin types, no Drush.

## Services

- `field_encrypt.process_entities` → `\Drupal\field_encrypt\ProcessEntities`
  (alias: the class name). Does the actual encrypt/decrypt on entity save/load.
  - `encryptEntity(ContentEntityInterface $entity): void`
  - `decryptEntity(ContentEntityInterface $entity): void`
  - `entitySetCacheTags(ContentEntityInterface $entity, array &$build): void`
  - Constant `ProcessEntities::ENCRYPTED_FIELD_STORAGE_NAME` = the base field
    (`encrypted_field_storage`) where ciphertext is kept.
- `field_encrypt.state_manager` → `\Drupal\field_encrypt\StateManager`
  - `update()` — installs/removes the `encrypted_field_storage` base field per entity type and
    records affected entity types in key-value (`field_encrypt:entity_types`); invalidates the
    container and clears entity-type caches.
  - `getEncryptedEntityTypes()`, `removeStorageFields()`,
    `onFieldEncryptSettingsCacheChange()`.
- `\Drupal\field_encrypt\EventSubscriber\ConfigSubscriber` — reacts to config save/delete.

## How a value gets encrypted

1. You set `encrypt: true` (+ `properties`) on `field.storage.<type>.<field>` and save.
2. `ConfigSubscriber::onConfigSave()` sees the `field.storage.` prefix →
   `onFieldStorageChange()`:
   - calls `StateManager::update()` → installs the `encrypted_field_storage` base field on the
     entity type (a schema change) and marks the type affected;
   - if the field `hasData()`, queues each affected entity id into the
     `field_encrypt_update_entity_encryption` queue and messages the admin to process it.
3. On entity **presave**, `ProcessEntities::encryptEntity()` encrypts each configured property
   with the selected encryption profile, writes the ciphertext into `encrypted_field_storage`,
   and puts a **placeholder** into the normal field's SQL columns.
4. On entity **load** (`hook_entity_storage_load`), `decryptEntity()` reads the ciphertext back
   and restores the real values in memory.
5. If `make_entities_uncacheable` is TRUE, affected entity types are marked non-persistent-cache
   so plaintext is never cached.

## Vetoing encryption at runtime

Other modules can prevent encryption for a specific entity instance via
`hook_field_encrypt_allow_encryption()` — see [../hooks/allow-encryption.md](../hooks/allow-encryption.md).
It cannot *add* encryption; it only stops a would-be-encrypted entity from being encrypted.

## Inspecting encrypted fields programmatically

```php
// Which entity types currently have encrypted fields?
$types = \Drupal::service('field_encrypt.state_manager')->getEncryptedEntityTypes();

// Is a given field storage encrypted?
$fs = \Drupal\field\Entity\FieldStorageConfig::loadByName('node', 'field_fe_secret');
$on = (bool) $fs->getThirdPartySetting('field_encrypt', 'encrypt', FALSE);
$props = $fs->getThirdPartySetting('field_encrypt', 'properties', []);
```
