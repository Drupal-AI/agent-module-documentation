# tb_megamenu — API

## Config entity: `MegaMenuConfig`

`Drupal\tb_megamenu\Entity\MegaMenuConfig` (implements `MegaMenuConfigInterface`),
config entity type id `tb_megamenu`, prefix `menu_config`.

Load / create / inspect:

```php
use Drupal\tb_megamenu\Entity\MegaMenuConfig;

// Load the config for a menu+theme (id = "{menu}__{theme}").
$config = MegaMenuConfig::loadMenu('main', 'olivero');

// Or via entity storage / static load by id.
$config = MegaMenuConfig::load('main__olivero');

// Create programmatically (id auto-derived from menu + theme).
$config = MegaMenuConfig::create(['menu' => 'main', 'theme' => 'olivero']);
$config->setMenuConfig($menuArray);   // JSON-encodes into menu_config
$config->setBlockConfig($blockArray); // JSON-encodes into block_config
$config->save();
```

Accessors: `getMenuConfig()` / `getBlockConfig()` return **decoded arrays** and HTML-escape
item classes/captions/xicons/labels (XSS hardening); `setMenuConfig()` / `setBlockConfig()`
JSON-encode. `setMenu()`, `setTheme()`, static `loadMenu($menu, $theme)`. Dependencies on the
menu and theme are added in `calculateDependencies()`.

## Service: `tb_megamenu.menu_builder`

`Drupal\tb_megamenu\TBMegaMenuBuilder` (interface `TBMegaMenuBuilderInterface`). Constructor
args: `@logger.factory`, `@menu.link_tree`, `@entity_type.manager`, `@path.matcher`,
`@menu.tree_storage`.

Notable public methods:

- `getMenus($menu_name, $theme)` — load the mega menu config object for a menu/theme.
- `getMenuConfig($menu_name, $theme)` / `getBlockConfig($menu_name, $theme)` — decoded config.
- `renderBlock($menu_name, $theme)` — return the `#theme => 'tb_megamenu'` render array (backend section).
- `getMenuItem($menu_name, $plugin_id)`, `findMenuItem($tree, $plugin_id)`.
- `loadEntityBlock($block_id)` — load a Drupal block if the user has view access.
- `getAllBlocks($theme)` — accessible blocks in a theme (excludes tb_megamenu's own blocks).
- `createAnimationOptions()` → `none|fading|slide|zoom|elastic`.
- `createStyleOptions()` → `''(Default)|black|blue|green`.
- `editBlockConfig(&$c)` / `editItemConfig(&$c)` / `editColumnConfig(&$c)` /
  `editSubMenuConfig(&$c)` — fill defaults into a config array (see configure doc).
- `syncConfigAll()`, `syncConfig()`, `syncMenuItem()`, `syncBlock()`, `syncOrderMenus()`,
  `insertEnabledLinks()`, `buildPageTrail()`, `sortByWeight()` — used to reconcile stored
  config with the live core menu tree.

```php
$builder = \Drupal::service('tb_megamenu.menu_builder');
$menuCfg = $builder->getMenuConfig('main', 'olivero');
```

## Block plugin

`tb_megamenu_menu_block` (class `Plugin\Block\TBMegaMenuBlock`, deriver
`Plugin\Derivative\TBMegaMenuBlock`) — one derivative per configured menu that has a matching
core menu. `build()` returns the `tb_megamenu` themed element. Cache tags:
`config:system.menu.{menu}` and `config:tb_megamenu.menu_config.{menu}__{theme}`; cache
context `route.menu_active_trails:{menu}`.

## No Drush, no hook_ API, no plugin manager

The module ships no Drush commands, no `tb_megamenu.api.php` (no invented hooks to implement),
and defines no plugin type of its own. Integration is via the config entity, the builder
service, and standard block placement.
