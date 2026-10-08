# Plugin type: `opentelemetry_trace`

A plugin type that declares a *kind of thing to trace*. Enabled plugins are toggled in
`opentelemetry.settings:span_plugins_enabled`; the service checks `isPluginEnabled($id)`.

## Manager & discovery

- Manager service `plugin.manager.opentelemetry_trace` (`OpentelemetryTraceManager`, extends
  `DefaultPluginManager`).
- Discovery subdir: `src/Plugin/opentelemetry/OpenTelemetryTrace/`.
- Annotation: `@OpenTelemetryTrace` (`Drupal\opentelemetry\Annotation\OpenTelemetryTrace`) — properties
  `id`, `label`, `description`.
- Alter hook: `hook_opentelemetry_span_plugins_alter`. Cache bin key `opentelemetry_span_plugins`.
- Base class: `OpentelemetryTraceBase` (extends `PluginBase`).

## Bundled plugins

| Plugin id | Default on? | Notes |
|---|---|---|
| `request` | yes | Traces the whole request (root span handled by `OpentelemetryService`). |
| `exception` | yes | Traces all exceptions (via `ExceptionTraceEventSubscriber`). |
| `database_statement` | no | Traces every DB statement; `isAvailable()` requires core ≥ 10.1 (`Drupal\Core\Database\Event\DatabaseEvent`). Marked unavailable with a reason otherwise. |

The corresponding event subscribers (`RequestTraceEventSubscriber`, `ExceptionTraceEventSubscriber`,
`DatabaseStatementTraceEventSubscriber`) do the actual span work when their plugin is enabled.

## Base-class methods you can override

| Method | Default | Purpose |
|---|---|---|
| `enabledByDefault(): bool` | `false` | If a plugin isn't listed in settings, this decides its status (`request`/`exception` return `true`). |
| `isAvailable(): bool` | `true` | Environment/version gate; unavailable plugins are disabled + shown greyed on the form. |
| `getUnavailableReason(): ?string` | `null` | Human message shown when `isAvailable()` is false. |

## Add a custom trace plugin

```php
// src/Plugin/opentelemetry/OpenTelemetryTrace/CacheTrace.php
namespace Drupal\my_module\Plugin\opentelemetry\OpenTelemetryTrace;

use Drupal\opentelemetry\Plugin\opentelemetry\OpenTelemetryTrace\OpentelemetryTraceBase;

/**
 * @OpenTelemetryTrace(
 *   id = "cache",
 *   label = @Translation("Cache operations"),
 *   description = @Translation("Traces cache get/set operations."),
 * )
 */
class CacheTrace extends OpentelemetryTraceBase {
  public function enabledByDefault(): bool { return FALSE; }
}
```

Then gate your own event subscriber on
`\Drupal::service('opentelemetry')->isPluginEnabled('cache')` and create spans with the tracer (see
[api/service.md](../api/service.md)). Enable it on the settings form under **Enabled Span Plugins**.
