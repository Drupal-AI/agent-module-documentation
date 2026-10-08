# Hooks

Declared in `imageapi_optimize.api.php`.

## `hook_imageapi_optimize_processor_info_alter(array &$processors)`
Alter the discovered `ImageAPIOptimizeProcessor` plugin definitions (keyed by machine
name) — e.g. change a label/description, or remove a processor.

```php
function mymodule_imageapi_optimize_processor_info_alter(array &$processors): void {
  if (isset($processors['resmushit'])) {
    $processors['resmushit']['description'] = t('Remote reSmush.it optimizer.');
  }
}
```

(The stub in `imageapi_optimize.api.php` is documented as
`imageapi_optimize_processor_info`; the effective alter hook name invoked by the plugin
manager is `hook_imageapi_optimize_processor_info_alter()`, per the annotation's
`@see`.)
