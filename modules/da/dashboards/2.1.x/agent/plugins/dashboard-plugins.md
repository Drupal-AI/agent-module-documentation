<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Dashboard plugin type (widgets)

Widgets are **Dashboard** plugins. The module defines the plugin type and exposes each plugin as a block.

- **Manager:** `plugin.manager.dashboard` (`Drupal\dashboards\Plugin\DashboardManager`), discovers
  `Plugin/Dashboard`, alter hook `dashboards_dashboard_info`, dedicated cache bin `dashboards`.
- **Interface / base:** `DashboardInterface`, base class `DashboardBase` (implements
  `ContainerFactoryPluginInterface`; provides `getCache()` / `setCache()` on the `dashboards.cache` bin).
- **Annotation:** `@Dashboard(id="...", label=@Translation("..."), category=@Translation("..."))`.
- **Block exposure:** `Plugin/Block/DashboardBlock` (block id `dashboards_block`) with deriver
  `Plugin/Derivative/DashboardBlock` — every Dashboard plugin becomes a block
  **`dashboards_block:dashboard:<plugin_id>`** (admin_label = plugin label, category = plugin category),
  which is what you place in Layout Builder.

## Shipped widgets (base module)

| id | label | category |
|---|---|---|
| `account` | Show current user | Dashboards: User |
| `add_content_menu` | Add content menu | Dashboards |
| `view_embed` | Embed a view | Dashboards: Views |
| `report_not_found` | Page-not-found report | Dashboards |
| `system_info` | Show system info | Dashboards: System |
| `node_statistics` | Node statistics | Dashboards |
| `status_updates` | Status updates | Dashboards |
| `error_report` | Error report | Dashboards |
| `rss_news` | RSS news (uses laminas-feed) | Dashboards |

Submodules add more (`comments_statistic`, `node_most_readed`, `webform_submissions`, matomo widgets).

## Write a widget

```php
namespace Drupal\my_module\Plugin\Dashboard;

use Drupal\dashboards\Plugin\DashboardBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * @Dashboard(
 *   id = "my_widget",
 *   label = @Translation("My widget"),
 *   category = @Translation("Custom")
 * )
 */
class MyWidget extends DashboardBase {

  public function buildRenderArray(array $configuration): array {
    return ['#markup' => 'Hello from my widget'];
  }

  // Optional: per-instance settings on the Layout Builder block form.
  public function buildSettingsForm(array $form, FormStateInterface $form_state, array $configuration): array {
    $form['count'] = ['#type' => 'number', '#default_value' => $configuration['count'] ?? 10];
    return $form;
  }
  // Optional: validateForm(), massageFormValues().
}
```

`buildRenderArray()` is required. Use `$this->setCache($cid, $data, $expire, $tags)` /
`$this->getCache($cid)` to cache expensive data (keyed per plugin id).

## Charts (`ChartTrait`)

Chart widgets `use Drupal\dashboards\Plugin\Dashboard\ChartTrait` and call `setLabels()`, `setRows()`,
optionally `setChartType()`, then `renderChart($configuration)`. Colors come from `dashboards.settings`
(`colormap` / `alpha` / `shades`). See the comments / statistic / webform submodule widgets for examples.
