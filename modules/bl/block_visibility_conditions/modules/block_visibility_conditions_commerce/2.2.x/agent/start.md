<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# block_visibility_conditions_commerce — agent start

Submodule of **block_visibility_conditions**. Ships one Condition plugin: `not_product_type`
("Not Product Type"), class `NotProductType extends NotConditionPluginBase` with
`CONTENT_ENTITY_TYPE = 'commerce_product_type'`. Requires the parent module and
`commerce:commerce_product`. Not auto-enabled by the parent's update hook.

Hides a block only on the checked product types' pages; shows it on all other pages.
Configured per block in the core Block layout / Layout Builder visibility form — no settings
page, no permissions, no Drush.

- Configuring the condition + config storage → parent doc [../../../../2.2.x/agent/configure/block_visibility_conditions.md](../../../../2.2.x/agent/configure/block_visibility_conditions.md)
- Plugin internals / how to extend the base class → parent doc [../../../../2.2.x/agent/plugins/block_visibility_conditions.md](../../../../2.2.x/agent/plugins/block_visibility_conditions.md)
