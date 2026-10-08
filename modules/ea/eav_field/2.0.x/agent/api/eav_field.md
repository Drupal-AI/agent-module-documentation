<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EAV Field — programmatic surface

**Load attributes** via the custom `eav_attribute` storage:
```php
$storage = \Drupal::entityTypeManager()->getStorage('eav_attribute');
$storage->loadByCategory($term_id);            // + parents by default
$storage->loadByCategory(NULL);                // global (no category) attributes
$storage->loadByHostEntityCategory($node);     // global + host's category attributes
$storage->loadByProperties(['category' => $ids]);
```
- `EavValueStorage::loadMultiple()` sets value fields to unlimited cardinality so all stored values load.
- Deleting an `eav_attribute` fires `eav_field_eav_attribute_delete()` which queues its value entities into the `DeleteEavValueEntities` QueueWorker for cleanup on cron.
- `EavFieldSearchApiProcessor` exposes EAV values as Search API properties for indexing.
- `EavAttributeDevelGenerate` (Devel Generate plugin) creates sample attributes.

All queries go through the entity query builder / `SqlContentEntityStorage`; there is no raw SQL and value field names come from the code-defined `EavValue::getFieldTypes()`, not request input.