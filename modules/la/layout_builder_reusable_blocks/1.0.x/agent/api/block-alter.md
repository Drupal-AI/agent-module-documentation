<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global block override — `hook_block_alter`

`layout_builder_reusable_blocks_block_alter(array &$definitions)` in the `.module` file:

```
foreach ($definitions as $plugin_id => &$definition) {
  if (strpos($plugin_id, 'block_content:') === 0) {
    $definition['class'] = 'Drupal\layout_builder_reusable_blocks\Plugin\Block\LayoutBuilderReusableContentBlock';
  }
}
```

## Effect

- Reassigns the `class` of **every** block plugin whose id starts with `block_content:` (i.e. every
  reusable content block derivative, one per `block_content` entity) to
  [LayoutBuilderReusableContentBlock](../plugins/reusable-content-block.md).
- This is **site-wide**, not scoped to Layout Builder — the override applies wherever those block
  plugins are used (Block layout / `admin/structure/block`, other consumers). The replacement class
  extends core `BlockContentBlock` and only adds behaviour inside a Layout-Builder-context guard plus
  the `allow_editing_reusable_blocks` setting, so outside Layout Builder it is functionally the core
  block.
- No opt-in: enabling the module changes the backing class for all `block_content:*` blocks
  immediately. There is no config toggle for the override itself.

## Agent implications

- If you subclass or expect the core `BlockContentBlock` class for `block_content:*` blocks, note it
  is replaced while this module is enabled.
- Disabling/uninstalling the module restores the core class (the alter simply stops running).
