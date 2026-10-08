<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Fixed Block Content block plugin

The module exposes **one placeable block per fixed block**, via a derived core Block plugin. You
don't write plugins for this module — you create `fixed_block_content` config entities and the
derivative produces the blocks.

## Plugin

- Base plugin: `Drupal\fixed_block_content\Plugin\Block\FixedBlockContentBlock`
  - `@Block(id = "fixed_block_content", admin_label = "Fixed custom block",
    category = "Fixed custom", deriver = ...\Plugin\Derivative\FixedBlockContent)`
- Derived plugin id: **`fixed_block_content:<fixed_block_id>`** (one per fixed block entity).
- Deriver (`Plugin\Derivative\FixedBlockContent`) iterates all `fixed_block_content` entities and
  emits a derivative each, setting `admin_label` to the fixed block's label and adding the fixed
  block as a config dependency.

## Behavior

- `build()` loads the fixed block's linked custom block (`FixedBlockContent::load(derivativeId)->getBlockContent()`)
  and renders it with the block_content view builder in the configured `view_mode`.
- `blockForm()` adds a **View mode** select (options from
  `getViewModeOptionsByBundle('block_content', <bundle>)`); stored as `view_mode` in the block
  plugin configuration. Hidden when the bundle has only one view mode.
- `getCacheTags()` merges the fixed block's and the linked block content's cache tags so the
  placement invalidates correctly when either changes.

## Placing one (scriptable)

```php
// After a fixed_block_content entity 'footer_cta' exists:
$block = \Drupal\block\Entity\Block::create([
  'id' => 'footer_cta_block',
  'plugin' => 'fixed_block_content:footer_cta',
  'region' => 'footer',
  'theme' => \Drupal::config('system.theme')->get('default'),
  'settings' => ['id' => 'fixed_block_content:footer_cta', 'view_mode' => 'full'],
]);
$block->save();
```

Or just place it through *Structure → Block layout* under the **Fixed custom** category.
