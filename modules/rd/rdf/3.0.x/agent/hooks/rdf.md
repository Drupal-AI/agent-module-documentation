# RDF — hooks

Full signatures in `rdf.api.php`.

## `hook_rdf_namespaces()`
Return an associative array of `prefix => namespace URI` so patterns can use CURIEs
(e.g. `sioc:Post`) that consumers can resolve. Implement it when your mappings use a
vocabulary not already in `rdf_rdf_namespaces()`.

```php
function mymodule_rdf_namespaces() {
  return [
    'dc'   => 'http://purl.org/dc/terms/',
    'myns' => 'http://example.com/ns#',
  ];
}
```

Notes:
- Collected by `rdf_get_namespaces()` via `moduleHandler()->invokeAllWith()`.
- Defining the **same prefix** with a **different URI** than an existing implementation
  throws an exception — reuse the standard prefixes where possible.
- The module itself has no other public hooks; most of its behavior is delivered through
  core preprocess hooks it implements (see [../theming/rdf.md](../theming/rdf.md)).
