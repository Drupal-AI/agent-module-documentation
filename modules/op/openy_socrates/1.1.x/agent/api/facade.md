# The `socrates` facade service (API)

`Drupal\openy_socrates\OpenySocratesFacade` — service id **`socrates`**, single constructor arg
`@state`. It has almost no methods of its own; it is a router that forwards method calls to whichever
tagged data service registered that method name at the highest priority.

## Calling it

```php
/** @var \Drupal\openy_socrates\OpenySocratesFacade $socrates */
$socrates = \Drupal::service('socrates');

// Resolves to the highest-priority openy_data_service that declared this method:
$result = $socrates->testDummyMethodAddToSocrates();   // ['dummy data'] from the demo provider
$lat    = $socrates->getLocationLatitude($args);       // provided by some Open Y module, if present
```

Prefer constructor injection of the `socrates` service in real code. In a class, depend on it rather
than on any concrete provider — that decoupling is the whole point of the module.

## `__call($name, array $arguments)` — the dispatch (`OpenySocratesFacade.php:62`)

```php
public function __call($name, array $arguments) {
  if (isset($this->services[$name])) {
    $calls_data = $this->services[$name];        // [priority => service]
    $reset_keys_data = array_values($calls_data);
    $service = array_shift($reset_keys_data);    // first = highest priority (krsort'd)
    return call_user_func_array([$service, $name], $arguments);
  }
  throw new OpenySocratesException(sprintf('Method %s not implemented yet.', $name));
}
```

- `$this->services` is a map `method_name => [priority => service_instance]`, kept in descending
  priority order (`krsort` in `collectDataServices()`). The call always goes to the top entry.
- An unregistered method name throws `Drupal\openy_socrates\OpenySocratesException`
  (`Method <name> not implemented yet.`). There is no `try` around dispatch inside the facade, so a
  caller that cannot guarantee a provider is installed should wrap the call itself.
- The two `@method getLocationLongtitude/getLocationLatitude` PHPDoc lines on the class are only IDE
  hints for methods that *other* Open Y modules are expected to provide through the facade; the class
  does not define them.

## How providers get injected — compiler pass

Wiring is done once, at container build, not at runtime:

- `OpenySocratesServiceProvider::register()` adds `new OpenySocratesCompilerPass()`.
- `OpenySocratesCompilerPass::process()` (`OpenySocratesCompilerPass.php:20`):
  - `findTaggedServiceIds('openy_data_service')` → for each, assert the class
    `class_implements(...)` contains `OpenyDataServiceInterface`, else throw
    `OpenySocratesException("Service <id> should implement OpenyDataServiceInterface")`. Reads the
    tag's `priority` (default `0`), builds `[0 => [priority => [Reference...]]]`, and
    `->addMethodCall('collectDataServices', ...)` on the `socrates` definition.
  - Same for `openy_cron_service` against `OpenyCronServiceInterface`, reading `periodicity`
    (default `0`), then `->addMethodCall('collectCronServices', ...)`.

So the class-implements-interface check is enforced at **cache-clear / container-rebuild time** — a
mis-tagged service fails the container build, not the first call.

## Setters (called by the compiler pass, not by you)

- `collectDataServices(array $services)` — receives `[priority => [service,...]]`; for each service it
  calls `$service->addDataServices([])` and maps every returned method name to that service under its
  priority, then `krsort`s so the highest priority wins. (Note: `addDataServices()` is invoked with a
  fresh empty array here, so its own `$services` argument is unused in practice.)
- `collectCronServices(array $services)` — receives `[periodicity => [service,...]]` and stores it on
  `$this->cronServices` for the runner. See [cron.md](cron.md).

## Exception

`Drupal\openy_socrates\OpenySocratesException extends \Exception` — thrown in two places: unknown
method on `__call`, and a tagged service missing the required interface during compilation. Catch it
by this class when calling optional providers.

## Helper trait — `OpenyRepositoryTrait`

`Drupal\openy_socrates\OpenyRepositoryTrait` is unrelated to the facade; it is a `use`-able helper for
entity repositories:

```php
use \Drupal\openy_socrates\OpenyRepositoryTrait;
// ...
$this->removeAllByChunks($storage, $ids, 50); // deletes via loadMultiple()+delete() in chunks
```

`removeAllByChunks(EntityStorageInterface $storage, array $ids, int $chunkSize = 10)` — `array_chunk`s
the ids (chunk `<= 0` falls back to `10`), loads and deletes each chunk; returns early on an empty
`$ids`. Use it to delete large id sets without exhausting memory.
