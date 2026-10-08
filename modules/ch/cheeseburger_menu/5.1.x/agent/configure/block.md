<!-- SPDX-License-Identifier: GPL-2.0+ -->
# Configure: the menu block and the trigger block

There is **no settings page**; configuration lives entirely on two placed blocks.

## 1. Place the menu block (`cheeseburger_menu`)
*Structure → Block layout* → place **Cheeseburger menu** in a region. In its form:

Toggles (`block.settings.cheeseburger_menu`, defaults in parentheses):
- `default_css` (TRUE), `default_js` (TRUE) — load the module's CSS/JS.
- `show_navigation` (TRUE) — render the in-panel top navigation.
- `parent_menu_as_link` (FALSE) — show a parent item as a link, not just a toggle.
- `track_active_trail` (TRUE) — highlight the active item (adds active-trail cache contexts).
- `invoke_hooks` (FALSE) — enable the alter hooks (see [../hooks/alter.md](../hooks/alter.md)).
- `hidden` (TRUE) — internal, form field is `#access: FALSE`.

Colors (each a `_color` hex + `_opacity` 0–1 string): `left_side_background`,
`left_side_text`, `right_side_background`, `right_side_text`, `trigger`,
`trigger_background`, `scrollbar`.

Aggregated sources — the **`menus`** sequence. Drag menus/vocabularies from "Disabled" into
"Enabled" and order them. Each entry stores:
```yaml
menus:
  - id: main                 # menu machine name or vocabulary id
    menu_type: menu          # 'menu' or 'taxonomy_vocabulary'
    weight: 0
    settings:
      max_depth: 0
      initial_visibility_level: 1
      default_expanded: false
      show_title_in_navigation: true
      collapsible_title: false
      title_default_expanded: false
      show_title_above_menu: false
      override_title: false
      title_override: ''
      show_links_in_navigation: false   # if true, forces max_depth=1, default_expanded=false
      icon: '<svg>…</svg>'              # SVG contents (uploaded file is read into config)
```

## 2. Place the trigger block (`cheeseburger_menu_trigger`)
Place **Cheeseburger menu trigger**. Settings (`block.settings.cheeseburger_menu_trigger`):
- `block_to_trigger` — the **block id** of the menu block it opens (required).
- `breakpoints` — sequence of breakpoint strings to show the trigger at (uses
  `breakpoint.manager` if the core Breakpoint module is available).
- `custom_media_query` — a raw media query as an alternative to breakpoints.

## Programmatic placement (drush)
```php
\Drupal\block\Entity\Block::create([
  'id' => 'my_cbm', 'theme' => \Drupal::config('system.theme')->get('default'),
  'region' => 'content', 'plugin' => 'cheeseburger_menu',
  'settings' => [
    'id' => 'cheeseburger_menu', 'label' => 'Menu',
    'left_side_background_color' => '#2494DB',
    'menus' => [ 'main' => ['id' => 'main', 'menu_type' => 'menu', 'weight' => 0, 'settings' => []] ],
  ],
])->save();
```
Read back a placed block's settings with
`drush cget block.block.<id> settings`. The panel's active-trail highlighting and taxonomy
trees are cache-aware (tags `cheeseburger_menu:<id>`, context `route.taxonomy_term_tree:<vocab>`).
