# Blocks — FluidUI toolbox as a placeable block

`\Drupal\fluidui\Plugin\Block\FluidUIBlock` (annotation `@Block`, id **`fluidui_block`**,
admin label "FluidUI Block") lets you place the preferences toolbox in any theme region instead of
the fixed top-of-page position.

```php
public function build() {
  return ['#theme' => 'fluid_ui_block'];   // same template as the page_top render
}
```

Cache metadata: `getCacheContexts()` adds `ip`; `getCacheTags()` adds `node_list`.

## When to use it

By default (`fluidui_as_block = 0`) `hook_page_top` auto-renders the toolbox at the top of every
non-admin page, so **you do not need the block**. To position it yourself:

1. Set `fluidui_as_block = 1` (see [configure/settings.md](../configure/settings.md)) — this stops
   the automatic `page_top` render.
2. Place the **FluidUI Block** in a region via `/admin/structure/block` (or a
   `block.block.*` config entity).

The block only outputs the toolbox markup; the Infusion CSS/JS libraries are still attached by
`fluidui_preprocess_page()` (gated by `admin_display` / `url_blacklist`), so the widget stays
functional wherever the block is placed.
