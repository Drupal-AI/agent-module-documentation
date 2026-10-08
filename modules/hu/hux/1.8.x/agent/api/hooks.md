# Hux — implementing hooks with attributes

All attributes are in `Drupal\hux\Attribute`. Put hook classes in `Drupal\<module>\Hooks\`
(auto-discovered) or register them manually (see bottom). Methods keep the same signature as the
procedural hook.

## `#[Hook]` — a hook implementation
`src/Attribute/Hook.php`. Repeatable, targets methods.
```php
public function __construct(
  public string $hook,          // hook name WITHOUT the 'hook_' prefix, e.g. 'entity_access'
  public ?string $moduleName = NULL, // masquerade as another module; NULL = own module (from namespace)
  public int $priority = 0,     // larger runs first
);
```
```php
#[Hook('entity_access')]
public function access(EntityInterface $e, string $op, AccountInterface $a): AccessResultInterface { ... }

#[Hook('entity_access', priority: 100)]           // run earlier
#[Hook('entity_insert')]                           // same method, multiple hooks (stack attributes)
```
- Passing a name that starts with `hook_` fails an assertion. The `theme` hook is explicitly
  unsupported (throws).

## `#[Alter]` — an alter implementation
`src/Attribute/Alter.php`. Give the name WITHOUT `hook_` and WITHOUT the `_alter` suffix.
```php
#[Alter('user_format_name')]   // implements hook_user_format_name_alter()
public function alterName(string &$name, AccountInterface $account): void { $name .= ' altered!'; }
```
- `module_implements` alter is unsupported (throws).

## `#[ReplaceOriginalHook]` — override another module's procedural hook
`src/Attribute/ReplaceOriginalHook.php`. Instructs Hux to skip the original implementation.
```php
public function __construct(
  public string $hook,
  public string $moduleName,          // the module whose implementation you replace
  public bool $originalInvoker = FALSE, // DEPRECATED: use the #[OriginalInvoker] param instead
);
```
```php
#[ReplaceOriginalHook(hook: 'entity_access', moduleName: 'media')]
public function replace(EntityInterface $e, string $op, AccountInterface $a,
  #[OriginalInvoker] callable $original): AccessResultInterface {
  $originalResult = $original($e, $op, $a);   // call the original media_entity_access()
  return AccessResult::neutral();
}
```

## `#[OriginalInvoker]` — receive the original implementation
`src/Attribute/OriginalInvoker.php`. Tags a `callable` parameter on a `ReplaceOriginalHook` method;
Hux passes the original hook as that callable. Preferred over the deprecated `originalInvoker: true`.

## Registering a hook class
1. **Auto (default):** create `src/Hooks/MyModuleHooks.php` with namespace
   `Drupal\my_module\Hooks`. Constructor injection / autowiring is supported.
2. **Manual (class outside `Hooks/`):** add to your module's `*.services.yml`:
   ```yaml
   services:
     my_module.hooks:
       class: Drupal\my_module\MyModuleHooks
       tags:
         - { name: hooks }
   ```
Then clear cache once. Adding more attributed methods to an already-registered class needs no rebuild.

## Optimized mode
In a `services.yml`:
```yaml
parameters:
  hux:
    optimize: true   # default false; small production perf gain, less dev-friendly
```

## How it works (for debugging)
`hux.services.yml` decorates `module_handler` with `Drupal\hux\HuxModuleHandler` and collects all
services tagged `hooks` via a `service_id_collector`. `src/HuxDiscovery.php` scans classes for the
attributes; `src/HuxReplacementHook.php` handles replacements. Nothing is invoked for hooks you do
not attribute.
