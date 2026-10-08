# Configure mega-menu types, fields, and attachment

There is no global settings form. Configuration has three parts: (1) a bundle (`simple_mega_menu_type`)
and which menus it targets, (2) fields/displays on that bundle, (3) attaching an entity to a menu link.

## 1. Create a bundle and set target menus

Bundle = config entity `simple_mega_menu_type` (config name `simple_megamenu.simple_mega_menu_type.<id>`).
UI: `/admin/structure/simple_mega_menu_type` → *Add Simple mega menu type*. The key setting is
**`targetMenu`**, a list of menu machine names the bundle applies to.

Config shape:

```yaml
# simple_megamenu.simple_mega_menu_type.megamenu
id: megamenu
label: 'Mega menu'
targetMenu:
  main: main            # menu machine names this bundle is used on
```

Scriptable:

```php
\Drupal\simple_megamenu\Entity\SimpleMegaMenuType::create([
  'id' => 'megamenu',
  'label' => 'Mega menu',
  'targetMenu' => ['main' => 'main'],
])->save();
```

`targetMenu` drives everything else: the autocomplete on a menu link only appears when that link's
menu is in some bundle's `targetMenu` (helper `getMegaMenuTypeWhichTargetMenu()` /
`menuIsTargetedByMegaMenuType()`).

## 2. Add fields and view modes

The entity uses `field_ui_base_route = entity.simple_mega_menu_type.edit_form`, so a bundle exposes
the usual *Manage fields / form display / display* tabs — add image/link/text fields exactly like a
content type. The module ships two extra view modes for the `simple_mega_menu` entity type:
**`before`** and **`after`** (config `core.entity_view_mode.simple_mega_menu.before` / `.after`), used
by the default template. Add your own view modes as needed.

## 3. Create entities and attach to a menu link

- Create entities at `/admin/content/simple_mega_menu/add/<bundle>` (permission
  `add simple mega menu entities`).
- Edit a **menu link content** item in a targeted menu: the form now has a *Simple Mega Menu*
  entity-autocomplete (`#target_type => simple_mega_menu`, limited to the bundles targeting that menu).
  Selecting an entity stores its id on the link:

```
menu_link_content.link.options.attributes['data-simple-mega-menu'] = <entity_id>
```

Clearing the field removes the attribute. Note the module explicitly does **not** support attaching
to *plugin-defined* menu links (`MenuLinkDefault`) — only `menu_link_content` entities — because core
doesn't let those persist options (`simple_megamenu_form_menu_link_edit_alter` returns early).

## Reading it back

```bash
drush cget simple_megamenu.simple_mega_menu_type.megamenu targetMenu
# which entity is on a given menu link:
drush php:eval '
  $l = \Drupal::entityTypeManager()->getStorage("menu_link_content")->load(<id>);
  print $l->link->first()->options["attributes"]["data-simple-mega-menu"] ?? "none";
'
```
