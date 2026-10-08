# Registering a data service (`openy_data_service`)

To make a service's methods reachable through `\Drupal::service('socrates')->method()`, register it
as an Open Y data service. Two steps — implement the interface, tag the service.

## 1. Implement `OpenyDataServiceInterface`

`Drupal\openy_socrates\OpenyDataServiceInterface` has one method:

```php
public function addDataServices(array $services);
```

It must **return an array of the method names** this service exposes through the facade. Those method
names are exactly what the facade will accept in `__call`. Example
(`ExampleSocratesDataService.php`):

```php
namespace Drupal\my_module;

use Drupal\openy_socrates\OpenyDataServiceInterface;

class MyDataService implements OpenyDataServiceInterface {

  public function getLocationLatitude(array $args) {
    // ...real work...
    return $lat;
  }

  public function addDataServices(array $services) {
    // Every method you want callable via socrates must be listed here.
    return ['getLocationLatitude', 'getLocationLongtitude'];
  }

}
```

Each listed method name becomes a key the facade routes on; the actual method must exist on the class
with a matching signature (the facade forwards `$arguments` verbatim via `call_user_func_array`).

## 2. Tag the service in `my_module.services.yml`

```yaml
services:
  my_module.data_service:
    class: Drupal\my_module\MyDataService
    tags:
      - { name: openy_data_service, priority: 1000 }
```

- Tag name **`openy_data_service`** is required. `priority` (default `0`) decides who wins when more
  than one registered service exposes the **same method name**: the highest priority is called, the
  rest are ignored for that method. This is the Strategy-pattern selection Socrates exists for — a
  site or module can override a default provider simply by tagging a higher-priority one.
- Rebuild the container (`drush cr`) after adding/changing tags. The class is checked against
  `OpenyDataServiceInterface` at compile time; a mis-tagged class throws `OpenySocratesException`
  during the rebuild (see [facade.md](facade.md)).

## Calling the registered method

```php
$socrates = \Drupal::service('socrates');
$lat = $socrates->getLocationLatitude(['id' => 42]);   // highest-priority provider answers
```

An unknown / unprovided method throws `OpenySocratesException` (`Method <name> not implemented yet.`).
When calling a method that may have no provider on a given site, catch that exception so the site
degrades instead of fataling — the reason the module exists is to allow that graceful absence.

## Demo provider shipped with the module

`example_socrates_data_service` (`ExampleSocratesDataService`, tag priority `1000`) exposes
`testDummyMethodAddToSocrates()` → returns `['dummy data']`. It is always registered, so
`\Drupal::service('socrates')->testDummyMethodAddToSocrates()` works out of the box (runtime-verified
on 1.1.0). Use it only as a copy-paste template.
