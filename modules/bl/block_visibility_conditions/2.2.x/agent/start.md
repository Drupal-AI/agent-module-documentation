<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# block_visibility_conditions — agent start

Adds "Not {bundle}" block visibility **Condition** plugins (core condition plugin type). A block
with such a condition is hidden only on the selected bundles' pages and shown on every other page
(unlike core's negated bundle conditions, which vanish on non-entity pages). The parent module
ships only the abstract base class `NotConditionPluginBase`; concrete conditions come from the
optional submodules. No settings page (`configure` is null), no permissions, no Drush, no config
schema of its own.

- Add/configure a "Not" condition on a block (Block layout or Layout Builder), config storage → [configure/block_visibility_conditions.md](configure/block_visibility_conditions.md)
- Extend `NotConditionPluginBase` to create a "Not {bundle}" condition for any bundled entity type → [plugins/block_visibility_conditions.md](plugins/block_visibility_conditions.md)

Submodules (each ships one concrete condition):
- `block_visibility_conditions_node` → condition `not_node_type` (requires node)
- `block_visibility_conditions_taxonomy` → condition `not_taxonomy_vocabulary` (requires taxonomy)
- `block_visibility_conditions_commerce` → condition `not_product_type` (requires commerce_product)
