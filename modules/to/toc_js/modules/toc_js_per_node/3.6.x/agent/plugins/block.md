<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block plugin: `toc_js_per_node_block`

`Drupal\toc_js_per_node\Plugin\Block\TocJsPerNodeBlock` extends the Toc.js block
(`Drupal\toc_js\Plugin\Block\TocJsBlock`).

```php
@Block(
  id = "toc_js_per_node_block",
  category = @Translation("Toc js"),
  admin_label = @Translation("Toc.js per node block"),
)
```

## Extra setting

- `override_nodetype` (bool, default TRUE) — "Override node type configuration". Its block form adds
  this checkbox plus a "Custom configuration" details group (the full Toc.js settings via
  `TocJsService::getTocForm()` under `['settings','custom_configuration']`), shown only when
  `override_nodetype` is checked.

Config schema `block.settings.toc_js_per_node_block` extends `block.settings.toc_js_block` and adds
`override_nodetype`.

## build()

For the current route node:

- Respects the per-node flag: if the node type has `toc_js_per_node.override` on and the node's
  `toc_js_active` is empty, it renders nothing (using `override_default` when the field is unset).
- If the node type's Toc.js is disabled, renders nothing.
- Then uses **this block's** settings when `override_nodetype` is TRUE, otherwise the **node type's**
  Toc.js settings (`getConfigurationFromNodeType()`), and calls `TocJsService::buildToc()`.
- On non-node routes it falls back to the parent Toc.js block behavior.

## Place it (config)

```php
\Drupal\block\Entity\Block::create([
  'id' => 'tocjspn_block',
  'plugin' => 'toc_js_per_node_block',
  'theme' => \Drupal::config('system.theme')->get('default'),
  'region' => 'content',
  'settings' => ['id' => 'toc_js_per_node_block', 'label' => 'TOC', 'label_display' => '0', 'override_nodetype' => TRUE]
    + \Drupal::service('toc_js.service')->defaultSettings(),
])->save();
```
