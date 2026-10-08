<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ultimenu_block` derivative block

Ultimenu does **not** define a plugin type you implement. It ships one block plugin,
`ultimenu_block` (`src/Plugin/Block/UltimenuBlock.php`), with a deriver
(`src/Plugin/Derivative/UltimenuBlock.php`) that yields **one derivative per menu enabled**
under `ultimenu.settings:blocks`.

- Base plugin id: `ultimenu_block`
- Derivative id: `ultimenu_block:ultimenu-<menu>` (e.g. `ultimenu_block:ultimenu-main`)
- Admin label: `Ultimenu: <menu name>`; category `Ultimenu`
- The delta (menu machine name) is recovered as `substr(getDerivativeId(), 9)` (strips
  the `ultimenu-` prefix).

A derivative only exists once the menu is checked and saved on `/admin/structure/ultimenu`.
After changing that config, clear block definitions (`drush cr` or
`\Drupal::service('plugin.manager.block')->clearCachedDefinitions()`) for the block to become
placeable.

## Placing an instance

Place it at `/admin/structure/block` (search "Ultimenu:"), or in code create a `block`
config entity whose `plugin` is the derivative id:

```php
use Drupal\block\Entity\Block;
Block::create([
  'id' => 'ultimenu_main',
  'theme' => 'olivero',
  'region' => 'header',              // an ordinary theme region, NOT an Ultimenu region
  'plugin' => 'ultimenu_block:ultimenu-main',
  'settings' => ['id' => 'ultimenu_block:ultimenu-main', 'label' => 'Main mega menu'],
])->save();
```

Do **not** place an Ultimenu block into an Ultimenu region — that breaks the layout. Fill the
generated `Ultimenu:<menu>: <item>` regions with *other* blocks.

## Per-instance settings (`defaultConfiguration()` / schema `block.settings.ultimenu_block:*`)

| Key | Default | Purpose |
|---|---|---|
| `ajaxify` | `FALSE` | AJAX-load panel contents on demand. |
| `regions` | `[]` | Which item-regions this block ajaxifies. |
| `skin` | `module|ultimenu--dark` | Selected skin (`<provider>|<skin>`). |
| `orientation` | `ultimenu--htb` | Flyout orientation. |
| `caret` / `caret_skin` | `FALSE` / `arrow` | Show carets on items with panels. |
| `submenu` / `submenu_collapsible` / `submenu_position` | `FALSE` / `FALSE` / `''` | Render second-level items inside regions. |
| `offcanvas` / `hamburger` | `FALSE` / `FALSE` | Turn this block into an off-canvas / always-hamburger menu. |
| `canvas_off` / `canvas_on` | `''` / `''` | CSS selectors for the off-canvas element and on-canvas elements. |
| `canvas_skin` | | Off-canvas skin. |
| `sticky` | `FALSE` | Sticky header. |
| `unlink` / `unlinks` | `''` / `[]` | Non click-through menu-item markup / items. |

Only one off-canvas Ultimenu block should be active per page (use block visibility rules).
