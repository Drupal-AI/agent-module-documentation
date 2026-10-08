# Aggregator pipeline plugins

The import runs in three stages, each a plugin type managed by
`Drupal\aggregator\Plugin\AggregatorPluginManager` (three service instances:
`plugin.manager.aggregator.fetcher`, `.parser`, `.processor`). Plugins live in
`src/Plugin/aggregator/{type}/`. One fetcher and one parser are active at a time;
processors are a list (multiple active). Orchestrated by `ItemsImporter::refresh()`.

| Type | Interface | Default plugin (id `aggregator`) | Job |
|---|---|---|---|
| fetcher | `Plugin\FetcherInterface` | `DefaultFetcher` | Download raw feed data (Guzzle, ETag/If-Modified-Since). Sets `$feed->source_string`. |
| parser | `Plugin\ParserInterface` | `DefaultParser` (uses laminas-feed) | Convert raw data → common item array on `$feed`. |
| processor | `Plugin\ProcessorInterface` | `DefaultProcessor` | Act on parsed items — default stores them as `aggregator_item` entities and expires old ones. |

## Interfaces (methods to implement)

- **FetcherInterface**: `fetch(FeedInterface $feed): bool` — download `$feed->getUrl()`, attach to `$feed->source_string`, return success.
- **ParserInterface**: `parse(FeedInterface $feed): bool` — read `$feed->getSourceString()`, set `description`, `link`, `image`, `etag`, `modified`, and `items[]` (each: `title`, `description`, `timestamp`, `author`, `guid`, `link`).
- **ProcessorInterface**: `process(FeedInterface $feed)`, `postProcess(FeedInterface $feed)`, `delete(FeedInterface $feed)` — act on `$feed->getItems()`, finalize, and clean up when a feed/items are deleted.

## Writing a plugin

Use the PHP attribute (annotations also still supported via `src/Annotation/`):

```php
namespace Drupal\my_module\Plugin\aggregator\fetcher;

use Drupal\aggregator\Attribute\AggregatorFetcher;
use Drupal\aggregator\FeedInterface;
use Drupal\aggregator\Plugin\FetcherInterface;
use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\Core\Plugin\PluginBase;

#[AggregatorFetcher(
  id: 'my_fetcher',
  title: new TranslatableMarkup('My fetcher'),
  description: new TranslatableMarkup('Fetches with custom auth.'),
)]
class MyFetcher extends PluginBase implements FetcherInterface {
  public function fetch(FeedInterface $feed) {
    // ... set $feed->setSourceString($raw); return TRUE/FALSE.
  }
}
```

Attribute classes: `AggregatorFetcher`, `AggregatorParser`, `AggregatorProcessor`
(each: `id`, `title`, optional `description`, `deriver`). Plugins needing their own
settings form extend `AggregatorPluginSettingsBase` (implements `PluginFormInterface`,
`ConfigurableInterface`) — the settings form calls each active plugin's
`buildConfigurationForm()`. Once defined, the plugin becomes selectable on
`/admin/config/services/aggregator/settings` (radios/checkboxes appear when >1 plugin
of a type exists) and is stored in `aggregator.settings`.

To override an existing plugin's class instead of adding a new one, use the
`*_info_alter` hooks → see [../hooks/alters.md](../hooks/alters.md).
