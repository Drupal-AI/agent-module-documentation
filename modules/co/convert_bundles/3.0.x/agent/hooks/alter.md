<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `hook_convert_bundle_alter()`

The only hook the module invites (`convert_bundles.api.php`). It fires once per entity, in
`ConvertBundles::addNewFields()`, **just before the converted entity is saved** — after the
bundle column has been rewritten and mapped field values copied.

```php
/**
 * Alter an entity while its bundle is being converted.
 *
 * @param \Drupal\Core\Entity\EntityInterface $old_entity
 *   The original entity (old bundle, original field values).
 * @param \Drupal\Core\Entity\EntityInterface &$new_entity
 *   The entity already switched to the new bundle with mapped fields; adjust it here.
 */
function hook_convert_bundle_alter(EntityInterface $old_entity, EntityInterface &$new_entity): void {
  // e.g. reparent a taxonomy term when converting it.
  if ($old_entity instanceof \Drupal\taxonomy\TermInterface
      && $new_entity instanceof \Drupal\taxonomy\TermInterface) {
    $new_entity->set('parent', ['target_id' => 123]);
  }
}
```

Invoked via `\Drupal::service('module_handler')->alter('convert_bundle', $old_entity, $entity);`
(note the singular alter name `convert_bundle`). Use it to set values the field mapping can't
express, enforce defaults on the target bundle, or copy data between differently-shaped fields.
