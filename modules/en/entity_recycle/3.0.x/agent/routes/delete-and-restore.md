<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Delete interception, restore & the recycle-bin view

## Delete-form interception (`Routing\RouteSubscriber`)

`RouteSubscriber::alterRoutes()` runs for every entity type listed in `entity_recycle.settings`
`types`. For each, it takes the core route `entity.<type>.delete_form` and rewrites it:
- swaps the `_entity_form` default for `_form => Form\EntityRecycleDeleteForm`,
- sets option `entity_type => <type>` and a `parameters` upcast for the entity,
- sets the route requirement to `_permission: 'add entity recycle bin items'`.

So the normal "Delete" link on an enabled entity now opens `EntityRecycleDeleteForm`.

## Delete form (`Form\EntityRecycleDeleteForm`)

`buildForm()` builds the core delete confirm form via `entity.form_builder->getForm($entity,
'delete')`, then:
- If the entity's `recycle_bin` value is truthy (already in the bin): require
  `EntityRecycleViewManager::RECYCLE_BIN_DELETE_PERMISSION` (`delete entity recycle bin items`) —
  throwing `AccessDeniedHttpException` if missing — and set the title to "permanently delete".
- Otherwise: title "move … to recycle bin" and relabel the submit button **Move**.

It removes the core `ContentEntityDeleteForm` submit handler and unshifts its own `submitForm()`
first. `submitForm()`:
- If the entity is **already binned** (or has no `recycle_bin` field): invoke
  `recycle_bin_entity_pre_delete`, `$entity->delete()`, invoke `recycle_bin_entity_deleted`
  (permanent delete).
- Else: `EntityRecycleManager::addItem($entity)` → moves it to the bin (sets `recycle_bin = 1` and
  unpublishes).

This is a two-stage delete: first delete moves to the bin, second delete on a binned item removes it.

## Restore route & form

Route **`entity_recycle.entity.restore`** → `/entity_recycle/restore/{entity_type}/{id}`,
`_admin_route`, permission **`restore entity recycle bin items`**. Handled by
`Form\RestoreEntityForm` (a `ConfirmFormBase`, so submission is a CSRF-protected POST confirm).
It loads the entity from the `{entity_type}`/`{id}` route parameters, and on confirm calls
`EntityRecycleManager::removeItem()`, invokes `recycle_bin_entity_restored`, shows a success
message, and redirects to the entity's canonical route. Restore removes the bin flag only; it does
not re-publish the entity.

## Recycle-bin listing view

`config/install/views.view.content_recycle_bin.yml` — id `content_recycle_bin`, page display path
**`admin/content/node/recycle-bin`** (tab/menu link under *Content*). Base table `node_field_data`,
filtered by `recycle_bin_value = 1` (join `node__recycle_bin`). Columns: title (link to entity),
type, author, status, updated, and an entity **operations** dropbutton (Edit/Delete + the Restore
op added by `hook_entity_operation`). Access plugin: **perm `view entity recycle bin items`**. The
view is deleted on uninstall.

## Permissions (`entity_recycle.permissions.yml`)

| Permission | Guards |
|---|---|
| `view entity recycle bin items` | the recycle-bin view + `entityAccess()` view of binned items |
| `add entity recycle bin items` | the rewritten `entity.<type>.delete_form` route (move to bin) |
| `restore entity recycle bin items` | the restore route/form |
| `delete entity recycle bin items` | permanent delete of a binned item; keeps the Delete op visible |
| `administer entity recycle bin` | the settings form |

## Excluding recycled items from other views

By design the module does not filter recycled entities out of other existing views. Add a
`recycle_bin = FALSE` field filter to those views, or implement `hook_views_query_alter()` (the
README ships an example that skips `content_recycle_bin`/`manage_content_recycle_bin`).
