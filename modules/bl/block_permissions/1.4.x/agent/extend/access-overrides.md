<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# What it overrides on core block routes

## Route subscriber

`block_permissions.route_subscriber` → `Drupal\block_permissions\Routing\RouteSubscriber`
(`RouteSubscriberBase::alterRoutes()`), adding a `_custom_access` requirement:

| Core route | Added `_custom_access` | Also |
|---|---|---|
| `block.admin_display` (`/admin/structure/block`) | `BlockPermissionsAccessControlHandler::blockListAccess` | |
| `block.admin_display_theme` (`/admin/structure/block/list/{theme}`) | `…::blockThemeListAccess` | |
| `block.admin_add` (`/admin/structure/block/add/{plugin_id}/{theme}`) | `…::blockAddFormAccess` | |
| `entity.block.edit_form` | `…::blockFormAccess` | |
| `entity.block.delete_form` | `…::blockFormAccess` | |
| `block.admin_library` (`/admin/structure/block/library/{theme}`) | `…::blockThemeListAccess` | `_controller` replaced with `BlockPermissionsBlockLibraryController::listBlocks` |

The original requirements stay in place — `_custom_access` is *added*, so core's
`administer blocks` is still enforced.

## Access handler

`Drupal\block_permissions\BlockPermissionsAccessControlHandler` (a plain
`ContainerInjectionInterface` service-less class, built from `plugin.manager.block`,
`current_user`, `config.factory`):

```php
blockListAccess()                       // theme = config('system.theme')->get('default')
  -> allowedIfHasPermission('administer block settings for theme ' . $theme)

blockThemeListAccess($theme)            // {theme} route parameter
  -> allowedIfHasPermission('administer block settings for theme ' . $theme)

blockAddFormAccess($plugin_id, $theme)  // both required
  -> allowedIfHasPermissions([
       'administer blocks provided by ' . $definition['provider'],
       'administer block settings for theme ' . $theme,
     ])

blockFormAccess(Block $block)           // provider from the block's plugin configuration
  -> allowedIfHasPermission('administer blocks provided by ' . $configuration['provider'])
```

Note `blockFormAccess()` reads the provider from `$block->getPlugin()->getConfiguration()['provider']`,
i.e. the *saved* configuration, not the plugin definition.

## Block library controller

`Drupal\block_permissions\Controller\BlockPermissionsBlockLibraryController extends
Drupal\block\Controller\BlockLibraryController` — it calls the parent, then drops every row
whose `operations.data.#links.add.url` fails `->access()`. So the "Place block" modal only
lists blocks the user may actually add.

## Block layout form alter

`block_permissions_form_block_admin_display_form_alter()` iterates the rows of
`$form['blocks']`, skipping keys starting with `region`, loads each `Block` entity and, when
the user lacks `administer blocks provided by <settings['provider']>`:

- turns the `weight` element into `#type: hidden`;
- sets `region-theme` and `operations` to `#access: FALSE`;
- replaces the `draggable` class with `undraggable`.

The row is therefore visible but read-only.

## Extending

There is no hook, event, plugin type or service to override — the handler class is
referenced by string in route requirements. To change the rules, either implement your own
`RouteSubscriber` with a later priority that re-points `_custom_access`, or replace the
`block_permissions.route_subscriber` service.
