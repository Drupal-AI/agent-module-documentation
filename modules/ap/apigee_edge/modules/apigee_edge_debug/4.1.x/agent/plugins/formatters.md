# DebugMessageFormatter plugin type

The module defines a plugin type for rendering the logged HTTP messages.

- Manager: `plugin.manager.apigee_edge_debug.debug_message_formatter`
  (`DebugMessageFormatterPluginManager`).
- Annotation: `\Drupal\apigee_edge_debug\Annotation\DebugMessageFormatter` (`id`, `label`).
- Interface / base: `DebugMessageFormatterPluginInterface` / `DebugMessageFormatterPluginBase`
  (`src/Plugin/DebugMessageFormatter/`). The base implements the `remove_credentials` /
  `mask_organization` sanitization; concrete plugins just supply the wrapped `Http\Message\Formatter`.

## Shipped formatters

| Plugin id | Class | Output |
|---|---|---|
| `full_html` | `FullHttpMessageFormatter` | Full HTTP request + response with headers and (uncapped) body — the default. |
| `simple` | `SimpleFormatter` | Concise one-line-ish summary of the request/response. |
| `curl` | `CurlCommandFormatter` | The request as a runnable `curl` command (no response/stats). |

There is also `DevelKintApiClientProfiler` (middleware `apigee_edge_debug.devel_client_profiler`) that
dumps the same data via Devel/Kint for the current user when Devel is enabled.

## Add a formatter
```php
namespace Drupal\my_module\Plugin\DebugMessageFormatter;

use Drupal\apigee_edge_debug\Plugin\DebugMessageFormatter\DebugMessageFormatterPluginBase;
use Http\Message\Formatter;

/**
 * @DebugMessageFormatter(
 *   id = "my_formatter",
 *   label = @Translation("My formatter"),
 * )
 */
class MyFormatter extends DebugMessageFormatterPluginBase {
  protected function getFormatter(): Formatter { /* return a Http\Message\Formatter */ }
}
```
Your class inherits credential/organization masking from the base, so those settings keep working.
Select it at `/admin/config/apigee-edge/debug`.
