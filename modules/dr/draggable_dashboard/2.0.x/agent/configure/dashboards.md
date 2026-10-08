# Manage dashboards

## UI flow

1. **Structure → Draggable Dashboard** (`admin/structure/draggable-dashboard`) — list builder of
   all `dashboard_entity` config entities.
2. **Add Dashboard** (`/admin/structure/draggable-dashboard/add`) — `DashboardForm` collects
   title, description, and column count.
3. On the dashboard edit form, for each column click **Place block** → a modal
   (`draggable_dashboard.block_library`, `DraggableDashboardController::listBlocks`) lists the
   standard, context-filtered block library (`getFilteredDefinitions('block_ui', …)`).
4. Choose a block → `DashboardAssignBlockForm` renders that block plugin's own configuration
   form (reused via `plugin_form.factory`), plus a machine-name and a target **Column** select.
5. Drag blocks to reorder / move between columns (JS `core/sortable`). Save.
6. Place the dashboard on the site: **Structure → Block layout**, add the block
   *Dashboard: `<title>`* (needs `administer blocks`).

Routes (all require `administer_draggable_dashboard`):
`…/{dashboard_entity}/list-blocks/{region}`, `…/add/{plugin_id}/{region}`,
`…/configure/{block_id}`, `…/delete/{block_id}`, plus the entity add/edit/delete/collection links.

## Config entity: `dashboard_entity`

```yaml
# draggable_dashboard.dashboard_entity.<id>
id: my_dashboard
title: 'My dashboard'
description: '…'
columns: 3
blocks:
  <machine_name>:
    column: 1              # 1-based column index
    settings: { id: <block_plugin_id>, label: '…', … }   # the inner block plugin config
    weight: 0
```

Schema: `config/schema/dashboard_entity.schema.yml` (`draggable_dashboard.dashboard_entity.*`
and `draggable_dashboard.block`). `config_export` = id, title, description, columns, blocks.

## Create a dashboard with Drush/PHP

```php
// drush php:eval
$d = \Drupal::entityTypeManager()->getStorage('dashboard_entity')->create([
  'id' => 'my_dashboard', 'title' => 'My dashboard', 'columns' => 2,
  'blocks' => [
    'clock' => ['column' => 1, 'weight' => 0, 'settings' => ['id' => 'system_powered_by_block', 'label' => 'Powered by']],
  ],
]);
$d->save();
```

After creating a dashboard the derived block appears automatically (deriver reads all
`dashboard_entity` ids). Then place `draggable_dashboard_block:draggable_dashboard_my_dashboard`
via Block layout.

## Rendering

`DraggableBlock::build()` loads the dashboard, iterates columns, and for each stored block calls
`blockManager->createInstance($settings['id'], $settings)`. Each inner block is rendered **only
if `$block_instance->access($currentUser)` passes**, so per-block access control is preserved.
Blocks implementing `TitleBlockPluginInterface` get the current route's page title. The outer
block's own visibility is `access content` (`blockAccess()`), cache context `user.permissions`,
cache tags from the dashboard entity.
