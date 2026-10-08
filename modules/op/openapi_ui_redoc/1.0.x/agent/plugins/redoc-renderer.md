<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `redoc` openapi_ui plugin

`src/Plugin/openapi_ui/OpenApiUi/ReDoc.php` — the module's only PHP class.
Annotation-based (**not** an attribute): `@OpenApiUi(id = "redoc", label = @Translation("ReDoc"))`,
discovery dir `src/Plugin/openapi_ui/OpenApiUi/`, manager `plugin.manager.openapi_ui.ui`,
alter hook `hook_openapi_ui_alter(&$definitions)`. Extends
`Drupal\openapi_ui\Plugin\openapi_ui\OpenApiUi`; the only method is `build()`.

## What `build()` returns

`build()` receives the whole `openapi_ui` render element (already normalised by
`Drupal\openapi_ui\Element\OpenApiUi::preRenderOpenApiUi()`), reads `#openapi_schema` and
returns:

```php
[
  '#type' => 'html_tag',
  '#tag'  => 'redoc',
  '#attributes' => ['id' => 'redoc-ui', 'no-auto-auth' => TRUE /* + spec-url | spec */],
  '#attached' => ['library' => ['openapi_ui_redoc/redoc' /* + redoc_attr */]],
]
```

→ `<redoc id="redoc-ui" no-auto-auth spec-url="…"></redoc>`

## The two branches — the only real logic in the module

| `#openapi_schema` is | attribute | extra library | who initialises ReDoc |
|---|---|---|---|
| `Drupal\Core\Url` | `spec-url` = `$schema->toString()` | — | `redoc.min.js` auto-inits from `spec-url` |
| an **array** | `spec` = `Json::encode($schema)` | `openapi_ui_redoc/redoc_attr` | `js/redoc.js` runs `Redoc.init(JSON.parse(spec))` on document ready |

Strings, callables and file entities never reach `build()`: `preRenderOpenApiUi()` converts a
string via `Url::fromUri()`, executes a callable, and errors with *"Invalid schema source
provided."* for anything not finally an array or a `Url`. The shim exists because ReDoc only
self-initialises when `spec-url` is present; otherwise the console logs *"Redoc spec not
provided. UI not loaded."*

## Inspecting live

```bash
drush php:eval '
  foreach (\Drupal::service("plugin.manager.openapi_ui.ui")->getDefinitions() as $id => $d) {
    print $id . " | " . $d["label"] . " | " . $d["class"] . "\n";
  }
'
```

## Limits

- `id="redoc-ui"` is hardcoded → **one ReDoc instance per page** (`@TODO` in `js/redoc.js`).
- The plugin takes **no configuration** — ReDoc options such as `hide-download-button` would
  need a replacement class: `hook_openapi_ui_alter()` → `$definitions['redoc']['class'] = MyReDoc::class;`
- `no-auto-auth` is always set, suppressing ReDoc's auth prompt.
