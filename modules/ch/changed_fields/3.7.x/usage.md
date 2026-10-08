<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Changed Fields API tells a developer **which fields actually changed** on an entity save, replacing the usual hand-written comparison of `$entity` against `$entity->original`.

---

Reacting to a specific field changing is one of the most common things custom Drupal code does, and one of the most commonly done wrong: comparing `$entity->get('field_x')->value` to `$entity->original->get('field_x')->value` works for a simple scalar and quietly fails for multi-value fields, entity references, dates with timezones and anything with several columns per delta. This module supplies the comparison as infrastructure. It uses the observer pattern — `EntitySubject` with `ObserverInterface`, so consumers register as observers and receive a structured list of what changed — and makes comparison itself pluggable through a **FieldComparator** plugin type (`FieldComparatorPluginManager`), so a field type with unusual semantics can define what "changed" means for it. Two example submodules ship in `examples/`: `changed_fields_basic_usage` and `changed_fields_extended_field_comparator`, which are the practical documentation. There are no routes, permissions, configuration or dependencies, and the core range is a wide `^8 || ^9 || ^10 || ^11`. This is a developer library — enabling it alone changes nothing.

---

- React only when a specific field changes.
- Avoid hand-comparing an entity to its original.
- Detect changes in multi-value fields correctly.
- Trigger an email when a status field changes.
- Notify an external system on a price change.
- Compare entity reference fields reliably.
- Define what "changed" means for a custom field type.
- Skip expensive work when nothing relevant changed.
- Log which fields an editor modified.
- Invalidate a cache only on relevant changes.
- Re-index only when indexed fields change.
- Fire a workflow transition on a field change.
- Reduce duplicated comparison code.
- Handle date fields with timezones correctly.
- Learn the API from the shipped examples.
- Observe changes from several modules at once.
- Queue an outbound sync on specific changes.
- Audit field-level edits.
