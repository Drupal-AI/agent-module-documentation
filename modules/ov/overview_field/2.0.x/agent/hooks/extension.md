# Extension hooks — populate the select and render the choice

The whole module does nothing until a module implements **both** alter hooks. They are documented in
`overview_field.api.php` and invoked from the widget and formatter respectively (see
[../fields/field-type.md](../fields/field-type.md)).

## 1. `hook_overview_field_options_alter(array &$options)`

Adds entries to the widget's `select`. Keys become the stored value; labels are shown to the editor.
Invoked by the widget as `alter('overview_field_options', $options)`.

```php
/**
 * Implements hook_overview_field_options_alter().
 */
function MYMODULE_overview_field_options_alter(array &$options) {
  $options['recent_content'] = t('Show a list of the recent content on the site');
  $options['example_block']  = t('Loads a block');
}
```

## 2. `hook_overview_field_output_alter($key, array &$output)`

Given the stored key, build the render array. Invoked by the formatter as
`alter('overview_field_output', $value['value'], $output)`. `$key` is the first (non-reference)
argument; `$output` is built by reference.

```php
/**
 * Implements hook_overview_field_output_alter().
 */
function MYMODULE_overview_field_output_alter($key, array &$output) {
  if ($key == 'recent_content') {
    // Render a Views display with the module's helper.
    $output = overview_field_load_view('content_recent', 'block_1');
  }
  if ($key == 'example_block') {
    $block_manager = \Drupal::service('plugin.manager.block');
    $plugin_block  = $block_manager->createInstance('block_name', []);
    $output = $plugin_block->build();
  }
}
```

Any key you register in the options hook but do not handle in the output hook simply renders nothing
(empty array). Return a normal render array — Views output, a block build, a themed list, custom
markup, etc.

## Helper: `overview_field_load_view($view, $display)`

Defined in `overview_field.module:41`. Convenience wrapper that returns a renderable Views display:

```php
$view = Views::getView($view);            // machine name of the view
$view->setDisplay($display);              // e.g. 'block_1'
$view->preExecute();
$view->execute();
$content = $view->buildRenderable($display);
$view->postExecute();
return $content;                          // [] if the view does not exist
```

It requires the core `views` module at runtime (the `use Drupal\views\Views;` is only exercised when
this function runs). Guard your call, or depend on `views`, if you use it.

## The bundled example — `overview_field_example` submodule

`modules/overview_field_example/` is the canonical reference implementation (enable it to see the
field do something). It implements exactly the two hooks:

```php
function overview_field_example_overview_field_options_alter(&$options) {
  $options['recent_content'] = t('Show a list of the recent content on the site');
}
function overview_field_example_overview_field_output_alter($key, &$output) {
  if ($key == 'recent_content') {
    $output = overview_field_load_view('content_recent', 'block_1');
  }
}
```

Info: `name: Overview Field Example`, `package: Field types`,
dependencies `drupal:field` + `overview_field:overview_field`, same version `2.0.2`. It ships no
plugins, routes, services, or config — copy it as the starting point for your own implementer
module. (It is not documented under its own doc directory; this is the full account of it.)
