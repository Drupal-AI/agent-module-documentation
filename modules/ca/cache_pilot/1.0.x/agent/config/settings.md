<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache Pilot — configuration, routes, commands & internals

Everything needed to configure, operate, and script the module, grounded in source.

## Install / enable

- `composer require drupal/cache_pilot` (pulls `hollodotme/fast-cgi-client:^3.1`), then
  `drush en cache_pilot`. No Drupal module dependencies. Core `^10.3 || ^11`, PHP `>=8.3`.
- APCu and/or Zend OPcache must be loaded **in the PHP-FPM pool** (not just CLI). The bundled
  `cache-pilot.php` checks `extension_loaded('apcu')` + `apc.enabled`, and
  `extension_loaded('Zend OPcache')` + `opcache.enable`.

## Configuration

- Config object: **`cache_pilot.settings`**, one key **`connection_dsn`** (string, default `''`).
  Schema: `config/schema/cache_pilot.schema.yml` (`type: string`).
- Settings form `Form\SettingsForm` at **`/admin/config/development/performance/cache-pilot`**
  (route `cache_pilot.settings`, appears as a tab under core Performance settings via
  `cache_pilot.links.task.yml`). The DSN field binds through `#config_target =>
  'cache_pilot.settings:connection_dsn'`.
- **DSN formats** (parsed by `Connection\ConnectionConfig::fromDsn()`):
  - TCP: `tcp://[host]:[port]` — e.g. `tcp://127.0.0.1:9000`, `tcp://php:9000`. Host + numeric
    port 1–65535 required.
  - Unix socket: `unix:///path/to/socket.sock` — e.g. `unix:///var/run/php/php-fpm.sock`.
  - Anything else throws `\InvalidArgumentException`; the form's `validateForm()` catches it and
    sets a form error, so a bad DSN cannot be saved.
- Disable per-environment by overriding in `settings.php`:
  `$config['cache_pilot.settings']['connection_dsn'] = NULL;` — `SocketConnectionBuilder::build()`
  then throws `MissingConnectionTypeException` and all cache ops no-op (return failure).

## Routes & permissions

All three routes require permission **`cache_pilot.administer`** (`restrict access: true`,
`cache_pilot.permissions.yml`):

| Route id | Path | Methods | Handler |
|---|---|---|---|
| `cache_pilot.settings` | `/admin/config/development/performance/cache-pilot` | GET, POST | `Form\SettingsForm` |
| `cache_pilot.dashboard` | `/admin/reports/cache-pilot` | GET | `Controller\DashboardController` (defaults `cache_type=apcu`) |
| `cache_pilot.dashboard.statistics` | `/admin/reports/cache-pilot/{cache_type}` | GET | `Controller\DashboardController` |

- Settings form is a standard `ConfigFormBase` → CSRF-protected; the two "Clear …" buttons run
  `SettingsForm::clearApcu()` / `clearOpcache()` on POST submit (call
  `ApcuCache::clear()` / `OpcacheCache::clear()`, then a status message). Buttons are `#disabled`
  when the corresponding `isEnabled()` is false.
- Dashboard (`DashboardController::__invoke`) is read-only: `match($cache_type)` calls
  `apcu->statistics()` / `opcache->statistics()`; empty result renders "problem with the
  connection to FastCGI"; otherwise themes `cache_pilot_apcu_statistics` /
  `cache_pilot_opcache_statistics`. `pageTitle()` supplies the title. Menu link
  (`cache_pilot.links.menu.yml`) under Reports; APCu/OPcache secondary tabs via task links.

## Drush / console commands

Registered in `drush.services.yml` (tag `console.command`), classes in `src/Command/`:

- **`cache-pilot:apcu:clear`** — `Command\ApcuClear`, calls `ApcuCache::clear()`; prints
  `Done!` / SUCCESS or an error / FAILURE.
- **`cache-pilot:opcache:clear`** — `Command\OpcacheClear`, calls `OpcacheCache::clear()`; same
  output contract.

Intended in deploy scripts before `drush deploy` so FPM picks up new code.

## Services & how to call programmatically

- `Cache\ApcuCache` / `Cache\OpcacheCache` (implement `Contract\CacheInterface`): `clear(): bool`,
  `isEnabled(): bool`, `statistics(): array`. Each maps to a `ClientCommand` enum case and treats
  response body `=== 'Ok'` as success; `statistics()` JSON-decodes the body (`Component\Serialization\Json`).
  Get them via `\Drupal::service(ApcuCache::class)` or DI (services are autowired).
- `Client\Client`: `isConnected(): bool` (sends `ClientCommand::Echo`, expects `Ok`),
  `sendCommand(ClientCommand): ProvidesResponseData`. Builds a FastCGI `PostRequest` targeting
  `DRUPAL_ROOT/<module path>/cache-pilot.php` with `content = http_build_query(['command' => …])`
  and custom var `cache_pilot=1`; failures are logged to channel `cache_pilot` and return an empty
  `Response`.
- `Connection\SocketConnectionBuilder::build()`: reads `connection_dsn`, returns a
  `NetworkSocket` (tcp) or `UnixDomainSocket` (unix); throws `MissingConnectionTypeException`
  (unset DSN) or `InvalidConfigurationException` (malformed).

## Hooks & requirements

- `cache_pilot_cache_flush()` (`cache_pilot.module`, `hook_cache_flush`): clears **APCu** on every
  Drupal cache rebuild (e.g. `drush cr`). OPcache is **not** auto-cleared.
- `cache_pilot_theme()` declares the three theme hooks; `template_preprocess_*` delegates to the
  `Hook\Theme\Preprocess*` classes, which build core `#type => table` render arrays plus
  `cache_pilot_fragmentation_bar` bars, using `Utils\StatisticsHelper::formatNumber()` /
  `formatRate()`. Statistics values come from APCu/OPcache system functions and render through
  escaped table arrays.
- `cache_pilot_requirements()` (runtime, `cache_pilot.install`): calls `Client::isConnected()` and
  reports **Connected / Not connected** on the status report (OK / WARNING when DSN unset /
  ERROR when set-but-unreachable), with the DSN shown as the description.

## The FPM-side script

`cache-pilot.php` (marked `@internal`) runs inside the FPM pool. It refuses to act unless
`$_SERVER['cache_pilot'] === '1'` (a FastCGI custom var only the module's client sets — not
settable from an ordinary HTTP request), then switches on `$_POST['command']` to run
`apcu_clear_cache()` / `opcache_reset()` or gather `apcu_cache_info(TRUE)` + `apcu_sma_info()` /
`opcache_get_status(FALSE)`, echoing `Ok` or a JSON blob.
