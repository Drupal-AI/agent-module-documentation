# Configure — icons per menu link

There is **no global settings form and no configure route**. You set an icon on each menu
link. The module adds a "FontAwesome Icon" fieldset to two forms:

- The **custom menu-link** add/edit form (`menu_link_content`, e.g. `/admin/structure/menu/manage/main/add`).
- The generic **module-defined menu-link** edit form (links that come from `*.links.menu.yml`).

## Form fields

| Field name | Purpose | Default | Options |
|---|---|---|---|
| `fa_icon` | Icon class/name | *(empty)* | e.g. `fa-rocket` (FA6), `home` (FA4) |
| `fa_icon_prefix` | Style / version prefix | `fa` | `fa`,`fas`,`far`,`fal`,`fad`,`fab` (FA4/5); `fa-solid`,`fa-regular`,`fa-light`,`fa-thin`,`fa-duotone`,`fa-brands` (FA6) |
| `fa_icon_tag` | Wrapper HTML tag | `i` | `i`, `span` |
| `fa_icon_appearance` | Placement | `before` | `before`, `after`, `only` (icon without text) |

Note from the UI: for **Font Awesome 6.x** prefix the icon *name* with `fa-` (e.g.
`fa-rocket`) and pick a `fa-solid`/`fa-brands`/… prefix. For FA4 use a bare name (`home`)
with the `fa` prefix.

## Set an icon programmatically (custom menu link)

For a `menu_link_content` entity the icon lives in the **`link` field `options`** — no
config write is involved:

```php
$ml = \Drupal\menu_link_content\Entity\MenuLinkContent::create([
  'title'     => 'Home',
  'link'      => ['uri' => 'route:<front>', 'options' => [
    'fa_icon'            => 'fa-house',
    'fa_icon_prefix'     => 'fa-solid',
    'fa_icon_tag'        => 'i',
    'fa_icon_appearance' => 'before',
  ]],
  'menu_name' => 'main',
]);
$ml->save();
```

Update an existing one:

```php
$ml = \Drupal\menu_link_content\Entity\MenuLinkContent::load($id);
$opts = $ml->link->first()->options ?: [];
$opts['fa_icon'] = 'fa-star'; $opts['fa_icon_prefix'] = 'fa-solid';
$ml->link->first()->options = $opts;
$ml->save();
```

Read it back with drush:

```bash
drush php:eval '$m=\Drupal\menu_link_content\Entity\MenuLinkContent::load(1); print json_encode($m->link->first()->options);'
```

## Removing an icon

Clear `fa_icon` (empty string). Via the module-defined-link form this also unsets the
mirror entry in `fontawesome_menu_icons.settings` → `menu_link_icons`. For a
`menu_link_content` entity just set `fa_icon` to `''` in the link options and save.

## Config object

`fontawesome_menu_icons.settings` has one key, `menu_link_icons` (default `[]`). It is a
**cache-survival mirror for module-defined links only** (see
[../api/icon-options.md](../api/icon-options.md)); custom `menu_link_content` links do not
use it.
