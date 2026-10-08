# Services, routes & custom solution providers (API)

## Services (`ignition.services.yml`)

| Service id | Class | Notes |
|---|---|---|
| `ignition.subscriber` | `EventSubscriber\ErrorHandlerSubscriber` | `event_subscriber`; listens `KernelEvents::EXCEPTION` at priority `-255`. Args: `current_user`, `config.factory`, `ignition.ignition`. |
| `ignition.solution_provider.collector` | `SolutionProviderCollector` | `service_collector` on tag `ignition_solution_provider`, method `addSolutionProvider`. Arg: `language.default`. |
| `ignition.ignition_factory` | `IgnitionFactory` | Builds the configured Ignition instance. Args: `config.factory`, `current_user`, `user.data`, `session`, the collector, `ignition.file_config_manager`. |
| `ignition.ignition` | `Spatie\Ignition\Ignition` | Created via `factory: ['@ignition.ignition_factory', 'make']`. |
| `ignition.file_config_manager` | `Spatie\Ignition\Config\FileConfigManager` | Reads/writes `~/.ignition.json`. |
| `ignition.cache.open_ai_solution` | `Cache\SimpleCacheBridge` | PSR-16 bridge over the Drupal cache bin `open_ai_solution`. |
| `cache.open_ai_solution` | (cache bin) | `cache.bin` tagged backend `open_ai_solution`. |
| `ignition.open_ai.solution_provider` | `SolutionProvider\OpenAISolutionProvider` | tag `ignition_solution_provider`, priority `-1`. Args: `config.factory`, `ignition.cache.open_ai_solution`. |
| `ignition.mysql_read_committed.solution_provider` | `SolutionProvider\MysqlReadCommittedSolutionProvider` | tag `ignition_solution_provider`. |
| `ignition.permissions_must_exist.solution_provider` | `SolutionProvider\PermissionsMustExistSolutionProvider` | tag `ignition_solution_provider`. |
| `ignition.entity_query_access_check.solution_provider` | `SolutionProvider\EntityQueryAccessCheckSolutionProvider` | tag `ignition_solution_provider`. |

## How the instance is assembled — `IgnitionFactory::make()`

```php
// src/IgnitionFactory.php
$ignitionConfig = (new IgnitionConfig($this->getDefaultConfig()))->merge($this->getUserConfig());
$providers = $this->solutionProviderCollector->getSolutionProviders();
return Ignition::make()
  ->applicationPath(DRUPAL_ROOT)
  ->setConfig($ignitionConfig)
  ->addSolutionProviders($providers);
```

- `getDefaultConfig()` → `['theme' => dark_mode ? 'dark' : 'auto']` from `ignition.settings`.
- `getUserConfig()` → if `store_settings_file`: `FileConfigManager::load()` (`~/.ignition.json`);
  elseif authenticated: `user.data` get(module `ignition`, name `config`); else session key
  `ignition_config`.

## Routes & controllers

| Route | Path | Method | Access | Handler |
|---|---|---|---|---|
| `ignition.settings` | `/admin/config/development/ignition` | GET/POST | `administer site configuration` | `Form\IgnitionSettingsForm` |
| `ignition.update_config` | `/_ignition/update-config` | POST (`_format: json`) | `view ignition error page` | `Controller\UpdateConfigController` |

`UpdateConfigController::__invoke(Request)` `json_decode`s the request body and persists it: to
`~/.ignition.json` (when `store_settings_file`), else to `user.data` for an authenticated user, else
to the session. Returns `JsonResponse(TRUE)`. This is the write side of the cog-menu preferences read
back by `IgnitionFactory::getUserConfig()`.

## Registering a custom solution provider

Solution providers are **tagged services**, not a Drupal plugin type. To recognise your own exception
and suggest a fix, implement `Spatie\Ignition\Contracts\HasSolutionsForThrowable` and tag the service.

```php
// src/SolutionProvider/MySolutionProvider.php
namespace Drupal\my_module\SolutionProvider;

use Spatie\Ignition\Contracts\BaseSolution;
use Spatie\Ignition\Contracts\HasSolutionsForThrowable;

class MySolutionProvider implements HasSolutionsForThrowable {
  public function canSolve(\Throwable $throwable): bool {
    return str_contains($throwable->getMessage(), 'my error signature');
  }
  public function getSolutions(\Throwable $throwable): array {
    return [
      BaseSolution::create('Do the thing')
        ->setSolutionDescription('Explanation of the fix.')
        ->setDocumentationLinks(['Docs' => 'https://example.com']),
    ];
  }
}
```

```yaml
# my_module.services.yml
services:
  my_module.my_solution_provider:
    class: Drupal\my_module\SolutionProvider\MySolutionProvider
    tags:
      - { name: ignition_solution_provider }
```

`SolutionProviderCollector::addSolutionProvider()` collects every tagged service and
`IgnitionFactory::make()` passes them to Ignition. The bundled providers are worth reading as
templates: `MysqlReadCommittedSolutionProvider` (matches a `DatabaseExceptionWrapper` deadlock),
`PermissionsMustExistSolutionProvider` (matches a `\RuntimeException` about non-existent role
permissions), `EntityQueryAccessCheckSolutionProvider` (matches a `QueryException` for a missing
`accessCheck()`), and `OpenAISolutionProvider` (defers to a model when `open_ai` config is enabled).
