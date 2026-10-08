# Feeds plugin types

Feeds defines **six** plugin types, each with its own manager
(`plugin.manager.feeds.<type>`, class `Drupal\feeds\Plugin\Type\FeedsPluginManager`) and legacy
annotation in `src/Annotation/`. Plugins live under a module's `src/Feeds/<Kind>/` namespace.

| Type | Namespace | Annotation | Interface | Built-ins |
|---|---|---|---|---|
| fetcher | `Feeds\Fetcher` | `@FeedsFetcher` | `Fetcher/FetcherInterface` | `http`, `upload`, `directory` |
| parser | `Feeds\Parser` | `@FeedsParser` | `Parser/ParserInterface` | `syndication`, `csv`, `opml`, `sitemap` |
| processor | `Feeds\Processor` | `@FeedsProcessor` | `Processor/ProcessorInterface` | `entity:node`, generic `entity:*` |
| target | `Feeds\Target` | `@FeedsTarget` | `Target/TargetInterface` | ~25 field targets (Text, Link, Image, DateTime, EntityReference, …) |
| source | `Feeds\Source` | `@FeedsSource` | `Source/SourceInterface` | `BasicFieldSource` |
| custom_source | `Feeds\CustomSource` | `@FeedsCustomSource` | — | `blank`, `csv` |

A feed type uses exactly one fetcher + one parser + one processor; targets are chosen per mapping row.

## Add a target plugin (most common extension)

```php
namespace Drupal\mymodule\Feeds\Target;

use Drupal\feeds\FieldTargetDefinition;
use Drupal\feeds\Feeds\Target\FieldTargetBase;

/**
 * @FeedsTarget(
 *   id = "my_target",
 *   field_types = {"string"}
 * )
 */
class MyTarget extends FieldTargetBase {
  protected function prepareValue($delta, array &$values) {
    $values['value'] = trim($values['value']);
  }
}
```

- Extend `FieldTargetBase` to map into a Drupal field; implement `TargetInterface` directly for
  non-field targets. `field_types` restricts which fields the target offers itself to.
- Implement `ConfigurableTargetInterface` for per-mapping settings, `TranslatableTargetInterface`
  for language handling. See `src/Feeds/Target/*` for worked examples.
- For fetchers/parsers/processors, subclass the matching base (`Fetcher/FetcherBase`,
  `ParserBase`, `ProcessorBase`/`EntityProcessorBase`) and add the annotation. Run `drush cr`
  after adding any plugin so the manager rediscovers it.
