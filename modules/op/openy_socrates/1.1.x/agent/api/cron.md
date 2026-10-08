# Socrates cron runner (`openy_cron_service`)

Separate from data-service routing, Socrates offers a lightweight periodic-task mechanism: services
tagged `openy_cron_service` are run by `\Drupal::service('socrates')->cron()`, each on its own
interval, with last-run times kept in Drupal State. It is an alternative to `hook_cron` used across
Open Y; nothing here hooks into core cron automatically — you invoke `socrates->cron()` yourself.

## 1. Implement `OpenyCronServiceInterface`

`Drupal\openy_socrates\OpenyCronServiceInterface`:

```php
public function runCronServices();
```

Example (`ExampleSocratesCronService.php`):

```php
namespace Drupal\my_module;

use Drupal\openy_socrates\OpenyCronServiceInterface;

class MyCronService implements OpenyCronServiceInterface {
  public function runCronServices() {
    // ...the periodic work...
  }
}
```

## 2. Tag the service with a `periodicity`

```yaml
services:
  my_module.cron_service:
    class: Drupal\my_module\MyCronService
    tags:
      -
        name: openy_cron_service
        # Minimum seconds between runs (measured from the last run).
        periodicity: 60
```

`periodicity` (default `0`) is the minimum number of seconds since the last run before the task runs
again. The demo `example_socrates_cron_service` uses `86400` (daily) and logs
`"Example socrates cron service run succeeded."` to the `test` channel. As with data services, rebuild
the container (`drush cr`) after tagging; the class is checked against `OpenyCronServiceInterface` at
compile time.

## 3. Trigger the runner

Socrates does **not** register a `hook_cron`. Open Y runs it from the system crontab:

```
* * * * *   drush ev '\Drupal::service("socrates")->cron();'
```

## What `cron()` does (`OpenySocratesFacade.php:117`)

```php
public function cron() {
  $request_time = \Drupal::time()->getRequestTime();
  $prefix = 'openy_cron_';
  foreach ($this->cronServices as $periodicity => $services) {
    foreach ($services as $service) {
      $name = $prefix . $service->_serviceId;
      $last_run = $this->state->get($name);
      if (($request_time - $last_run) > $periodicity) {
        \Drupal::logger("openy_cron")->info('Service %service has been started.', [...]);
        Timer::start($name);
        $service->runCronServices();
        $execution_time = Timer::read($name) / 1000;
        $this->state->set($name, $request_time);
        \Drupal::logger("openy_cron")->info('Service %service has been finished. ...', [...]);
        Timer::stop($name);
      }
    }
  }
}
```

- Per service, State key **`openy_cron_<serviceId>`** stores the last-run request time. A run happens
  only when `now - last_run > periodicity`.
- Start/finish and execution time (seconds) are logged to the **`openy_cron`** logger channel.
- Timing uses `Drupal\Component\Utility\Timer`.

### Caveat — `_serviceId`

The runner reads `$service->_serviceId` to build the State key and the log message, but neither
`OpenyCronServiceInterface` nor the bundled `ExampleSocratesCronService` defines that property. A
provider is therefore expected to set a public `_serviceId` on itself; if it does not, the State key
collapses to `openy_cron_` for every such service (they would share one last-run stamp) and PHP 8.2+
emits a dynamic-property deprecation. Set `_serviceId` on your cron service class to a unique string.
Also note `cron()` uses the `\Drupal::` static (`time()`, `logger()`) rather than injected
dependencies — a `@todo` in the source acknowledges this.
