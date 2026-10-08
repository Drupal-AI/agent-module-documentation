# Config menu links

There is **no settings form**. The module adds a third kind of menu link — a config entity
`menu_link_config` — that you create from the normal menu UI and that exports/imports as
configuration. Core's own links come as code (`*.links.menu.yml`, fixed) or as
`menu_link_content` (content, not in a config export); this fills the gap for small,
structural menus you want in `config/sync`.

## Create / edit / delete from the UI

| Action | Route | Path | Access requirement |
|---|---|---|---|
| Add | `menu_link_config.link_add` | `/admin/structure/menu/manage/{menu}/add_config_link` | `_entity_create_access: 'menu_link_config'` |
| Edit | `entity.menu_link_config.edit_form` | `/admin/structure/menu/link/{menu_link_plugin}/edit` | `_permission: 'administer menu'` |
| Delete | `entity.menu_link_config.delete_form` | `/admin/structure/menu/link/{menu_link_config}/delete` | `_permission: 'administer menu'` |

On any menu's edit page (`entity.menu.edit_form`, needs `menu_ui`) an **"Add config link"** action
link appears (`menu_link_config.links.action.yml`). It calls `MenuController::addLink()`
(`src/Controller/MenuController.php`), which creates an empty `menu_link_config` entity for that menu
and renders the entity form (`MenuLinkConfigForm`). Saved links show in the normal menu tree alongside
module and content links.

Access note: the add route uses `_entity_create_access` against the entity's
`admin_permission = "administer menu link config"` (declared in the `@ConfigEntityType` on
`src/Entity/MenuLinkConfig.php`). That permission is **not defined in any `*.permissions.yml`**, so the
core entity-access check grants create only to user 1 (the super-admin bypass). Edit and delete instead
require the real core `administer menu` permission. There is no `menu_link_config.permissions.yml`.

## Form fields (`MenuLinkConfigForm`)

`src/Plugin/Menu/Form/MenuLinkConfigForm.php` is both the entity form and the menu-link-plugin form.

| Field | Type | Stored as | Notes |
|---|---|---|---|
| Title | textfield | `title` | Link label. |
| Machine name | machine_name | `id` | Source `title`; uniqueness via `MenuController::menuLinkExists()`; locked once set. |
| Description | textfield | `description` | Hover title. |
| Link path | textfield (required) | parsed into `route_name` + `route_parameters` + `options` (external → `url`) | Internal path (e.g. `/node/add`), external URL, `<front>`, or `route:<nolink>`. |
| Enable menu link | checkbox | `enabled` / entity `status` | Disabled links are not listed. |
| Show as expanded | checkbox | `expanded` | Expand children. |
| Parent link | parent selector | `menu_name` + `parent` | From `menu.parent_form_selector`. |
| Weight | number | `weight` | Ordering. |

Validation (`doValidate()`): external URLs and `<nolink>` are allowed; an internal route is accepted only
if `access_manager->checkNamedRoute()` passes for the **current user** — you cannot link to a page you
cannot access (same rule core uses). Entered path is normalised against the path-alias manager.

## The config object

One config object per link, named `menu_link_config.menu_link_config.{id}`. Exported keys (from
`config_export` on the entity and `config/schema/menu_link_config.schema.yml`):

| Key | Type | Meaning |
|---|---|---|
| `id` | string | Machine name. |
| `title` | text | Link title. |
| `route_name` | string | Drupal route (`<front>` when empty). |
| `route_parameters` | sequence | Route parameters. |
| `options` | sequence | Url options (e.g. `query`, `fragment`, external `url`). |
| `expanded` | boolean | Expanded flag. |
| `menu_name` | string | Owning menu (e.g. `main`). |
| `enabled` | boolean | Enabled/hidden. |
| `parent` | string | Parent plugin id, e.g. `menu_link_config:{parent_id}`. |
| `weight` | integer | Ordering. |
| `description` | text | Hover description. |

Export a single link at `admin/config/development/configuration/single/export` (or the whole set with
`drush cex`) and it imports on other environments with `drush cim`.

### Create / set with PHP

```php
$link = \Drupal::entityTypeManager()->getStorage('menu_link_config')->create([
  'id' => 'about_us',
  'title' => 'About us',
  'menu_name' => 'main',
  'parent' => '',
  'enabled' => TRUE,
  'weight' => 0,
]);
// A route-based target:
$link->route_name = 'entity.node.canonical';
$link->route_parameters = ['node' => 42];
// ...or an external target: $link->options = ['url' => 'https://example.com'];
$link->save();
```

## What happens at runtime

- **Menu-tree sync**: `MenuLinkConfig::postSave()` (`src/Entity/MenuLinkConfig.php`) pushes the entity's
  `getPluginDefinition()` into the core menu link manager (`plugin.manager.menu.link`) — `addDefinition()`
  for a new link, `updateDefinition()` if it already exists. `preDelete()` calls `removeDefinition()` and
  re-parents any children to the deleted link's parent. So saving/deleting the config entity is what
  keeps the rendered menu current; you do not edit the tree separately.
- **Plugin derivation**: `Plugin\Derivative\MenuLinkConfig` loads every `menu_link_config` entity and
  emits one menu link plugin per entity (id `menu_link_config:{id}`, class
  `Plugin\Menu\MenuLinkConfig extends MenuLinkBase`). Registered in `menu_link_config.links.menu.yml`.
  Links render through core's access-aware menu tree; titles/descriptions come from the plugin definition
  (or the translated entity when the site is multilingual).
- **Edit-form template**: `hook_entity_type_build()` (`menu_link_config.module`) points the entity
  `edit-form` link at `/admin/structure/menu/link/{menu_link_plugin}/edit` when `menu_ui` is enabled; that
  route reuses core `menu_ui`'s `MenuLinkEditForm`, which loads this module's plugin form.

## Translation (optional)

`config_translation` integration is wired in `menu_link_config.module`
(`hook_config_translation_info_alter()`) plus `src/MenuLinkConfigMapper.php` (extends `ConfigEntityMapper`).
When `config_translation` is installed, a link is translatable via that module's mapper (a "Translate"
route on the link). These are **config** translations — not core content translation, which only covers
`menu_link_content`. Check your multilingual approach before adopting on a translated site.

## Dependencies & footprint

`menu_link_config.info.yml` declares **no** `dependencies`. In practice `menu_ui` is required (the action
link, the edit route, and both `hook_entity_type_build`/`hook_config_translation_info_alter` are guarded by
`moduleExists('menu_ui')`); `config_translation` is optional. No Drush commands, blocks, views, fields, or
events. `hook_help()` provides help at `help.page.menu_link_config`.
