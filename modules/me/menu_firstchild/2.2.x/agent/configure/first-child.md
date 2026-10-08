<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable "First child" on a menu link

There is **no configuration page** (`configure: null`). You enable the behavior per menu link.

## Via the UI

1. Add or edit a custom menu link (e.g. *Structure → Menus → Main navigation → Add link*).
2. Tick the **"First child"** checkbox ("When enabled, this menu item will redirect to the
   first child item."). The Link/path field is then disabled — you do not enter a path.
3. Save. Make sure the link has child links beneath it in the menu tree.

## Where the flag is stored

The link is a `menu_link_content` entity. The flag lives in the **link field's options**, not
in any config object:

```
link:
  uri: 'route:<none>'
  options:
    menu_firstchild:
      enabled: true
```

## Enable it programmatically

```php
use Drupal\menu_link_content\Entity\MenuLinkContent;

MenuLinkContent::create([
  'title' => 'Products',
  'menu_name' => 'main',
  'link' => [
    'uri' => 'route:<none>',
    'options' => ['menu_firstchild' => ['enabled' => TRUE]],
  ],
])->save();
```

To toggle on an existing link, read `->get('link')->first()->options`, set
`['menu_firstchild']['enabled']`, write the whole `link` value back, and save.

## Read it back

```php
$opts = $link->get('link')->first()->options;
$enabled = !empty($opts['menu_firstchild']['enabled']);   // TRUE if first-child linking is on
```

## Render behavior

`hook_preprocess_menu()` rewrites an enabled item's URL to the first **viewable** (access-checked,
sorted) child, recursing when that child is itself a first-child link. The item gets a
`menu-firstchild` class. With no viewable child the item resolves to `route:<none>` (unlinked).
Because this happens at render time, reordering children changes the destination automatically.
