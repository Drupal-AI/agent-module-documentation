<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Condition Field — agent index

Adds a `condition_field` field type that stores core **Condition plugin** configurations on an
entity. It does NOT evaluate them — you read the field and resolve the conditions in your own code.
No configure route, no permissions, no Drush.

- **The field type, widget, formatter, and per-field `enabled_plugins` setting** →
  [configure/field.md](configure/field.md)
- **Reading & evaluating stored conditions (`ConditionAccessResolver`, plugin.manager.condition)** →
  [api/evaluate.md](api/evaluate.md)

Key facts:
- Field type: `condition_field` (default widget `condition_field_default`, default formatter
  `condition_field_string`). Depends only on core `field`.
- Per-field setting `enabled_plugins` (schema `field.field_settings.condition_field`) picks which
  condition plugins are offered; value stored as serialized `conditions` blob (schema
  `field.value.condition_field`).
- Always-skipped conditions: `ConditionFieldItem::SKIP_CONDITION_IDS` = `node_type`,
  `current_theme`, `webform`, `entity_bundle:webform_submission` (+ `language` on monolingual sites).
- Evaluate with `Drupal\condition_field\ConditionAccessResolver::checkAccess($conditions, 'and'|'or')`.
