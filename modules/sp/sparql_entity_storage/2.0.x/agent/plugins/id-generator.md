<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins — `sparql_entity_id` id generator

SPARQL entity ids are IRIs. How a new entity's IRI is generated is a plugin.

- **Plugin type:** `sparql_entity_id`
- **Manager:** `plugin.manager.sparql_entity_id` (`SparqlEntityStorageEntityIdPluginManager`,
  implements `FallbackPluginManagerInterface`).
- **Discovery dir:** `src/Plugin/sparql_entity_storage/Id/`
- **Annotation:** `@SparqlEntityIdGenerator` (`src/Annotation/SparqlEntityIdGenerator.php`)
- **Interface / base:** `SparqlEntityStorageEntityIdPluginInterface` /
  `SparqlEntityStorageEntityIdPluginBase`
- **Alter hook:** `hook_sparql_entity_id_info_alter()` (via `alterInfo('sparql_entity_id_info')`)
- **Fallback plugin id:** `default` (`getFallbackPluginId()` returns `default`) —
  `DefaultSparqlEntityStorageEntityIdGenerator` is the shipped generator.

## Implement one
```php
namespace Drupal\my_module\Plugin\sparql_entity_storage\Id;

use Drupal\sparql_entity_storage\SparqlEntityStorageEntityIdPluginBase;

/**
 * @SparqlEntityIdGenerator(
 *   id = "my_uuid_iri",
 *   name = @Translation("UUID-based IRI generator"),
 * )
 */
class MyUuidIriGenerator extends SparqlEntityStorageEntityIdPluginBase {

  public function generate() {
    // Return the new IRI string for $this->getEntity().
    return 'http://example.com/id/' . \Drupal::service('uuid')->generate();
  }

}
```
Place under `src/Plugin/sparql_entity_storage/Id/`, clear cache. Which generator a bundle uses is resolved
through its `sparql_mapping`; the manager returns the `default` generator when none is specified.
