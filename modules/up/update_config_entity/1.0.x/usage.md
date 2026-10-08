<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Update Config Entity is a one-command repair tool for a specific Drupal error — *"A non-existent config entity name returned by FieldStorageConfigInterface::getBundles()"* — caused by a stale entry left in Drupal's bundle field map after a bundle is removed.

---

Drupal keeps a key-value store, `entity.definitions.bundle_field_map`, mapping each entity type's fields to the bundles that use them. If a bundle disappears without the map being updated — an uninstall that did not clean up, a botched migration, a deleted comment type — the map still claims a field exists on a bundle that no longer does, and Drupal throws the `getBundles()` error on cache rebuild or field UI access. There is no UI for editing that store, which is why this module exists: a single Drush command, `update:correct-field-config-storage`, takes an entity type, a bundle and a field name, loads `entity.definitions.bundle_field_map` from the `keyvalue` service, unsets `$map[$field_name]['bundles'][$bundle]`, and writes it back. That is the entire module — no hooks, no config, no permissions, no schema, one Drush service and one class. It is a surgical fix, so you need to know which entity type/bundle/field is stale, which the error message itself normally tells you.

---

- Fix the "non-existent config entity name returned by getBundles()" fatal.
- Clean a stale bundle entry after removing a comment type.
- Repair the field map after an incomplete module uninstall.
- Unblock a cache rebuild that fails on a missing bundle.
- Recover a site after a failed migration left orphaned field references.
- Remove a field-to-bundle mapping without touching the database directly.
- Fix Field UI pages that error on a deleted bundle.
- Clear the error blocking `drush cr` on a production site.
- Repair the map after deleting a content type outside the UI.
- Restore access to the entity field manager after corruption.
- Avoid hand-editing the key-value table with SQL.
- Script the repair as part of a recovery runbook.
- Resolve errors after removing a contrib module that defined bundles.
- Clean up several stale mappings by running the command repeatedly.
- Diagnose which bundle is stale from the error message and fix it.
- Unblock config import that fails on the field map.
- Recover a site cloned from an environment with different bundles.
- Fix an entity type left half-removed by a failed update hook.
- Keep the repair auditable via a Drush command rather than manual SQL.
- Restore normal Field UI operation after the fix.
