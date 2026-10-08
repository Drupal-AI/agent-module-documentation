# `fac_search` search plugins

Plugin type that produces the suggestion list for a `fac_config`. Manager
`\Drupal\fac\SearchPluginManager` (service `plugin.manager.search_plugin`), discovery dir
`src/Plugin/Search`, interface `\Drupal\fac\SearchInterface`, annotation
`\Drupal\fac\Annotation\Search`, alter hook `fac_search_plugin_info`, cache key `fac_search_info_plugins`.

Built-ins: `BasicTitleSearch` (node title `LIKE`), `SearchApiSearch` (Search API index).

## Implement one
Create `src/Plugin/Search/MySearch.php` in your module, extend `\Drupal\fac\SearchBase`
(implements `SearchInterface`). Implement `ContainerFactoryPluginInterface` if you need services.

```php
use Drupal\Core\Form\FormStateInterface;
use Drupal\fac\FacConfigInterface;
use Drupal\fac\SearchBase;

/**
 * @Search(
 *   id = "MySearch",
 *   name = @Translation("My search plugin"),
 * )
 */
class MySearch extends SearchBase {

  // Optional per-config sub-form; values are stored in searchPluginConfig (JSON).
  public function getConfigForm(array $plugin_config, FormStateInterface $form_state) {
    return ['limit' => ['#type' => 'number', '#default_value' => $plugin_config['limit'] ?? 10]];
  }

  // Return an array of ['entity_type' => ..., 'entity_id' => ...] matches.
  public function getResults(FacConfigInterface $fac_config, $langcode, $key) {
    // $key is the typed string (underscores already converted to spaces).
    // Respect access — SearchService renders each result in the configured
    // view mode, but access filtering is the plugin's responsibility.
    return [];
  }
}
```

Notes:
- `getResults()` returns only `entity_type` + `entity_id`; `\Drupal\fac\SearchService::renderResults()`
  loads each entity and renders it with the config's `viewModes[<entity_type>]` view mode.
- The query runs inside `FacController::generateJson`, as the anonymous user when the config's
  `anonymousSearch` is on — do your own access tagging (e.g. `node_access`) as `BasicTitleSearch` does.
- Retrieve saved sub-form values with `$fac_config->getSearchPluginConfig()` (decoded array).
- Your plugin id is what appears in the config form's "Search plugin" select.
