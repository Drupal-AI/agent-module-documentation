<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add an icon to a menu link

There is **no settings page** (`configure: null`). Icons are set per menu link on the
custom-menu-link edit form.

## Via the UI

1. Go to *Structure → Menus*, pick a menu, and add/edit a link (a `menu_link_content`
   entity, e.g. `/admin/structure/menu/manage/main`).
2. The module adds an **Icon image** field (`icon_upload`, a managed-file upload).
   Allowed extensions: **gif, png, jpg, jpeg, svg**. Upload location: `public://menu_icons/`.
3. Save. On submit the file is marked **permanent**, file usage is recorded, the icon CSS is
   regenerated, and caches are flushed.

Only **custom** menu links (`menu_link_content`) get the field — links defined by modules in
`*.links.menu.yml` are not editable this way.

## Where the icon is stored

Not in a config entity — on the menu link entity's own `link` field options:

```php
$menu_link->link->first()->options['menu_icon'] = [
  'fid' => <file id>,
  'uri' => 'public://menu_icons/<file>.svg',  // added when a file is uploaded
];
```

Read it back in PHP:

```php
$link = \Drupal::entityTypeManager()->getStorage('menu_link_content')->load($id);
$opts = $link->link->first()->options;
$icon = $opts['menu_icon'] ?? NULL;   // ['fid' => …, 'uri' => …]
```

## Set an icon from code (scriptable)

```php
$link = \Drupal::entityTypeManager()->getStorage('menu_link_content')->load($id);
$item = $link->link->first();
$options = $item->options ?: [];
$options['menu_icon']['uri'] = 'public://menu_icons/star.svg';
$options['menu_icon']['fid'] = $fid;   // a permanent managed file id
$item->options = $options;
$link->save();
// Regenerate the icon CSS so the new icon is painted:
simple_menu_icons_css_generate();
```

`simple_menu_icons_css_generate()` skips links whose `menu_icon.fid` is empty and whose file
cannot be loaded, so a usable `fid` pointing at an existing file is what actually produces
CSS. The `uri` alone is enough to identify a configured icon for introspection.

## What it does NOT provide

No permission, no Drush command, no config schema, no plugin type. The only persistent state
is the per-link `menu_icon` options plus the generated CSS file and its State suffix (see
[../theming/output.md](../theming/output.md)).
