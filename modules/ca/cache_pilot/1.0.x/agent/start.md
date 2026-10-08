<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache Pilot (cache_pilot) — agent index

Clears and inspects the PHP **APCu** and **Zend OPcache** caches that live inside the
**PHP-FPM** worker processes, by talking to FPM over a **FastCGI** socket and running a bundled
script (`cache-pilot.php`) inside the pool. Solves the "CLI can't reset FPM's opcode cache"
problem on deploys. No package. Core `^10.3 || ^11`, PHP `>=8.3`. License GPL-2.0-or-later.
Version 1.0.0-alpha3.

- **Composer dep:** `hollodotme/fast-cgi-client:^3.1` (not a Drupal module). No Drupal module deps.
- **Settings, DSN format, dashboard, Drush commands, services & internals** →
  [config/settings.md](config/settings.md)

## What it actually is

- One config object `cache_pilot.settings` with a single key `connection_dsn` (schema
  `config/schema/cache_pilot.schema.yml`, install default `''`).
- Settings form `Drupal\cache_pilot\Form\SettingsForm` (`ConfigFormBase`, form id
  `cache_pilot_settings`) at **`/admin/config/development/performance/cache-pilot`**. DSN field
  plus "Clear APCu cache" / "Clear Zend Opcache" submit buttons.
- Reports dashboard `Drupal\cache_pilot\Controller\DashboardController` (invokable) at
  **`/admin/reports/cache-pilot`** (default `cache_type=apcu`) and
  **`/admin/reports/cache-pilot/{cache_type}`** (`opcache`).
- One permission **`cache_pilot.administer`** (`restrict access: true`) guards **all** routes.
- Two console/Drush commands: **`cache-pilot:apcu:clear`** and **`cache-pilot:opcache:clear`**
  (`src/Command/`, registered in `drush.services.yml`).
- `hook_cache_flush()` in `cache_pilot.module` clears **APCu** on every Drupal cache rebuild.
- `hook_requirements()` (`cache_pilot.install`) reports FastCGI connection status on the status
  report.

## Provides (from source)

- **Services** (`cache_pilot.services.yml`, autowired): `Client\Client` (FastCGI client),
  `Connection\SocketConnectionBuilder`, `Cache\ApcuCache`, `Cache\OpcacheCache`, and a logger
  channel `logger.channel.cache_pilot`.
- **Contract:** `Contract\CacheInterface` with `clear(): bool`, `isEnabled(): bool`,
  `statistics(): array` — implemented by `ApcuCache` and `OpcacheCache`.
- **Enum** `Data\ClientCommand` — the wire commands: `echo`, `apcu-clear`, `apcu-status`,
  `apcu-statistic`, `opcache-clear`, `opcache-status`, `opcache-statistic`.
- **Theme hooks** `cache_pilot_apcu_statistics`, `cache_pilot_opcache_statistics`,
  `cache_pilot_fragmentation_bar` (templates in `templates/`, library `cache_pilot/fragmentation-bar`),
  preprocessed by `Hook\Theme\PreprocessCachePilotApcuStatistics` /
  `PreprocessCachePilotOpcacheStatistics`, with `Utils\StatisticsHelper` for number/rate formatting.
- **No** entities, fields, or plugin types.

## Mechanism (one paragraph)

`Client::sendCommand()` builds a `hollodotme\FastCGI` `PostRequest` for the module's own
`cache-pilot.php`, sets custom var `cache_pilot=1`, sends `command=<enum value>` to the socket
from `SocketConnectionBuilder::build()` (which parses the DSN via
`Connection\ConnectionConfig::fromDsn()` into a `NetworkSocket` or `UnixDomainSocket`).
`cache-pilot.php` runs *inside* the FPM pool, verifies `$_SERVER['cache_pilot']==='1'`, and
switches on the command to call `apcu_clear_cache()` / `opcache_reset()` / `apcu_cache_info()` /
`opcache_get_status()`, echoing `Ok` or JSON. `ApcuCache`/`OpcacheCache` treat body `=== 'Ok'`
as success. See [config/settings.md](config/settings.md).
