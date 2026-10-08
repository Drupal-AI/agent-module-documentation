<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Attaching the jDrupal SDK library

`jdrupal.libraries.yml` defines one asset library:

```yaml
jdrupal:
  version: 8.0.0
  js:
    js/jdrupal.min.js: {}
```

Full library name: **`jdrupal/jdrupal`** → serves `modules/contrib/jdrupal/js/jdrupal.min.js`
(verified via `library.discovery`). It declares **no dependencies** (not even `core/drupal`);
the SDK is standalone vanilla JS exposing the global `jDrupal`.

The module does **not** attach the library anywhere itself — nothing loads unless you attach it.
Use this only for a **progressively-decoupled** widget served by Drupal; a fully separate SPA
just bundles/loads `jdrupal.min.js` directly and never touches Drupal's library system.

Ways to attach on a Drupal-served page:

- Theme/module `.info.yml`:
  ```yaml
  libraries:
    - jdrupal/jdrupal
  ```
- Render array:
  ```php
  $build['#attached']['library'][] = 'jdrupal/jdrupal';
  ```
- Twig template:
  ```twig
  {{ attach_library('jdrupal/jdrupal') }}
  ```

After it loads, initialize before making calls:

```js
jDrupal.config('sitePath', window.location.origin);
jDrupal.connect().then(user => { /* ... */ });
```

For same-origin Drupal-served pages `sitePath` is the current origin; for a cross-origin front
end, set it to the Drupal base URL and configure CORS on the Drupal side. See
[../api/sdk.md](../api/sdk.md) for the API and [../api/connect-resource.md](../api/connect-resource.md)
for the server setup.
