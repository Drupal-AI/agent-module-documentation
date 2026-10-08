<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create & manage menu link groups

A group is a `localgov_menu_link_group` **config entity**. There is no module settings form;
you manage groups from the entity collection. All admin routes are provided by
`AdminHtmlRouteProvider` and gated by the core permission **`administer site configuration`**
(the entity's `admin_permission`).

## Admin routes

| Route name | Path | Form / handler |
|---|---|---|
| `entity.localgov_menu_link_group.collection` | `/admin/structure/menu/localgov_menu_link_group` | `LocalGovMenuLinkGroupListBuilder` (draggable list) |
| `entity.localgov_menu_link_group.add_form` | `/admin/structure/menu/localgov_menu_link_group/add` | `LocalGovMenuLinkGroupForm` |
| `entity.localgov_menu_link_group.edit_form` | `/admin/structure/menu/localgov_menu_link_group/{localgov_menu_link_group}` | `LocalGovMenuLinkGroupForm` |
| `entity.localgov_menu_link_group.delete_form` | `/admin/structure/menu/localgov_menu_link_group/{localgov_menu_link_group}/delete` | `EntityDeleteForm` |

The collection appears as the **"Menu link group"** tab on the core Menus page
(`entity.menu.collection`) and as a child of the Menus admin-menu item. An **"Add Menu link group"**
action button appears on the collection.

## Add/edit form fields (`LocalGovMenuLinkGroupForm`)

| Field | Form key | Type | Notes |
|---|---|---|---|
| Group name | `group_label` | textfield, required, maxlength 255 | Becomes the group menu link's title/label. |
| Machine name | `id` | machine_name, disabled after create | New ids are auto-prefixed `localgov_menu_link_group_` (const `ENTITY_ID_PREFIX`); source is Group name. |
| Enabled | `status` | checkbox | Only `status = TRUE` groups are turned into menu links. |
| Weight of its menu link | `weight` | number | Also editable by drag-and-drop on the collection (`DraggableListBuilder`). |
| Parent menu link | `parent_menu_link` | `menu.parent_form_selector` element, required | The group link appears as a child of this link. Selector value is `MENU_NAME:PLUGIN_ID`. |
| Child menu links | `child_menu_links` | parent-selector, `#multiple` | The links moved under the group. Upgrades to a `multiselect` element if the `multiselect` module provides one (`element_info->hasDefinition('multiselect')`). |

`parent_menu` is a hidden `value` element; it is not chosen directly — `validateForm()` →
`massageFormValues()` derives it. On submit the form:

- Prepends `localgov_menu_link_group_` to a new id.
- Splits the selected `parent_menu_link` (`MENU_NAME:PLUGIN_ID`) via `extractMenuLinkParts()`,
  storing the menu name in `parent_menu` and the bare plugin id in `parent_menu_link`.
- Strips the `MENU_NAME:` prefix from every selected child, storing bare plugin ids in
  `child_menu_links`.

Saving redirects back to the collection and shows a created/updated message. Every save
(and delete) rebuilds the menu link plugin manager, so changes appear immediately.

## Stored config entity (config schema)

Config object id: `localgov_menu_link_group.localgov_menu_link_group.<id>`
(config_prefix `localgov_menu_link_group`). `config_export` keys:

| Key | Schema type | Default | Meaning |
|---|---|---|---|
| `id` | string | — | Entity id (prefixed `localgov_menu_link_group_…`). |
| `group_label` | label | — | Group menu link title. |
| `weight` | integer | `0` | Group link weight. |
| `parent_menu` | string | `admin` | Menu the group lives in. |
| `parent_menu_link` | string | `system.admin_content` | Plugin id of the parent menu link. |
| `child_menu_links` | sequence of string | `[]` | Menu-link **plugin ids** moved under the group. |

`child_menu_links` is stored as a numeric-keyed **sequence** because config array keys cannot
contain dots (menu-link plugin ids do). `LocalGovMenuLinkGroup::set()` runs `array_values()` on
the value whenever `child_menu_links` is set, guaranteeing numeric keys.

## Create a group with Drush / PHP

Child links are identified by menu-link **plugin id** (e.g. `system.admin_content`,
`admin_toolbar_tools.extra_links:node.add.article`). List available ids:

```
drush php:eval 'print implode("\n", array_keys(\Drupal::service("plugin.manager.menu.link")->getDefinitions()));'
```

Create/save a group programmatically:

```php
$group = \Drupal::entityTypeManager()
  ->getStorage('localgov_menu_link_group')
  ->create([
    'id' => 'localgov_menu_link_group_fruits',
    'group_label' => 'Fruits',
    'status' => TRUE,
    'weight' => 0,
    'parent_menu' => 'admin',
    'parent_menu_link' => 'system.admin_content',
    'child_menu_links' => [
      'admin_toolbar_tools.extra_links:node.add.banana',
      'admin_toolbar_tools.extra_links:node.add.orange',
    ],
  ]);
$group->save(); // hook_ENTITY_TYPE_insert() rebuilds menu links.
```

## Ship a group as configuration

Groups are ordinary config entities, so they export/import like any config and can be shipped by
another module in its `config/install/` or `config/optional/` directory. See
[api/menu-grouping.md](../api/menu-grouping.md) for the YAML shape and how to extend an existing
group from another module.
