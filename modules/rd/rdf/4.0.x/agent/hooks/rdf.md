# RDF — hooks

Full signature in `rdf.api.php`. The module's own hook implementations live in
`#[Hook]` attribute classes under `src/Hook/` (`RdfHooks`, `RdfThemeHooks`,
`RdfPreprocessHooks`), autowired via `rdf.services.yml`.

## `hook_rdf_namespaces()`
Return an associative array of `prefix => namespace URI` so patterns can use CURIEs
(e.g. `sioc:Post`) that consumers can resolve. Implement it when your mappings use a
vocabulary not already in `RdfHooks::rdfNamespaces()`.

Procedural or OOP implementation both work. OOP form:

```php
use Drupal\Core\Hook\Attribute\Hook;

class MyModuleHooks {
  #[Hook('rdf_namespaces')]
  public function rdfNamespaces(): array {
    return [
      'dc'   => 'http://purl.org/dc/terms/',
      'myns' => 'http://example.com/ns#',
    ];
  }
}
```

Notes:
- Collected by `RdfMappingHelper::getNamespaces()` via `moduleHandler()->invokeAllWith()`.
- Defining the **same prefix** with a **different URI** than an existing implementation
  throws an exception — reuse the standard prefixes where possible.
- The module itself has no other public hooks; most of its behavior is delivered through
  core preprocess hooks it implements (see [../theming/rdf.md](../theming/rdf.md)).
