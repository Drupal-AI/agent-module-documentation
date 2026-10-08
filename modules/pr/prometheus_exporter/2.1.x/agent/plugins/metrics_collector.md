<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin type: `metrics_collector`

Add your own metric by writing a MetricsCollector plugin.

- Manager: `plugin.manager.metrics_collector` (`MetricsCollectorPluginManager`, extends
  `DefaultPluginManager`). Discovers `src/Plugin/MetricsCollector/*`.
- Attribute: `Drupal\prometheus_exporter\Attribute\MetricsCollector` (legacy annotation
  `Annotation\MetricsCollector` also supported). Params: `id`, `title`, `description`, `weight`,
  `enabled` (default FALSE), `settings`, `deriver`.
- Interface: `Plugin\MetricsCollectorInterface` (`ConfigurableInterface`, `DependentPluginInterface`,
  `PluginInspectionInterface`). Base class: `Plugin\BaseMetricsCollector`.

Implement `collectMetrics(): \PNX\Prometheus\Metric[]`. Other methods (`getLabel`, `getDescription`,
`isEnabled`, `applies`, `getWeight`, `getProvider`, `settingsForm`) come from the base; override
`applies()` to skip when a dependency is missing, and `settingsForm()` to expose per-collector config.

Skeleton:
```php
namespace Drupal\my_module\Plugin\MetricsCollector;

use Drupal\prometheus_exporter\Attribute\MetricsCollector;
use Drupal\prometheus_exporter\Plugin\BaseMetricsCollector;
use Drupal\Core\StringTranslation\TranslatableMarkup;
use PNX\Prometheus\Gauge;
use PNX\Prometheus\LabelSet;

#[MetricsCollector(
  id: 'my_orders',
  title: new TranslatableMarkup('Order count'),
  description: new TranslatableMarkup('Number of commerce orders.'),
  enabled: FALSE,
)]
final class OrderCount extends BaseMetricsCollector {

  public function collectMetrics(): array {
    $gauge = new Gauge('drupal', 'orders_total', 'Total orders.');
    $gauge->set(42, new LabelSet(['state' => 'completed']));
    return [$gauge];
  }
}
```
The plugin appears on the settings form automatically; it is exported only once an admin enables it
(or you set `collectors.my_orders.enabled: true` in `prometheus_exporter.settings`). Inject services via
constructor + `create()` as usual — the manager passes container-aware plugins through.

The built-in collectors under `src/Plugin/MetricsCollector/` (e.g. `NodeCount`, `QueueSizeCollector`,
`UserCount`) are the reference implementations, and the two submodule collectors
(`comment_count`, `update_status`) show cross-module dependencies via `applies()`.
