<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Activating form modes & settings

## Activate a form mode (the core workflow)

1. **Create a form mode**: *Structure > Display modes > Form modes* →
   `/admin/structure/display-modes/form/add/{entity_type}` (e.g. `node`). This creates an
   `entity_form_mode` config entity `<entity_type>.<mode>` (id e.g. `node.contributor`).
2. **Enable it on a bundle**: on the bundle's *Manage form display*
   (`/admin/structure/types/manage/{type}/form-display`), open **Custom Display settings** at the
   bottom, tick the form mode, Save. This creates a `core.entity_form_display.<entity>.<bundle>.<mode>`
   config entity — which is exactly what Form Mode Manager treats as an **active** form mode
   (`FormModeManager::getActiveDisplays()` lists `core.entity_form_display.<entity>.*` with mode
   != `default`).
3. Form Mode Manager then generates the routes/tabs/links (see below). Use it via
   `entity/add/{bundle}/{mode}` (e.g. `node/add/article/contributor`) or the edit tab.

Programmatic activation (equivalent of step 2):

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->create([
  'targetEntityType' => 'node', 'bundle' => 'article', 'mode' => 'contributor', 'status' => TRUE,
]);
$fd->save();
```

## Generated routes / links

For an active mode the module derives, per entity type (via `EntityRoutingMap` operations):
add route (`node.add.<mode>` / `entity.<type>.add_form.<mode>`), edit route
(`entity.<type>.edit_form.<mode>`), local tasks (`FormModeManagerLocalTasks`), local actions
(`FormModeManagerLocalAction`), and contextual links (`FormModeManagerContextualLinks`).

## Settings form 1 — exclude form modes

Route **`form_mode_manager.admin_settings`** = **`/admin/config/content/form_mode_manager`**
(the `configure` route; form `FormModeManagerForm`, permission `administer site configuration`).
Config object **`form_mode_manager.settings`**:

```yaml
form_modes:
  <entity_type>:
    to_exclude:
      <mode>: <mode>       # excluded modes (map of machine name => machine name)
```

Shipped defaults exclude `user.register` and `commerce_order_item.add_to_cart`. Excluded modes
get no routes/links from FMM.

```bash
drush cget form_mode_manager.settings form_modes
```

## Settings form 2 — local task position

Route **`form_mode_manager.admin_settings_links_task`** =
**`/admin/config/content/form_mode_manager/links-task`** (form `FormModeManagerLinksForm`).
Config object **`form_mode_manager.links`**:

```yaml
local_tasks:
  <entity_type>:
    position: primary | secondary
```

Move a mode's tasks to the **primary** level (same level as *Edit*) when you restrict the default
form for a role and want the form-mode tabs promoted.
