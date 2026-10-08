# Configure Nice Menus

Two layers: a global settings form and per-block configuration.

## Global settings — `nice_menus.settings`

Form `NiceMenusSettingsForm` at `admin/config/user-interface/nice_menus` (route `nice_menus.admin`,
permission `manage nice menu settings`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `nice_menus_js` | bool | `true` | Load Superfish + hoverIntent JS (needed for legacy IE / hover-intent behaviour). |
| `nice_menus_default_css` | bool | `true` | Load the module's default menu CSS (`nice_menus_default`). |
| `nice_menus_sf_delay` | int | `800` | Superfish hover close delay in ms. Emitted to JS as `drupalSettings.nice_menus_options.delay`. |
| `nice_menus_sf_speed` | string | `slow` | Animation speed: `slow` / `normal` / `fast`. Emitted as `...options.speed`. |

Set via Drush:
```bash
ddev drush config:set nice_menus.settings nice_menus_js true -y
ddev drush config:set nice_menus.settings nice_menus_sf_speed fast -y
```

## Per-block configuration — `nice_menus_block`

The `NiceMenusBlock` Block plugin (category *Menus*). Place it via Block layout
(`/admin/structure/block`) and configure:

| Setting | Element | Default | Meaning |
|---|---|---|---|
| `nice_menus_name` | textfield | — | Optional block-internal name label. |
| `nice_menus_menu` | select | `navigation:0` | Source **menu parent** as `menu_name:mlid`; `mlid` 0 = whole menu root. Options from `menu.parent_form_selector`. |
| `nice_menus_depth` | select (-1…5) | `-1` | Number of child levels below the chosen parent; `-1` = all, `0` = none. |
| `nice_menus_type` | select | `right` | Expand style: `right`, `left`, or `down`. Adds class `nice-menu-<type>`. |
| `nice_menus_respect_expand` | select (0/1) | `0` | `1` = only expand branches whose links have core "Show as expanded" checked. |

`getBlockConfigExtended()` splits `nice_menus_menu` into `menu_name` + `menu_mlid`. The block attaches
`nice_menus/nice_menus_css` always, and the Superfish/hoverIntent/nice_menus JS only when
`nice_menus_js` is on, and the default CSS only when `nice_menus_default_css` is on. Cache tags include
`config:system.menu.<menu_name>`; cache context `route.menu_active_trails:<menu_name>`.

Create a block instance with Drush:
```php
// drush php:eval — main menu as a horizontal dropdown in the primary_menu region of the default theme.
\Drupal::entityTypeManager()->getStorage('block')->create([
  'id' => 'nicemenu_main', 'plugin' => 'nice_menus_block',
  'theme' => \Drupal::config('system.theme')->get('default'), 'region' => 'primary_menu',
  'settings' => [
    'id' => 'nice_menus_block', 'label' => 'Main dropdown', 'label_display' => '0',
    'nice_menus_menu' => 'main:', 'nice_menus_depth' => -1, 'nice_menus_type' => 'down',
    'nice_menus_respect_expand' => 0,
  ],
])->save();
```
