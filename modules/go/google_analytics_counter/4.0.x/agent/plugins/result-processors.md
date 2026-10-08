# Result-processor plugin type

GA4 result rows do not map 1:1 to Drupal nodes (a node has many URLs/aliases/languages). A
**result processor** plugin decides how a query result maps onto the `google_analytics_counter` path table
and how a node's total is computed. The active processor is chosen on the settings form
(`general_settings.result_processor`).

## Plugin type definition

| Piece | Value |
|---|---|
| Manager service | `plugin.manager.google_analytics_counter_result_processor` |
| Manager class | `GoogleAnalyticsCounterResultProcessorPluginManager` |
| Discovery directory | `src/Plugin/GoogleAnalyticsCounterResultProcessor/` |
| Annotation | `@GoogleAnalyticsCounterResultProcessor` (`src/Annotation/GoogleAnalyticsCounterResultProcessor.php`) |
| Interface | `GoogleAnalyticsCounterResultProcessorInterface` |
| Base class | `GoogleAnalyticsCounterResultProcessorPluginBase` |
| Alter hook | `google_analytics_counter_result_processor_info` |
| Cache key | `google_analytics_counter_result_processor_plugins` |

Manager helpers: `getPlugin($id)` (creates an instance), `getAllPluginsLabels()` (id→label, used for the
settings select), `getAllPlugins()` (definitions).

## Built-in plugins

| id | Class | Label | Behavior |
|---|---|---|---|
| `url_alias` | `UrlAliasResultProcessor` | URL Alias | Default. Stores each cleaned `pagePath` (query string stripped, lower-cased, ≤2047 chars) → pageviews; a node's total sums all its aliases/languages/trailing-slash + `/node/{nid}` variants. |
| `default` | `DefaultResultProcessor` | NID | For queries whose dimension is a node id; strips leading zeroes and stores `nid`→pageviews directly. |

## Methods a processor implements

Extend `GoogleAnalyticsCounterResultProcessorPluginBase` and implement (or override):

| Method | Purpose |
|---|---|
| `processPagePathResultRows($feed)` *(abstract)* | Turn a `RunReportResponse` into `['key' => viewcount]` to save into `google_analytics_counter`. |
| `gacDisplayCount()` *(abstract)* | Return the formatted count for the current request context (front page / node / path). |
| `processGacUpdateStorage($nid, $bundle, $vid)` | Return the summed viewcount to store for a node (base default = `sumPageviews([$nid])`). |
| `isUpdatePathTable()` | Return FALSE to skip writing the path table (default TRUE). |
| `isUpdateGacStorage()` | Return FALSE to skip writing the node-storage table (default TRUE). |
| `sumPageviews($aliases)` *(protected helper)* | Sum `pageviews` for md5-hashed paths via `IN` query. |
| `label()` | Provided by the base from the plugin definition's `label`. |

## Add a processor

```php
// src/Plugin/GoogleAnalyticsCounterResultProcessor/MyProcessor.php
namespace Drupal\my_module\Plugin\GoogleAnalyticsCounterResultProcessor;

use Drupal\google_analytics_counter\GoogleAnalyticsCounterResultProcessorPluginBase;

/**
 * @GoogleAnalyticsCounterResultProcessor(
 *   id = "my_processor",
 *   label = @Translation("My processor"),
 *   description = @Translation("Maps GA rows my way.")
 * )
 */
class MyProcessor extends GoogleAnalyticsCounterResultProcessorPluginBase {
  public function processPagePathResultRows($feed) { /* return ['path' => views] */ }
  public function gacDisplayCount() { /* return number_format($count) */ }
}
```

It appears in the settings form's **Result processor** select automatically. (Annotate with `id`, `label`,
`description`; the manager reads `label` for the option text.)
