# Service override

The module replaces core's active-trail service rather than adding new API.

`MenuTrailByPathServiceProvider::alter()` (a `ServiceProviderBase`) swaps the class of the
`menu.active_trail` service to `Drupal\menu_trail_by_path\MenuTrailByPathActiveTrail` and
injects extra collaborators via method calls:

```php
$definition = $container->getDefinition('menu.active_trail');
$definition->setClass(MenuTrailByPathActiveTrail::class);
$definition->addMethodCall('setPathValidator',   [new Reference('path.validator')]);
$definition->addMethodCall('setRequestContext',  [new Reference('router.request_context')]);
$definition->addMethodCall('setLanguageManager', [new Reference('language_manager')]);
$definition->addMethodCall('setConfigFactory',   [new Reference('config.factory')]);
```

`MenuTrailByPathActiveTrail` extends the core active-trail class and, when `trail_source` is
`path`, computes the active link by matching successive path prefixes of the current URL
against existing menu links (bounded by `max_path_parts`). A `ProxyClass` is provided for lazy
service instantiation. Because it decorates the core service, any code calling
`\Drupal::service('menu.active_trail')` transparently gets the path-based behavior — you do not
call this module directly.
