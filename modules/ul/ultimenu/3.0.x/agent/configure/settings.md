<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Ultimenu (settings form + `ultimenu.settings`)

Admin form: **/admin/structure/ultimenu** (route `ultimenu.settings`, permission
`administer ultimenu`). It is a `ConfigFormBase` editing the single config object
**`ultimenu.settings`**. There is no `config/install` default, so before first save the
object does not exist (`drush cget ultimenu.settings` errors until saved once).

## Workflow the form enforces (save one step at a time)

1. **Ultimenu blocks** — tick the menus you want to become mega-menu blocks. Save. Each ticked
   menu becomes a placeable block derivative `ultimenu_block:ultimenu-<menu>`.
2. **Ultimenu regions** — after saving step 1, the enabled menu items appear here as toggleable
   regions. Tick the ones you want active; save. Only enabled regions show at block admin.
3. **Ultimenu goodies** — the rest (description rendering, class helpers, region-key strategy,
   off-canvas behavior, etc.).

## `ultimenu.settings` keys (config schema `ultimenu.settings`)

| Key | Type | Meaning |
|---|---|---|
| `blocks` | sequence | Enabled menus, stored as `<menu>: <menu>` (checkbox value). A menu is an Ultimenu block iff `blocks.<menu>` is non-empty. |
| `regions` | sequence | Enabled item-regions, keyed by region machine key. |
| `goodies` | sequence | Toggled feature flags (see below). |
| `skins` | string | Path to a custom skins library dir (must exist, validated). |
| `fallback_text` | string | AJAX fallback link text. |
| `ajaxmw` | string | CSS max-width (e.g. `481px`) below which panels auto-AJAX-load. |
| `icon_class` | string | Extra icon classes appended to menu-item icons. |
| `themes` | sequence | Themes the regions are exposed to. |
| `offcanvases` | sequence | Per-theme off-canvas element mapping. |

### `goodies` flag ids (checkboxes, stored only when on)

`menu-desc`, `desc-top`, `title-class`, `mlid-class` (deprecated), `mlid-hash-class`,
`counter-class`, `no-tooltip`, `ultimenu-mlid` (deprecated), `ultimenu-mlid-hash`,
`force-remove-region`, `no-extras`, `decouple-main-menu`, `fe-themes`.

Notable ones: `ultimenu-mlid-hash` uses a stable HASH (not the item title) as the region key so
renaming a menu item does not destroy its region/blocks; `force-remove-region` removes Ultimenu
regions stored in the default theme's `.info.yml`; `fe-themes` exposes regions to all front-end
themes; `decouple-main-menu` treats Main menu like any other menu.

## Read / write via drush

```bash
drush cget ultimenu.settings blocks            # which menus are Ultimenu blocks
drush cget ultimenu.settings regions           # which item-regions are enabled
```

```php
// Enable the Footer menu as an Ultimenu block:
$c = \Drupal::configFactory()->getEditable('ultimenu.settings');
$blocks = $c->get('blocks') ?: [];
$blocks['footer'] = 'footer';
$c->set('blocks', $blocks)->save();
// Then rebuild block derivatives so the new block becomes placeable:
\Drupal::service('plugin.manager.block')->clearCachedDefinitions();
```

After changing `blocks`/`regions`, the form clears block-manager and skin cached definitions;
in code call `plugin.manager.block`->`clearCachedDefinitions()` (or `drush cr`) so the new
derivative/regions appear at `/admin/structure/block`.

## Dynamic regions

Regions are contributed at runtime by `hook_system_info_alter()` — you do **not** edit the theme
`.info.yml`. The settings form shows a copy/paste `regions:` block you can optionally paste into a
theme's `.info.yml` to store them permanently; a region stored in the theme wins unless
`force-remove-region` is enabled.
