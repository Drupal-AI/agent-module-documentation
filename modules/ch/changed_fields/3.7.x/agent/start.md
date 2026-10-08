<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Changed Fields API (changed_fields) — agent index

Developer library that reports **which fields of a content entity actually changed** on save,
so custom code can react to a specific field change instead of hand-diffing `$entity` against
`$entity->original`. Built on the SPL observer pattern (`EntitySubject` = `\SplSubject`,
`ObserverInterface` = `\SplObserver`) with a pluggable per-field-type comparison layer
(the `FieldComparator` plugin type). Enabling the module alone does nothing — other code drives it.

- No routes, **no settings page**, no permissions, no config, no drush, no config schema, no runtime dependencies.
- Core: `^8 || ^9 || ^10 || ^11`. `.info.yml` `version: '8.x-3.7'`.

## Solution docs
- **Detect which fields changed and react to it (the observer API + DTO)** → [api/entity-subject.md](api/entity-subject.md)
- **Support a custom/extra field type, or override "what changed means" (FieldComparator plugin)** → [plugins/field-comparator.md](plugins/field-comparator.md)

## Key facts (real machine names)
- Plugin-manager service: `plugin.manager.changed_fields.field_comparator` → `Drupal\changed_fields\FieldComparatorPluginManager`.
- Subject/DTO class: `Drupal\changed_fields\EntitySubject` (`implements \SplSubject`); observers implement `Drupal\changed_fields\ObserverInterface` (`extends \SplObserver`).
- Default comparator plugin id: `default_field_comparator` → `Drupal\changed_fields\Plugin\FieldComparator\DefaultFieldComparator`.
- Plugin type `FieldComparator`: plugin dir `Plugin/FieldComparator`, base `@Plugin` annotation (id only), alter hook `changed_fields_field_comparators_info`, cache key `changed_fields_plugins`.
- Driver hook is yours to write: examples call the API from `hook_entity_presave()`.
- Example submodules (the real usage docs): `changed_fields_basic_usage`, `changed_fields_extended_field_comparator` under `examples/`.
