# Code generator — `jsonrpc:method`

The module ships a Drupal Code Generator generator (not a runtime Drush command), registered by
`src/Drush/Generators/JsonRpcMethodGenerator.php` with template `src/Drush/Generators/method.twig`.

```bash
ddev drush generate jsonrpc:method
```

Prompts (`generate()`):
- module machine name
- component name
- class name
- JSON-RPC id (used as the callable method name at the endpoint)
- description (the `usage`)
- access permission (defaults to `administer site configuration`)

Writes `src/Plugin/jsonrpc/Method/{class}.php` from `method.twig`. The generated class extends
`JsonRpcMethodBase` with a `#[JsonRpcMethod]` attribute pre-filled from your answers — note it defaults the
`access` to a real permission, which is the safe default (do not remove it; see the plugins/security docs on the
empty-access footgun). There is no other Drush command; runtime invocation is over the HTTP endpoint.
