<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Module settings, retry middleware & caching

## Install / enable

`composer require drupal/api_browser` (pulls `drupal/project_browser ^2.1` and
`mtdowling/jmespath.php ^2.7`), then `drush en api_browser`. Installing creates six example
services (`config/install/api_browser.service.packagist_*`) pointing at packagist.org — nothing is
shown in Project Browser until you enable a source in Project Browser's settings. Optionally enable
`key` so credentials stay out of config exports.

## `api_browser.settings` (config object)

Form: `src/Form/ApiBrowserSettingsForm.php` (`ConfigFormBase`), route `api_browser.settings` at
`/admin/config/development/project_browser/api_browser/settings` (perm
`administer api_browser_service`). Schema `config/schema/api_browser.schema.yml`; install defaults
`config/install/api_browser.settings.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `debug.enable` | boolean | `false` | Debug mode on the service form (form checkbox "Enable debug mode"). |
| `concurrency` | integer (min 1) | `20` | Max simultaneous per-project requests in the Guzzle `Pool` when building a listing. Read by `ApiBrowserService::getConcurrency()` (clamped to ≥1). |
| `max_retries` | integer (min 0) | `3` | Retry budget for the retry middleware. |

The form only exposes `debug` and `concurrency`; `max_retries` lives in config/schema and is read by
the middleware.

## Retry middleware

`src/Http/RetryMiddleware.php` — a `final` class registered as service
`api_browser.retry_middleware` (`api_browser.services.yml`) tagged `http_client_middleware`, so it
wraps Drupal's shared HTTP client while preserving its configuration. It acts **only** on requests
that opt in with the option `api_browser_retry` (`RetryMiddleware::OPTION`), which
`ApiBrowserService::getRequestOptions()` sets on every request the module makes — all other site
traffic is untouched.

- `decide()` retries while `retries < max(0, max_retries)` and the failure is a Guzzle
  `ConnectException` **or** the response status is `429`/`503`.
- `delay()` honours a numeric `Retry-After` header (capped at 60s); otherwise exponential backoff
  `2 ** retries` seconds.

## Caching model

- Listing results cache: cid `<id>:results`, tags `api_browser:results`, `api_browser:results:<id>`.
- Per-project info cache: cid `<id>:result:<md5(record)>` (a `NULL` entry marks a record the filter
  excluded, so it is not re-requested).
- OAuth token cache: cid `<id>:oauth2:<md5(...)>`, TTL `expires_in - 30`s.
- All are permanent (except OAuth TTL) and cleared by `ApiBrowserService::invalidateCaches()` on
  save/delete/refresh, which also clears the Project Browser source manager definitions and the
  `project_browser:<sourcePluginId>` tag. Use the **Refresh** operation/button to discard them
  manually; the listing rebuilds lazily on the next view.

## Status report

`ApiBrowserRequirements` (`runtime_requirements` hook) warns when a service stores an
`api_key`/`bearer_token`/`basic_auth` secret literally with no Key entity selected — see
[../entities/authentication.md](../entities/authentication.md).
