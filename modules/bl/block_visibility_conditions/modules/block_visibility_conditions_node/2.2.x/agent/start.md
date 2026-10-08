<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# block_visibility_conditions_node — agent start

Submodule of **block_visibility_conditions**. Ships one Condition plugin: `not_node_type`
("Not Node Type"), class `NotNodeType extends NotConditionPluginBase` with
`CONTENT_ENTITY_TYPE = 'node_type'`. Requires the parent module and `node`.

Hides a block only on the checked node content types' pages; shows it on all other pages
(views, taxonomy, front page). Configured per block in the core Block layout / Layout Builder
"Configure block" visibility form — no settings page, no permissions, no Drush.

- Configuring the condition + config storage → parent doc [../../../../2.2.x/agent/configure/block_visibility_conditions.md](../../../../2.2.x/agent/configure/block_visibility_conditions.md)
- Plugin internals / how to extend the base class → parent doc [../../../../2.2.x/agent/plugins/block_visibility_conditions.md](../../../../2.2.x/agent/plugins/block_visibility_conditions.md)
