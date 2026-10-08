<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WeMegaMenuBuilder API + the `data_config` JSON model

`\Drupal\we_megamenu\WeMegaMenuBuilder` is a class of **static helper methods** (not a registered
service — call the static methods directly). It is the single programmatic entry point for
reading and writing mega-menu layouts. Source: `src/WeMegaMenuBuilder.php`.

## Most useful methods

| method | signature | does |
|---|---|---|
| `loadConfig` | `loadConfig($menu_name, $theme)` | `SELECT data_config` for the pair and `json_decode` it → stdClass, or `FALSE` if `$menu_name` empty |
| `saveConfig` | `saveConfig(string $menu_name, string $theme, $data_config)` | DB `merge` (upsert) into `we_megamenu`; `$data_config` is a **JSON string** |
| `initMegamenu` | `initMegamenu($menu_name, $theme_name)` | build a fresh layout from the menu's link tree, save it, and return the config object |
| `getMenuTree` | `getMenuTree($menu_name, $backend = TRUE, …)` | load + transform the menu link tree into nested arrays; invokes `hook_megamenu_manipulators_alter()` |
| `getMenuTreeOrder` | `getMenuTreeOrder($menu_name, $backend, …)` | same, sorted by weight |
| `getAllBlocks` | `getAllBlocks()` | map of `block_id => label` for the default theme (excludes we_megamenu's own blocks) — the block picker source |
| `renderBlock` | `renderBlock($bid, $title_enable = TRUE, $section = '')` | render a Drupal block by id to HTML for embedding in a column |
| `renderWeMegaMenuBlock` | `renderWeMegaMenuBlock($menu_name, $theme)` | build a `we_megamenu_frontend` render array |
| `updateMegamenuFromDrupalMenu` | `updateMegamenuFromDrupalMenu(&$cfg, $menu_items, $level)` | reconcile stored layout with current menu links |

```php
$theme  = \Drupal::config('system.theme')->get('default');
$config = \Drupal\we_megamenu\WeMegaMenuBuilder::loadConfig('main', $theme);
if ($config === FALSE || empty($config)) {
  $config = \Drupal\we_megamenu\WeMegaMenuBuilder::initMegamenu('main', $theme);
}
$config->block_config->action = 'clicked';
\Drupal\we_megamenu\WeMegaMenuBuilder::saveConfig('main', $theme, json_encode($config));
```

Note the asymmetry: `saveConfig()` takes a **JSON string** (`json_encode(...)`), while
`loadConfig()` returns a **decoded object**.

## `data_config` JSON shape

```jsonc
{
  "menu_update_flag": 0,            // set to 1 when menu links change; front-end reconciles + clears
  "menu_config": {                 // keyed by each link's derivative id (uuid)
    "<derivativeId>": {
      "rows_content": [            // rows -> columns of the dropdown panel
        [ { "col_config": { "width": 12, "block": "", "block_title": 0,
                            "class": "", "hidewhencollapse": "", "type": "we-mega-menu-col" },
            "col_content": [ { "mlid": "<uuid>", "type": "we-mega-menu-li", "title": "..." } ] } ]
      ],
      "submenu_config": { "width": "", "class": "", "type": "" },
      "item_config": { "level": 0, "type": "we-mega-menu-li", "id": "<uuid>", "title": "...",
                       "submenu": 0, "group": 0, "class": "", "hide_sub_when_collapse": "",
                       "data-icon": "", "data-caption": "", "data-alignsub": "", "data-target": "" }
    }
  },
  "block_config": { "style": "Default", "animation": "None", "delay": "", "duration": "",
                    "auto-arrow": "", "always-show-submenu": "", "action": "hover",
                    "auto-mobile-collapse": 0 }
}
```

- Set `col_config.block` to a block id (and use `col_config.block_title`) to embed a Drupal block
  in a dropdown column instead of links.
- `col_config.width` is a Bootstrap-style span (1–12), rendered as class `span<width>`.
- `item_config` carries per-link icon (`data-icon`), caption, CSS class, grouping, and target.
- `block_config` keys map to `data-*` attributes on the rendered menu (see
  [../configure/megamenus.md](../configure/megamenus.md)).

## Keeping layout in sync (entity hooks)

`we_megamenu.module` implements `hook_entity_insert/delete/presave` for `menu_link_content` and
`menu` entities: adding a link inserts a cell into the stored layout, deleting a link removes it,
and editing a menu sets `menu_update_flag = 1` so the next render reconciles. You normally do not
call these paths yourself.

## `AfterConfigSave` event — declared but not dispatched

`src/Event/AfterConfigSave.php` defines an event (`const EVENT_NAME =
'we_megamenu.config.save.after'`) with getters for menu name / theme / config data. **As of this
version the module never dispatches it** (no `->dispatch()` call anywhere in the codebase), so
subscribing to it will not fire today. Treat it as a reserved/forward-looking hook, not a working
extension point.
