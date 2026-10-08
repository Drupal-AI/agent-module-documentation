<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conflict hooks

From `conflict.api.php`:

## `hook_conflict_paths_alter(array &$conflict_paths, FormStateInterface $form_state)`

Alter the set of detected conflict paths **before** conflict resolution starts.

- `$conflict_paths` — conflict paths keyed by the path, each value being entity metadata
  (`entity_type`, `entity_id`).
- `$form_state` — the main form state.

```php
function mymodule_conflict_paths_alter(array &$conflict_paths, \Drupal\Core\Form\FormStateInterface $form_state) {
  // Example: ignore conflicts on a field you don't care about.
  foreach ($conflict_paths as $path => $meta) {
    if (str_contains($path, 'field_internal_note')) {
      unset($conflict_paths[$path]);
    }
  }
}
```

Use it to add, remove, or re-key conflict paths (e.g. suppress conflicts for certain fields, or
inject additional ones). This is the only hook Conflict invites; deeper customization is done via
the `entity_conflict.discovery` / `entity_conflict.resolve` events and `FieldComparator` plugins
(see [../api/services-events.md](../api/services-events.md) and
[../plugins/field-comparator.md](../plugins/field-comparator.md)).
