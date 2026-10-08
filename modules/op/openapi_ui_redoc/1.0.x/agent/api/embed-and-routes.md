<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reaching ReDoc, and embedding it yourself

## Out of the box (needs `openapi` + a generator module)

`openapi_ui_redoc` adds **no routes**. The pages come from `drupal/openapi`, all guarded by the
permission **`access openapi api docs`**:

| Route | Path |
|---|---|
| `openapi.downloads` | `/admin/config/services/openapi` — listing; gains an *Explore with ReDoc* link per generator once this module is enabled |
| `openapi.documentation` | `/admin/config/services/openapi/{openapi_ui}/{openapi_generator}` — `{openapi_ui}` = `redoc` |
| `openapi.download` | `/openapi/{openapi_generator}?_format=json` — raw spec JSON |

Generators ship separately: `openapi_jsonapi` → `jsonapi`, `openapi_rest` → `rest`. Canonical
URL: **`/admin/config/services/openapi/redoc/jsonapi`**.

```bash
drush php:eval '
  print "ui: "  . implode(",", array_keys(\Drupal::service("plugin.manager.openapi_ui.ui")->getDefinitions())) . "\n";
  print "gen: " . implode(",", array_keys(\Drupal::service("plugin.manager.openapi.generator")->getDefinitions())) . "\n";
'
drush role:list --format=json   # who holds "access openapi api docs"
```

## Embedding in your own page

```php
// mymodule/src/Controller/DocsController.php
use Drupal\Core\Controller\ControllerBase;
use Drupal\Core\Url;

class DocsController extends ControllerBase {

  // A) browser fetches the spec  -> <redoc spec-url="…">
  public function remote() {
    return [
      '#type' => 'openapi_ui',
      '#openapi_ui_plugin' => 'redoc',
      '#openapi_schema' => Url::fromUri('https://example.com/openapi.json'),
    ];
  }

  // B) spec built in PHP -> <redoc spec="{…}"> + the redoc_attr shim
  public function inline() {
    return [
      '#type' => 'openapi_ui',
      '#openapi_ui_plugin' => 'redoc',
      '#openapi_schema' => [
        'openapi' => '3.0.0',
        'info' => ['title' => 'My API', 'version' => '1.0.0'],
        'paths' => [],
      ],
    ];
  }

  // C) computed lazily; callback gets the element, returns array|Url
  public function lazy() {
    return [
      '#type' => 'openapi_ui',
      '#openapi_ui_plugin' => 'redoc',
      '#openapi_schema' => fn (array $element) => \Drupal::service('plugin.manager.openapi.generator')
        ->createInstance('jsonapi')->getSpecification(),
    ];
  }

}
```

```yaml
mymodule.docs:
  path: '/my-api/docs'
  defaults:
    _controller: '\Drupal\mymodule\Controller\DocsController::remote'
    _title: 'API documentation'
  requirements:
    _permission: 'access content'
```

Point at an internal spec route instead:

```php
'#openapi_schema' => Url::fromRoute('openapi.download', ['openapi_generator' => 'jsonapi'], ['query' => ['_format' => 'json']]),
```

ReDoc fetches that with the visitor's cookies, which matters because `/openapi/{generator}` is
permission-protected.

## Verifying a page really rendered ReDoc

```bash
drush php:eval '
  use Symfony\Component\HttpFoundation\Request;
  $res = \Drupal::service("http_kernel")->handle(Request::create("/my-api/docs"));
  $html = $res->getContent();
  print $res->getStatusCode() . " redoc=" . (int) str_contains($html, "<redoc")
    . " specurl=" . (int) str_contains($html, "spec-url=")
    . " lib=" . (int) str_contains($html, "redoc.min.js") . "\n";
'
```

**HTTP 500 with *"Only local files should be passed to _locale_parse_js_file()"*** is the known
library bug → [../theming/library-and-gotchas.md](../theming/library-and-gotchas.md).

Neither the plugin nor the element adds cache metadata, so when you inline a generated spec
(branch B) attach your own `#cache` tags/contexts or `'#cache' => ['max-age' => 0]`.
