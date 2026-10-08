<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Toolbar Menu — the `toolbar_menu_element` config entity

A menu becomes a toolbar tab by creating one **`toolbar_menu_element`** config entity that
points at an existing menu. On save, `hook_toolbar()` renders a `toolbar_item` (tab + tray)
for each element; the tray shows the referenced menu's link tree. Element saves invalidate
the `toolbar_menu` cache tag so the toolbar rebuilds.

## Admin UI

- **Collection / list:** `/admin/config/user-interface/toolbar-menu/elements`
  (route `entity.toolbar_menu_element.collection`) — the module's `configure` route.
- **Add:** `/admin/config/user-interface/toolbar-menu/elements/add`
  (route `entity.toolbar_menu_element.add_form`).
- **Edit:** `.../elements/{toolbar_menu_element}` · **Delete:** `.../elements/{id}/delete`.
- Reached via **Configuration > User interface > Toolbar Menu**.
- All admin routes require the **`administer toolbar menu`** permission.

The add/edit form fields: **Label** (textfield), **ID** (machine name), **Menu** (select of
enabled menus), and **"Display the menu label in toolbar instead of this entity label"**
(checkbox → `rewrite_label`).

## Config entity shape

Config entity type `toolbar_menu_element`; config object
`toolbar_menu.toolbar_menu_element.<id>`. Exported keys (`config_export`):

| Key | Type | Meaning |
|---|---|---|
| `id` | string | Machine name of the element |
| `label` | string | Element label (default tab title) |
| `menu` | string | Machine name of the target menu (e.g. `main`, `admin`) |
| `weight` | integer | Ordering of this tab among toolbar items |
| `rewrite_label` | boolean | If TRUE, the tab shows the **menu's** own label instead of `label` |

Example (`drush config:get toolbar_menu.toolbar_menu_element.my_tab`):

```yaml
id: my_tab
label: 'Editor tools'
weight: 0
menu: main
rewrite_label: false
```

## Permissions

- **`administer toolbar menu`** — gates all admin routes above.
- **Dynamic per-element permission `view <id> in toolbar`** — generated for every element by
  `ToolbarMenuPermissions::permissions()` (title: *View `<label>` element in the toolbar*).
  A tab is only rendered for a user who has that element's permission, so you control which
  roles see each menu tab. Grant e.g. `view my_tab in toolbar` to the relevant roles.

## Create one with Drush (no UI)

```bash
drush php:eval '
  \Drupal::entityTypeManager()->getStorage("toolbar_menu_element")->create([
    "id" => "my_tab",
    "label" => "Editor tools",
    "menu" => "main",
    "weight" => 0,
    "rewrite_label" => FALSE,
  ])->save();
'
drush cr
```

Verify: `drush config:get toolbar_menu.toolbar_menu_element.my_tab`.
Delete: `drush php:eval '\Drupal::entityTypeManager()->getStorage("toolbar_menu_element")->load("my_tab")->delete();'`

The `menu` value must be the machine name of an existing menu (list them with
`drush php:eval 'foreach(\Drupal::entityTypeManager()->getStorage("menu")->loadMultiple() as $m){print $m->id()."\n";}'`).
Core defaults always present include `main` and `admin`.
