<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `openapi_ui` plugin type (renderers)

A renderer plugin teaches Drupal how to display an OpenAPI spec with one JavaScript library
(Swagger UI, ReDoc, or your own). This is the module's core extension point.

## Manager & discovery

- Manager service: `plugin.manager.openapi_ui.ui` (class `OpenApiUiManager extends DefaultPluginManager`).
- Discovery subdir: `Plugin/openapi_ui/OpenApiUi` — i.e. classes go in
  `your_module/src/Plugin/openapi_ui/OpenApiUi/`.
- Annotation: `@OpenApiUi(id = "...", label = @Translation("..."))` (only `id` + `label`).
- Interface: `Drupal\openapi_ui\Plugin\openapi_ui\OpenApiUiInterface` — one method: `build(array $render_element): array`.
- Base class: `Drupal\openapi_ui\Plugin\openapi_ui\OpenApiUi` (extends `PluginBase`, returns `[]` from `build()`).
- Cache: definitions cached under `openapi_ui_plugins`; run `drush cr` after adding a plugin.
- Definitions are alterable via `hook_openapi_ui_alter(&$definitions)`.

**Nothing is registered out of the box** — `plugin.manager.openapi_ui.ui`'s definition list is
empty until a module (swagger/redoc/yours) provides a plugin. Verify with:
`drush php:eval 'print_r(array_keys(\Drupal::service("plugin.manager.openapi_ui.ui")->getDefinitions()));'`

## Minimal plugin

`your_module/src/Plugin/openapi_ui/OpenApiUi/MyRenderer.php`:

```php
<?php
namespace Drupal\your_module\Plugin\openapi_ui\OpenApiUi;

use Drupal\openapi_ui\Plugin\openapi_ui\OpenApiUi;

/**
 * @OpenApiUi(
 *   id = "my_renderer",
 *   label = @Translation("My Renderer"),
 * )
 */
class MyRenderer extends OpenApiUi {

  /**
   * {@inheritdoc}
   */
  public function build(array $render_element) {
    // $render_element['#openapi_schema'] is already normalised to an array or a
    // Drupal\Core\Url by the render element's pre-render. Attach your JS library
    // and hand it the schema; return a render array (becomes the 'ui' child).
    $schema = $render_element['#openapi_schema'];
    $source = $schema instanceof \Drupal\Core\Url ? $schema->toString() : json_encode($schema);
    return [
      '#type' => 'container',
      '#attached' => ['library' => ['your_module/my_renderer']],
      '#attributes' => ['data-openapi-source' => $source, 'class' => ['my-renderer']],
    ];
  }

}
```

`build()` receives the whole render element (so it can read any extra `#…` properties your
renderer documents) and returns a render array. The render element assigns your return value
to `$element['ui']`, so keep it a normal renderable. Attach the actual Swagger/ReDoc JS via
`#attached['library']`. That is the entire contract — there is no config, form, or schema layer.

## How real implementations differ

`openapi_ui_swagger` and `openapi_ui_redoc` each ship one such plugin plus the bundled JS
library and a settings form of their own. They are the reference implementations; this module
only provides the type, the interface, and the base class shown above.
