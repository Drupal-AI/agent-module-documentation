# Theme hook suggestions

Menu Block (`menu_block.module`) adds template suggestions so each block can have its own
markup without a preprocess hook.

## Block templates (`hook_theme_suggestions_block`)
For a `menu_block` block, in order of specificity:
- `block__system_menu_block` — added via `_alter` so menu_block blocks theme like core's.
- `block__menu_block__region_<region>` and `block__menu_block__<menu>__region_<region>` (when a region is set, e.g. by Context).
- `block__menu_block__<suggestion>` — from the block's **Theme hook suggestion** setting.
- `block__menu_block__<uuid>` — when a block uuid is present.

## Menu templates (`hook_theme_suggestions_menu`)
The plugin sets `#theme => 'menu'` and passes `#menu_block_configuration`, enabling:
- `menu__<menu_name>`
- `menu__region_<region>` and `menu__<menu_name>__region_<region>`
- `menu__<suggestion>` — from the **Theme hook suggestion** setting (field prefix `menu__`).
- `menu__<menu_name>__<uuid>`

## Other hooks
- `hook_theme_registry_alter` adds a `menu_block_configuration` variable to the `menu` theme hook.
- `hook_preprocess_block` sets the (possibly dynamic) block label, keeping it available to
  assistive tech even when `label_display` is off.
- `hook_plugin_filter_block_alter` hides the equivalent core `system_menu_block:*` in the
  Block UI / Layout Builder when a `menu_block:*` exists.

Create `templates/menu--<suggestion>.html.twig` in your theme to override the markup.
