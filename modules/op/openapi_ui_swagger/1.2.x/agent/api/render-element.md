<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering Swagger UI yourself

## The render element

`openapi_ui` provides the `openapi_ui` render element (`Drupal\openapi_ui\Element\OpenApiUi`).
Use it from any controller, block, form or preprocess:

```php
return [
  '#type' => 'openapi_ui',
  '#openapi_ui_plugin' => 'swagger',                       // this module's plugin id
  '#openapi_schema' => Url::fromUri('base:/openapi/jsonapi', ['absolute' => TRUE]),
];
```

`#openapi_schema` accepts any of:

| Value | Behaviour |
|---|---|
| `\Drupal\Core\Url` | emitted as `data-openapi-ui-url` — swagger-ui fetches it |
| string | converted with `Url::fromUri()` first |
| array | OpenAPI spec, JSON-encoded into `data-openapi-ui-spec` |
| `file` entity | converted to its private URL after an access check |
| callable | called with the element, must return one of the above |

`#openapi_ui_plugin` may be the plugin id string or an instance; the pre-render
(`OpenApiUi::preRenderOpenApiUi()`) resolves the string via `plugin.manager.openapi_ui.ui`,
sets `#tree = TRUE` and puts the plugin's output in `$element['ui']`. An unknown plugin id or
a non-array/non-Url schema produces a messenger error and renders nothing.

## What `SwaggerUi::build()` produces

```php
[
  '#type' => 'html_tag', '#tag' => 'div',
  '#attributes' => [
    'id' => 'swagger-ui',
    'class' => ['swagger-ui-wrap'],
    // exactly one of:
    'data-openapi-ui-url'  => (string) $url,
    'data-openapi-ui-spec' => Json::encode($schema_array),
  ],
  '#attached' => ['library' => ['openapi_ui_swagger/swagger_ui_integration']],
]
```

So a correct page always contains `id="swagger-ui"`, `class="swagger-ui-wrap"` and one of the
two `data-openapi-ui-*` attributes — that is the cheapest thing to assert in a test.

## The JS behavior (`js/swagger.js`)

`Drupal.behaviors.swaggerui` sets `window.$ = jQuery` (swagger-ui expects it), reads
`data-openapi-ui-url` / `data-openapi-ui-spec` off `#swagger-ui`, and calls:

```js
SwaggerUIBundle({
  dom_id: '#swagger-ui',
  presets: [SwaggerUIBundle.presets.apis, SwaggerUIStandalonePreset],
  plugins: [SwaggerUIBundle.plugins.DownloadUrl, SwaggerUIHideTopbarPlugin],
  layout: 'StandaloneLayout',
  url | spec: …
});
```

`SwaggerUIHideTopbarPlugin` replaces the `Topbar` component with `null`, so the spec-URL bar
is not shown. The instance is exposed globally as `window.ui`. Known limitation (a `@todo` in
the source): the dom id is hard-coded, so **only one Swagger UI per page**.

## Plugin definition

```php
/**
 * @OpenApiUi(
 *   id = "swagger",
 *   label = @Translation("Swagger UI"),
 * )
 */
class SwaggerUi extends \Drupal\openapi_ui\Plugin\openapi_ui\OpenApiUi
```

Annotation class `Drupal\openapi_ui\Annotation\OpenApiUi`, manager service
`plugin.manager.openapi_ui.ui`, discovery directory `src/Plugin/openapi_ui/OpenApiUi`, alter
hook `hook_openapi_ui_alter()`. To provide a different renderer, add your own class in that
directory with a new `id` — nothing needs to change in this module.

`templates/swagger-ui.html.twig` ships with the module but is legacy: `build()` returns an
`html_tag`, not a theme hook, so the template is not used by the current code path.
