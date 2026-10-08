<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Render element, param converter & alter hook

How to *consume* the framework once a renderer plugin (swagger/redoc/your own) is available.

## The `openapi_ui` render element

`Drupal\openapi_ui\Element\OpenApiUi` registers `#type => 'openapi_ui'`. Two properties:

| Property | Meaning |
|---|---|
| `#openapi_ui_plugin` | A renderer: either a plugin **id string** (resolved via `plugin.manager.openapi_ui.ui`) or an already-instantiated `OpenApiUiInterface` object. |
| `#openapi_schema` | The spec. Accepts: an **array** (OpenAPI as PHP, JSON-encoded at render), a **URL/URI string** (→ `Url::fromUri`), a `Drupal\Core\Url`, a Drupal **file entity** (access-checked, resolved to a private URL), or a **callback** `fn(array $element)` returning an array or URL. |

```php
$build['docs'] = [
  '#type' => 'openapi_ui',
  '#openapi_ui_plugin' => 'swagger',                 // a plugin id, or a plugin instance
  '#openapi_schema' => 'internal:/openapi/rest',     // string | array | Url | file | callback
];
```

### Pre-render pipeline (`preRenderOpenApiUi`)

1. If `#openapi_ui_plugin` is a non-empty **string**, it is instantiated via the manager.
2. If it is not an `OpenApiUiInterface`, an error message is set and rendering stops.
3. If `#openapi_schema` is **callable**, it is called with the element and replaced by the result.
4. If it is a **string**, it becomes `Url::fromUri($string)`.
5. If it is neither an array nor a `Url` after that, an error is set and rendering stops.
6. `#tree` is set TRUE and `$element['ui'] = $plugin->build($element)` — the plugin produces the markup.

So the element is only a wrapper: it normalises inputs, then delegates to the plugin.

## Route param converter (`openapi_ui.parm_parser`)

`OpenApiUiParamConverter` converts a route slug into a renderer **plugin instance**. It `applies`
when a route parameter's `type` is `openapi_ui`; `convert()` calls
`$manager->createInstance($value)` and returns the plugin (or `NULL` if the id is unknown).

```yaml
# your_module.routing.yml
your_module.apidoc:
  path: '/apidoc/{ui}'
  defaults:
    _controller: '\Drupal\your_module\Controller\ApiDocController::view'
  options:
    parameters:
      ui:
        type: openapi_ui        # {ui} arrives as an OpenApiUiInterface instance
  requirements:
    _permission: 'access content'
```

Your controller then passes the injected `$ui` straight into `#openapi_ui_plugin`.

## Altering plugin definitions

`hook_openapi_ui_alter(array &$definitions)` (invoked via the manager's `alterInfo('openapi_ui')`)
lets a module change or unset another module's renderer definitions before they are used.

## Programmatic checks

```php
// Is a given renderer available on this site?
\Drupal::service('plugin.manager.openapi_ui.ui')->hasDefinition('swagger');
// Instantiate one directly.
$plugin = \Drupal::service('plugin.manager.openapi_ui.ui')->createInstance('redoc');
```
