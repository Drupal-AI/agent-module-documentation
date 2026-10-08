# Base fields added to the coupon entity

The module adds two **base fields** to the `commerce_promotion_coupon` entity. They are defined in
`Coupon::baseFieldDefinitions()` (`src/Entity/Coupon.php`) and their storage is installed/removed by
`hook_install` / `hook_uninstall` (`commerce_coupon_conditions.install`) through
`\Drupal::entityDefinitionUpdateManager()->installFieldStorageDefinition()` /
`uninstallFieldStorageDefinition()`. They are entity base fields, not exported config — the module
ships no `config/schema` and no config objects.

| Machine name | Field type | Cardinality | Required | Default | Form widget (weight) | Widget settings |
| --- | --- | --- | --- | --- | --- | --- |
| `conditions` | `commerce_plugin_item:commerce_condition` | unlimited | no | — | `commerce_conditions` (6) | `entity_types: ['commerce_order']` |
| `condition_operator` | `list_string` | 1 | yes | `AND` | `options_buttons` (7) | allowed values `AND` = "All conditions must pass", `OR` = "Only one condition must pass" |

Notes:

- `conditions` reuses Commerce's `commerce_plugin_item:commerce_condition` field type and the
  `commerce_conditions` widget, so the coupon edit form shows the same condition UI as promotions,
  but limited to `commerce_order` conditions (the `entity_types` widget setting). No new
  `@CommerceCondition` plugin is registered by this module.
- `condition_operator` is `setDisplayConfigurable('form', TRUE)`; `conditions` is not display-configurable.
- Because these are base-field storage definitions, run `drush entity:updates` / `drush cr` (or a
  config/entity-definition update) after enabling if the fields do not appear on existing sites.
