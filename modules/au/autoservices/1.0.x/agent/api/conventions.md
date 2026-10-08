# Registering services by convention (API)

All behaviour lives in one class, `Drupal\autoservices\AutoservicesServiceProvider`
(`src/AutoservicesServiceProvider.php`). It is a `ServiceProviderBase` discovered automatically
because its name matches `<Module>ServiceProvider`; there is no `autoservices.services.yml`. Its
`register()` method runs during the **container compile pass**, so any change here requires a
**cache rebuild** (`drush cr`) to take effect — nothing happens per request.

## The three convention directories

`register()` (`:19`) iterates every installed module (the `container.modules` parameter) and, for
each, checks three sub-directories of that module's own `src/`. Definitions map
(`AutoservicesServiceProvider.php:22-37`):

| Put a class in… | Definition kind | Autowired | Tag | Public |
|---|---|---|---|---|
| `src/Autoservice/` | `new Definition($class)` | **yes** | — | yes |
| `src/AutoPluginManager/` | `new ChildDefinition('default_plugin_manager')` | **no** | — | yes |
| `src/AutoEventSubscriber/` | `new Definition($class)` | **yes** | `event_subscriber` | yes |

Mechanics (`:39-58`): for each namespace it builds `$path = dirname(<module>.pathname)/src/<Ns>`,
and only if that directory exists runs Symfony `Finder` over `*.php` files (`:42-44`). The service
id is the **fully qualified class name**:

```
$class = 'Drupal\' . $moduleName . '\' . $namespace . '\' . <FileName without .php>;   // :45
```

- **Idempotent / non-overriding:** if `$container->hasDefinition($class)` is already true, the file
  is skipped (`:46-48`) — an explicit `*.services.yml` definition, or a prior pass, always wins.
- **Every definition is made public** (`setPublic(TRUE)`, `:56`), so ids are fetchable via
  `\Drupal::service()` and `$container->get()`.
- **Finder recurses**, but the id is built as if the directory were flat (`:45` ignores any
  sub-folder in the path). Keep classes directly inside the convention directory; a nested file
  would be registered under a class name that does not match its real namespace.

### Example

```php
// modules/custom/mymod/src/Autoservice/Greeter.php
namespace Drupal\mymod\Autoservice;
class Greeter {
  public function __construct(
    private readonly \Drupal\Core\Session\AccountProxyInterface $currentUser,
  ) {}
}
```

After `drush cr`, the service exists as `Drupal\mymod\Autoservice\Greeter`, autowired — the
constructor's interface type-hints are resolved from the container with no argument list written
anywhere. Fetch it with `\Drupal::service('Drupal\mymod\Autoservice\Greeter')`.

- `AutoPluginManager/` classes should extend `DefaultPluginManager`; they inherit the
  `default_plugin_manager` parent's arguments (module handler, cache backend, etc.) and are **not**
  autowired, matching how plugin managers are normally defined.
- `AutoEventSubscriber/` classes must implement `EventSubscriberInterface`; the module adds the
  `event_subscriber` tag for you and autowires the constructor.

## The interface-alias set

Autowiring resolves a constructor argument type-hinted on an **interface** only if the container has
an alias from that interface to a concrete service. Drupal publishes no such mapping, so
`aliasInterfaces()` (`:67`) builds one on every compile:

```
foreach ($container->getDefinitions() as $id => $definition) {
  if (
    strtolower($id[0]) === $id[0] &&                                   // id starts lowercase  :69,72
    interface_exists($definition->getClass() . 'Interface') &&        // <Class>Interface exists  :73
    !$container->hasAlias($definition->getClass() . 'Interface')      // not already aliased
  ) {
    $container->setAlias($definition->getClass() . 'Interface', $id); // Interface -> service id  :76
  }
}
```

- Only definitions whose **service id begins with a lowercase letter** qualify — i.e. conventional
  ids like `entity_type.manager`. FQCN ids (`Drupal\…`, uppercase initial) are excluded, so the
  services this module itself registers are not used as alias targets.
- The interface must be the service class name **+ `Interface`** in the **same namespace** (e.g.
  class `Drupal\x\Foo` → interface `Drupal\x\FooInterface`). Interfaces that do not follow this
  naming pattern are not aliased and will not autowire.
- The **first** matching definition wins per interface (`hasAlias` guard); a later service sharing
  the same class/interface does not overwrite an existing alias.

This is the part to inspect when a type-hint fails to autowire: confirm a `<Class>Interface` exists,
that the backing service id is lowercase-initial, and that no conflicting alias was registered first.

## What it does NOT provide

No routes, controllers, forms, permissions, config/config-schema, plugin types, hooks, drush
commands, libraries, or a `configure` route. It is purely a compile-time registration helper for
other modules' code.
