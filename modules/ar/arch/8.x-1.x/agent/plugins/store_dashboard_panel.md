<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `store_dashboard_panel` plugin type

Panels are the boxes rendered on the `/admin/store` dashboard. Any Arch (or custom) module can
add one; `arch_order` ships an `OrderCount` panel as an example.

## Wiring

- Manager service: **`plugin.manager.store_dashboard_panel`**, class
  `Drupal\arch\StoreDashboardPanel\StoreDashboardPanelManager` (extends `DefaultPluginManager`,
  uses `CategorizingPluginManagerTrait` + `FilteredPluginManagerTrait`, implements
  `FallbackPluginManagerInterface`).
- Discovery dir: `Plugin/StoreDashboardPanel`. Annotation:
  `@StoreDashboardPanel` (`Annotation\StoreDashboardPanel`: `id`, `admin_label`).
- Interface each plugin implements: `StoreDashboardPanelPluginInterface`; base class
  `StoreDashboardPanel`. Fallback (broken) plugin id: **`broken`** (hidden from sorted lists;
  `handlePluginNotFound()` logs a warning).
- Cache: `store_dashboard_panel_plugins` bin.

## Writing a panel

```php
namespace Drupal\my_module\Plugin\StoreDashboardPanel;

use Drupal\arch\StoreDashboardPanel\StoreDashboardPanel;

/**
 * @StoreDashboardPanel(
 *   id = "my_panel",
 *   admin_label = @Translation("My panel")
 * )
 */
class MyPanel extends StoreDashboardPanel {

  public function build() {
    // Return a render array, or empty to render nothing.
    return ['#markup' => 'Hello store'];
  }

}
```

`DashboardController::buildPanels()` instantiates every definition, calls `build()`, skips empty
results, and wraps each in a container classed `arch-dashboard-panel--<provider:id>`. Panels can
be reordered/removed by other modules via the `arch_dashboard_panels` alter hook.

## Reference implementation

`arch_order`'s `Drupal\arch_order\Plugin\StoreDashboardPanel\OrderCount` renders an order counter
on the dashboard — see the `arch_order` docs.
