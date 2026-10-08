# Set up group menus

Three steps: define a menu **type**, enable the relation on a **group type**, then manage a
group's menu.

## 1. Define a menu type (`group_content_menu_type`)

UI: **Structure → Group content menu types** (`/admin/structure/group_content_menu_types`,
route `entity.group_content_menu_type.collection`; add form
`entity.group_content_menu_type.add_form`). This is the configure route.

The type is a config entity (config name
`group_content_menu.group_content_menu_type.<id>`, keys: `id`, `label`, `uuid`).

Create one from code:

```php
\Drupal\group_content_menu\Entity\GroupContentMenuType::create([
  'id' => 'main',
  'label' => 'Main navigation',
])->save();
```

```bash
drush php:eval '\Drupal\group_content_menu\Entity\GroupContentMenuType::create(["id"=>"main","label"=>"Main navigation"])->save();'
# list them:
drush php:eval 'foreach(\Drupal::entityTypeManager()->getStorage("group_content_menu_type")->loadMultiple() as $id=>$t){print "$id: ".$t->label()."\n";}'
```

## 2. Enable the relation on a group type

On the group type's content configuration
(`/admin/group/types/manage/{group_type}/content`), install the **Group content menu**
relation (plugin `group_content_menu`, derived per menu type). Its relation config supports
auto-create options (schema `group_relation.config.*`):

- `auto_create_group_menu` (bool) — create a menu automatically when a group is created.
- `auto_create_home_link` (bool) + `auto_create_home_link_title` (string) — add a Home link.

## 3. Manage a group's menu

Each group then exposes its menus at `/group/{group}/menus`
(`entity.group_content_menu.collection`). Add/edit menu links per group; add-link route is the
entity `add-menu-link` link. The group operations list gains an "Edit group menus" action.

## 4. Render the menu — the block

Place the **Group Menu** block (plugin `group_content_menu`, category "Group Menus", derived
per type). Block settings (schema `group_content_menu_block`):

| Setting | Meaning |
|---|---|
| `level` | Starting level. |
| `depth` | Maximum number of levels. |
| `expand_all_items` | Expand all items. |
| `relative_visibility` | Relative visibility. |
| `theme_hook_suggestion` | Theme hook suggestion. |

The block takes an optional `group` context and renders the current group's menu of that type.

See also [permissions](../permissions/permissions.md) and the [entity/plugin model](../api/model.md).
