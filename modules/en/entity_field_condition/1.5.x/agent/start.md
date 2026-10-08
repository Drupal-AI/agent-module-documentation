<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Field Condition — agent index

Defines one **Condition plugin `node_field`** that checks whether a node in context has a
chosen field whose value is NULL / equals / contains a given string. Most-used for **block
visibility**. No settings form (`configure: null`), no permissions, no Drush.

- **The `node_field` condition: config keys, value sources, how it evaluates, and how to attach it (e.g. to a block's `visibility`)** →
  [plugins/node-field-condition.md](plugins/node-field-condition.md)

Key facts:
- Plugin id `node_field`, requires a `node` context; class `Drupal\entity_field_condition\Plugin\Condition\NodeField`.
- Config keys: `entity_type_id` (always `node`), `entity_bundle` (or `''` = any), `field`, `value_source` (`null`|`specified`|`contains`), `value`.
- Stored inside the host object's config — for a block that is `block.block.<id>` → `visibility.node_field`.
- Config schema id: `condition.plugin.node_field`.
