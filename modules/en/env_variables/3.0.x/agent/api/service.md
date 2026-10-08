<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service: `env_variables` (`DotEnvServices`)

Defined in `env_variables.services.yml`:

```yaml
services:
  env_variables:
    class: '\Drupal\env_variables\Services\DotEnvServices'
    arguments: ['@request_stack', '@logger.factory']
```

Class: `src/Services/DotEnvServices.php`.

## Constructor

`__construct(RequestStack $request, LoggerChannelFactoryInterface $logger_factory)` — stores the
request stack and resolves a logger channel named `env_variables`.

## `loadEnvFile($path = null)`

The only public method. It:

1. reads `DOCUMENT_ROOT` from the current request's server bag
   (`$this->request->getCurrentRequest()->server->get('DOCUMENT_ROOT')`);
2. concatenates `DOCUMENT_ROOT . $path` to get the directory to scan;
3. calls `Dotenv::createMutable($dir)->load()` — the **mutable** phpdotenv loader, which writes the
   parsed `.env` entries into the process environment (`$_ENV`, `$_SERVER`, and `putenv()`);
4. on any `\Exception` (e.g. missing/invalid `.env`), logs `$e->getMessage()` to the `env_variables`
   logger channel and returns without throwing.

It returns nothing; callers read values afterward via `$_ENV` / `getenv()`.

## Using it from a custom module

Inject the `env_variables` service and call `loadEnvFile()` with a path relative to the docroot:

```php
public function __construct(\Drupal\env_variables\Services\DotEnvServices $envVars) {
  $this->envVars = $envVars;
}
// ...
$this->envVars->loadEnvFile('/../');       // load <project-root>/.env
$value = getenv('MY_SETTING');             // now available
```

Notes:
- `createMutable()` will overwrite existing environment values with those from the file.
- `$path` is expected to begin with `/` because it is concatenated directly onto `DOCUMENT_ROOT`.
- The method points phpdotenv at a *directory*; the file must be named `.env` in that directory
  (phpdotenv's default filename).
