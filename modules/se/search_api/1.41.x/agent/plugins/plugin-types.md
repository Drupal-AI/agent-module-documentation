# Plugin types Search API defines

Declared in `search_api.plugin_type.yml`; each has a manager service in
`search_api.services.yml` and an attribute in `src/Attribute/` (legacy annotation in
`src/Annotation/`). Plugins live in `Plugin/search_api/<type>/` of any module.

| Type id | Manager service | Attribute / base | Purpose |
|---|---|---|---|
| `search_api_backend` | `plugin.manager.search_api.backend` | `SearchApiBackend` / `BackendPluginBase` | Where/how items are stored & queried (DB, Solr…). |
| `search_api_datasource` | `plugin.manager.search_api.datasource` | `SearchApiDatasource` / `DatasourcePluginBase` | Source of indexable items (e.g. `entity:node`). |
| `search_api_processor` | `plugin.manager.search_api.processor` | `SearchApiProcessor` / `ProcessorPluginBase` | Transform data/query at index & search time. |
| `search_api_tracker` | `plugin.manager.search_api.tracker` | `SearchApiTracker` / `TrackerPluginBase` | Queue of new/changed/deleted items to index. |
| `search_api_data_type` | `plugin.manager.search_api.data_type` | `SearchApiDataType` / `DataTypePluginBase` | Field data types (text, string, integer, custom). |
| `search_api_display` | `plugin.manager.search_api.display` | `SearchApiDisplay` / `DisplayPluginBase` | Represents a concrete search (Views page, block) for Facets/Autocomplete to attach to. |
| `search_api_parse_mode` | `plugin.manager.search_api.parse_mode` | `SearchApiParseMode` / `ParseModePluginBase` | How raw keyword strings are parsed (direct, terms, phrase). |

The **Index** (`search_api_index`) and **Server** (`search_api_server`) config entities
(`src/Entity/`) tie these together.

Implement one (processor example):
```php
namespace Drupal\mymodule\Plugin\search_api\processor;

use Drupal\search_api\Attribute\SearchApiProcessor;
use Drupal\search_api\Processor\ProcessorPluginBase;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[SearchApiProcessor(
  id: 'my_processor',
  label: new TranslatableMarkup('My processor'),
  description: new TranslatableMarkup('Cleans indexed values.'),
  stages: ['preprocess_index' => 0],
)]
class MyProcessor extends ProcessorPluginBase {
  public function preprocessIndexItems(array $items): void {
    // mutate $items before they hit the backend
  }
}
```
`drush cr`, then enable it on an index's **Processors** tab
([../configure/indexes-servers.md](../configure/indexes-servers.md)). Each `*_info_alter`
hook lets you tweak the discovered definitions — see [../hooks/hooks.md](../hooks/hooks.md).
