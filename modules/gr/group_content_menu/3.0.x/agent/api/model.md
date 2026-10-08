# Group Content Menu — entity & plugin model

For developers integrating with or extending the module.

## Entities

| Entity | Kind | Notes |
|---|---|---|
| `group_content_menu` | **content** entity | Revisionable, translatable, publishable. Base table `group_content_menu`. Route provider `GroupContentMenuRouteProvider`. Bundle = a menu type. Field UI base route `entity.group_content_menu_type.edit_form`. |
| `group_content_menu_type` | **config** entity | The bundle. Config prefix `group_content_menu.group_content_menu_type.*` (keys `id`, `label`, `uuid`). |

Load / create the type:

```php
use Drupal\group_content_menu\Entity\GroupContentMenuType;
GroupContentMenuType::create(['id' => 'main', 'label' => 'Main navigation'])->save();
$type = GroupContentMenuType::load('main');
```

Key entity route links: `collection` = `/group/{group}/menus`, `add-form` =
`/group/{group}/menu/add/{plugin_id}`, `add-menu-link` =
`/group/{group}/menu/{group_content_menu}/add-link`, plus edit/delete/translate link routes.

## Plugins the module provides (it defines no new plugin *type*)

| Plugin type | Id | Class / deriver |
|---|---|---|
| Group relation (`group_relation`) | `group_content_menu` | `Plugin/Group/Relation/GroupMenu` + `GroupMenuDeriver` (derived per menu type). `entity_type_id = group_content_menu`. |
| Block | `group_content_menu` | `Plugin/Block/GroupMenuBlock` + `Plugin/Derivative/GroupMenuBlock`. Context `group` (optional). Category "Group Menus". |
| Condition | `group_content_menu` | `Plugin/Condition/GroupContentMenu`. |
| Relation handler | permission_provider | `GroupContentMenuPermissionProvider` (service `group.relation_handler.permission_provider.group_content_menu`, decorates the base provider). |

## Service decoration & hooks

- Decorates `menu.parent_form_selector` → `GroupContentMenuParentFormSelector`
  (`group_content_menu.parent_form_selector`, priority 10) so group menus appear as available
  parents when placing links.
- `GroupOwnsMenuContentAccessChecker` → access check `_group_menu_owns_content`.
- Hook services: `group_content_menu.hooks` (`GroupContentMenuHooks`) and
  `group_content_menu.node_form_alter` (`NodeFormAlter`, adds a group-menu selector to the node
  form).

## Rendering a group's menu in code

Use the `group_content_menu` block plugin (derived per type) with a group context, or build a
menu tree from the group's `group_content_menu` entity. Block settings: `level`, `depth`,
`expand_all_items`, `relative_visibility`, `theme_hook_suggestion` (schema
`group_content_menu_block`). Templates: `group-content-menu.html.twig`,
`menu--group-menu.html.twig`.
