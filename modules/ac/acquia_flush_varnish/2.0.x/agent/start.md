<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia Flush Varnish (acquia_flush_varnish) — agent index

Adds one admin action that purges the **Acquia Cloud Varnish + Platform CDN** cache for the current
site's domain via the **Acquia Cloud API**. Acquia-hosted (Cloud / Site Factory) only — it reads the
platform env vars `AH_SITE_ENVIRONMENT`, `AH_APPLICATION_UUID`, `HTTP_HOST`. No Composer deps, no
module deps. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.0.4.

- **The flush route, permission, the `AcquiaCloudUtility` service, credential config, and how to
  call the API from custom code** → [api/cloud-utility.md](api/cloud-utility.md)

## What it actually is

- **One service**, `acquia_flush_varnish.cloudutility` → `Drupal\acquia_flush_varnish\AcquiaCloudUtility`
  (`src/AcquiaCloudUtility.php`); args `@request_stack`, `@messenger`, `@config.factory`.
- **One route**, `acquia_flush_varnish.cache` at `/admin/config/development/flush-all-cache`
  (`*.routing.yml`), controller `acquia_flush_varnish.cloudutility:acquiaFlushVarnishCache`,
  guarded by `_permission: 'clear varnish cache'` **and** `_csrf_token: 'TRUE'`.
- **One permission**, `clear varnish cache` (`*.permissions.yml`, `restrict access: true`).
- **One menu link**, `acquia_flush_varnish.cache` ("Clear varnish cache") under
  `system.admin_config_development` (`*.links.menu.yml`).
- **No** config schema, no `config/install`, no settings form, no Drush, no hooks, no plugins,
  no `.install`. Config object `acquia_flush_varnish.settings` is expected to be supplied out-of-repo
  via `secrets.settings.php` (keys `acquiacloud_apikey`, `acquiacloud_secret`).

## Mechanism (from source)

- `acquiaFlushVarnishCache()` reads `$_ENV['AH_SITE_ENVIRONMENT'|'HTTP_HOST'|'AH_APPLICATION_UUID']`,
  gets an OAuth token via `getaccesstoken()`, lists environments
  (`applications/{uuid}/environments`), matches the current env by name, then POSTs to
  `environments/{id}/domains/{domain}/actions/clear-caches`, shows the API `message`, and redirects
  back to `HTTP_REFERER`.
- `getaccesstoken()` POSTs `grant_type=client_credentials` with the configured key/secret to
  `https://accounts.acquia.com/api/auth/oauth/token`.
- `getAcquiaApi($url, $token, $method='GET', $data=[])` is the generic Bearer-auth caller; base API
  is fixed to `https://cloud.acquia.com/api/`. Both use core PHP `curl` with default TLS
  verification.
