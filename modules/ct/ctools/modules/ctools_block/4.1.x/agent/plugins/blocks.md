# Blocks provided

`ctools_block` provides context-aware block plugins (not a new plugin *type*).

- **Entity Field** — `Plugin/Block/EntityField.php`, derived per entity-type + field by
  `Plugin/Deriver/EntityFieldDeriver.php` (plugin id `entity_field:<entity_type>:<field>`).
  Requires an `entity` context; renders one field with a selectable **field formatter**.
  Config schema `block.settings.entity_field:*:*` stores:
  `formatter.type`, `formatter.weight`, `formatter.region`, `formatter.label`,
  `formatter.settings` (per-formatter), `formatter.third_party_settings`.
- **Entity View** — `Plugin/Block/EntityView.php`, renders a whole entity from context in a
  chosen view mode.

These blocks are meant for context-driven systems (Panels, Page Manager). The module
implements `hook_plugin_filter_block_alter` to **remove** them from the Layout Builder block
chooser, since core provides equivalents there.

Placement is done through the consuming variant/block UI; there is no settings form of its own.
Access it programmatically via the block manager:

```php
$block = \Drupal::service('plugin.manager.block')
  ->createInstance('entity_field:node:body', ['formatter' => ['type' => 'text_default']]);
```
