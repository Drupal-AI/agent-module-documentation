# Plugin type — `@ExternalDataSource` data sources

The module's one extension point: a data-source plugin supplies the option list for the field.

- **Manager:** `plugin.manager.external_data_source`
  (`Drupal\external_data_source\Plugin\ExternalDataSourceManager`), a `DefaultPluginManager`.
- **Directory:** `Plugin/ExternalDataSource/` in any module.
- **Annotation:** `@ExternalDataSource` (`id`, `name`, `description`).
- **Interface:** `ExternalDataSourceInterface` (extends `PluginInspectionInterface`) — requires
  `getResponse()`.
- **Base class:** `ExternalDataSourceBase` — provides `$request`, `getRequest()`,
  `sanitizeArray()`, and a `formatResponse()` helper. Alter hook: `hook_external_data_source_info_alter`.
  Cache tag `external_data_source_plugins`.

`getResponse()` must return an array of `['value' => …, 'label' => …]` rows. For the autocomplete
widget the plugin also needs a `setRequest(Request $request)` method so it can read the typed `q`.

## Minimal example

```php
namespace Drupal\my_module\Plugin\ExternalDataSource;

use Drupal\external_data_source\Plugin\ExternalDataSourceBase;
use Symfony\Component\HttpFoundation\Request;
use GuzzleHttp\Client;

/**
 * @ExternalDataSource(
 *   id = "my_catalogue",
 *   name = @Translation("Product catalogue"),
 *   description = @Translation("Options from the internal catalogue service.")
 * )
 */
class MyCatalogue extends ExternalDataSourceBase {

  public function setRequest(Request $request) {
    $this->request = $request;
  }

  public function getResponse() {
    $q = $this->request ? $this->request->get('q') : NULL;
    $client = new Client();
    $url = 'https://catalogue.internal/api/products' . ($q ? '?q=' . urlencode($q) : '');
    $data = json_decode($client->get($url)->getBody()->getContents());
    $options = [];
    foreach ($data as $row) {
      $options[] = ['value' => (string) $row->sku, 'label' => (string) $row->name];
    }
    return $options;
  }
}
```

Notes grounded in the shipped plugins (`Countries`, `FranceRegions`, `FranceZipCodes`):

- They construct a `GuzzleHttp\Client` directly (no injected `http_client`) and hardcode the
  endpoint host, appending `q` to the query. Catch `GuzzleException` and log rather than throw, so a
  down service degrades to an empty list. **Validate/encode `q`** before putting it in a URL.
- The select and checkboxes widgets instantiate your plugin with `new $class()` (no container),
  then call `optionsForSelect()` → `getResponse()`. Keep the constructor argument-free (as the base
  does) or the widgets will fatal.
- Return values are cast to strings and UTF-8-normalised downstream; the field stores the `value`.
- After adding a plugin, `drush cr` — it then appears in the field's `ws` storage-setting select.
