# Use the Styles API plugin manager

## Get the manager

```php
// Preferred:
$manager = \Drupal::service('plugin.manager.styles_api');
// Or the static accessor:
$manager = \Drupal\styles_api\Style::stylePluginManager();
```

Both return the `StylePluginManager` (`StylePluginManagerInterface`).

## List styles

```php
// All style definitions keyed by id:
$defs = $manager->getDefinitions();

// Options for a select element (id => label):
$options = $manager->getStyleOptions();

// Grouped by category (category => [id => label]):
$options = $manager->getStyleOptions(['group_by_category' => TRUE]);
```

`getStyleOptions()` is declared by `StylePluginManagerInterface`.

## Theme registration

Styles API registers templates for you: its `styles_api_theme()` implementation returns
`$manager->getThemeImplementations()`, which yields a `hook_theme()`-shaped array for every
style whose definition includes a `configuration.path` (i.e. those declaring a `template`). So a
style with a `template` becomes a themeable hook automatically — you just ship the Twig file.

```php
// Theme hooks contributed by styles with a template:
$hooks = $manager->getThemeImplementations();
```

## Instantiate a style

```php
$style = $manager->createInstance('my_callout'); // StyleInterface
$style->getLabel();
$style->getConfiguration();  // the definition's configuration (path/template/...)
$style->getIconFilename();
```

## Alter discovered styles

```php
/**
 * Implements hook_styles_alter().
 */
function my_module_styles_alter(array &$definitions) {
  // Add, remove, or tweak style definitions.
}
```

## Gotchas

- **Do not** use the deprecated statics `Style::getStyleOptions()` /
  `Style::getThemeImplementations()` — they call a mistyped `styleapiPluginManager()` accessor
  that does not exist and will fatal. Use the plugin manager service directly (above).
- `getStyleOptions()` groups only when you pass `['group_by_category' => TRUE]`.
