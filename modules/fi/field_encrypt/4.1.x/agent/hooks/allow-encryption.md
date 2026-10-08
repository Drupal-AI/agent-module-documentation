# `hook_field_encrypt_allow_encryption()`

The one hook Field Encrypt invites (declared in `field_encrypt.api.php`). It lets a module
**veto** encryption for a specific entity instance that would otherwise be encrypted.

```php
/**
 * Return FALSE to prevent this entity's fields from being encrypted.
 */
function mymodule_field_encrypt_allow_encryption(\Drupal\Core\Entity\ContentEntityInterface $entity) {
  // Example: only encrypt fields on UNPUBLISHED nodes.
  if ($entity instanceof \Drupal\node\Entity\Node && $entity->isPublished()) {
    return FALSE;
  }
  // Return nothing / TRUE to allow the configured encryption.
}
```

Semantics:

- Return **FALSE** → skip encryption for this `$entity`, even though its field storage is
  configured to encrypt. Any non-FALSE return (including `NULL`) allows it.
- It **cannot enable** encryption on a field that is not configured to encrypt — there are no
  settings for that. It only suppresses encryption on an entity whose fields are set up to be
  encrypted.
- Invoked from `ProcessEntities` during the encrypt path, per entity, so you can make the
  decision from live entity state (status, bundle, owner, a flag field, etc.).

There is no corresponding "force decrypt" hook; decryption always mirrors what was encrypted.
