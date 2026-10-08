# Programmatic API (ACSF platform only)

Three core classes in `Drupal\acsf`. All real communication is gated on `is_acquia_host()`, so
these no-op off-platform. None are wired as typical Drupal plugins — ACSF uses its own event system.

## `AcsfMessage` — site → Factory REST wrapper

Abstract wrapper around an HTTP request to the Site Factory; the concrete class is
`AcsfMessageRest`. Auth/URL come from an `AcsfConfig` object (defaults to `AcsfConfigDefault`,
reading Acquia hosting creds). `send()` returns early if not on an Acquia host.

```php
use Drupal\acsf\AcsfMessageRest;

$m = new AcsfMessageRest('GET', 'site-api/v1/sync/', ['site_id' => 406]);
$m->send();
$code = $m->getResponseCode();   // int|FALSE
$body = $m->getResponseBody();   // array|FALSE
```

A failed/empty/malformed response throws (`AcsfMessageFailedResponseException`,
`AcsfMessageEmptyResponseException`, `AcsfMessageMalformedResponseException`). Optional constructor
args: `AcsfConfig $config`, `$ah_site`, `$ah_env`, and a `Closure $callback` run on the response.

## `AcsfSite` — the site's Factory identity

Singleton mirror of this site's Factory data, keyed by
`$GLOBALS['gardens_site_settings']['conf']['acsf_site_id']` (from `sites.json`). Off-Acquia with no
id it loads empty; on Acquia with no id it throws `AcsfSiteMissingIdentifierException`.

```php
use Drupal\acsf\AcsfSite;

$site = AcsfSite::load();     // static-cached singleton
$site->refresh($stats);       // GET site-api/v1/sync/{id}, fires acsf_site_data_receive, saves
$site->saveSiteInfo($info);   // merge + persist, stamps last_sf_refresh
$site->clean();               // wipe local info then refresh (destructive)
```

Properties are magic (`__get`/`__set`) over an internal `info` array; persisted through
`acsf.variable_storage` (the `acsf_variables` submodule) inside `acsf_site_data_save` events.
`hook_cron()` calls `refresh()` at most daily.

## `AcsfEvent` — platform lifecycle event framework

`Drupal\acsf\Event\AcsfEvent` runs the handlers registered for a `type` (see
[hooks/acsf.md](../hooks/acsf.md)). Factory method uses ACSF defaults:

```php
use Drupal\acsf\Event\AcsfEvent;

$event = AcsfEvent::create('site_duplication_scrub', ['key' => 'value']);
$event->run();                 // loadHandlers() then dispatch
$debug = $event->debug();      // per-handler timing / messages
```

Handlers subclass `AcsfEventHandler` and implement `handle()`, reading/writing the shared
`$this->event->context`. Known event types: `acsf_install`, `acsf_stats`,
`acsf_site_data_receive`, `acsf_site_data_save`, `site_duplication_scrub`. Retrieve the registry
with `acsf_get_registry()`; rebuild it with `acsf_build_registry()` / `drush acsf-build-registry`.
