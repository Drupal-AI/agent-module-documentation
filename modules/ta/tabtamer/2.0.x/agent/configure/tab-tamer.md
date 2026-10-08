# Configure Tab tamer

Manage tabs at **Structure › Tab tamer** (`/admin/structure/tab-tamer`, route
`entity.tab_tamer.collection` = the module's `configure`). All routes require the single
`administer tab_tamer` permission (also the entity `admin_permission`).

## The `tab_tamer` entity

Config name `tabtamer.tab_tamer.<id>`. `config_export` = `id`, `label`, `tabs`. The `status`
boolean exists on the entity and is toggled by the **Enabled** checkbox, but it is **not** in
`config_export`, so it is not written to exported config.

- **`label`** = the **route machine name** to control (e.g. `entity.node.canonical`,
  `entity.user.canonical`). `TabTamer::getByRoute($route)` loads the entity by matching `label`.
- **`tabs`** = a sequence of `{id, label, link, weight, access}`:
  - `label` — the local-task **plugin id** of the tab (disabled/read-only field in the form).
  - `link` — the display **Link title** to show for that tab.
  - `weight` — integer, drag-ordered.
  - `access` — boolean **Display** checkbox; `FALSE` hides the tab.

## Add/edit form (`TabTamerForm`)

Route `entity.tab_tamer.add_form` (`/admin/structure/tab_tamer/add`). When opened with a `?route=`
query (the injected "Add tabtamer" tab supplies the current route), the **Route name** field is
pre-filled; changing it triggers an AJAX rebuild. The form calls
`plugin.manager.menu.local_task` → `getLocalTasksForRoute($route)` and adds a table row for every
discovered local task, seeded `access = TRUE`. Machine name defaults to the route with `.`→`_`.

## How it is applied at render (`tabtamer_menu_local_tasks_alter`)

For the current route it loads the matching entity; if `status()` is true, for each configured tab
present in `$data['tabs']` it sets `#weight = weight`, `#link['title'] = link`, and when
`access` is false sets `#access = AccessResultForbidden::forbidden(...)`. Cache tags from the entity
are added for invalidation. Users with `administer tab_tamer` also get an injected Add/Edit tabtamer
tab (`#weight` 101).

> Scope: Tab tamer only **relabels, reorders, or forbids** tabs. It never sets a tab's access to
> allowed, so it cannot expose a tab a user lacks access to — hiding here is presentation, not a
> substitute for the tab's own route access checks.

## Drush example

```php
\Drupal::entityTypeManager()->getStorage('tab_tamer')->create([
  'id' => 'entity_node_canonical',
  'label' => 'entity.node.canonical',
  'tabs' => [
    ['id' => 'entity.node.canonical', 'label' => 'entity.node.canonical', 'link' => 'Read', 'weight' => -10, 'access' => TRUE],
    ['id' => 'entity.node.delete_form', 'label' => 'entity.node.delete_form', 'link' => 'Delete', 'weight' => 10, 'access' => FALSE],
  ],
])->save();
```
