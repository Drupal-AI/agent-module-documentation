<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flush route, permission & AcquiaCloud utility service

All logic is in `src/AcquiaCloudUtility.php` (service id `acquia_flush_varnish.cloudutility`,
wired in `acquia_flush_varnish.services.yml` with `@request_stack`, `@messenger`, `@config.factory`).

## Install / enable

`drush en acquia_flush_varnish`. Only meaningful on an Acquia-hosted environment (Cloud or Site
Factory): `acquiaFlushVarnishCache()` reads `$_ENV['AH_SITE_ENVIRONMENT']`, `$_ENV['HTTP_HOST']`,
`$_ENV['AH_APPLICATION_UUID']`, which Acquia sets. Off-Acquia these are undefined and the flush is a
no-op / notice.

## Credentials (no shipped config, no UI form)

There is no settings form and no `config/install`. The code reads config object
`acquia_flush_varnish.settings`:

- `acquiacloud_apikey` — Acquia Cloud API key (client_id)
- `acquiacloud_secret` — Acquia Cloud API secret (client_secret)

Per README, set these out-of-repo in `secrets.settings.php` on the Acquia server (loaded from
`settings.php` / factory hook), e.g.:

```php
$config['acquia_flush_varnish.settings']['acquiacloud_apikey'] = 'xxxxxx';
$config['acquia_flush_varnish.settings']['acquiacloud_secret'] = 'xxxxxxxx-yyyyy';
```

Obtain the key/secret from Acquia Accounts → API Tokens.

## Route, menu & access

- Route `acquia_flush_varnish.cache` → path `/admin/config/development/flush-all-cache`, title
  "Clear varnish cache", controller `…cloudutility:acquiaFlushVarnishCache`.
- Requirements: `_permission: 'clear varnish cache'` **and** `_csrf_token: 'TRUE'` — so the endpoint
  is reachable only by a role granted the permission, and only through a Drupal-signed CSRF link
  (the menu link supplies the token; a raw GET without a valid token is rejected).
- Permission `clear varnish cache` is declared `restrict access: true` (`*.permissions.yml`) —
  grant only to trusted admins.
- Menu link (`*.links.menu.yml`) places "Clear varnish cache" under Configuration → Development
  (`system.admin_config_development`).

## Flush flow — `acquiaFlushVarnishCache(): RedirectResponse`

1. Read env: `$mydomainenv` (`AH_SITE_ENVIRONMENT`), `$mydomain` (`HTTP_HOST`), `$myappuuid`
   (`AH_APPLICATION_UUID`).
2. `getaccesstoken()` → OAuth access token.
3. `getAcquiaApi("https://cloud.acquia.com/api/applications/{uuid}/environments", $token)` → build a
   name→id map of environments.
4. If the current env name matches, POST to
   `environments/{id}/domains/{domain}/actions/clear-caches` and show the returned `message` via
   Messenger.
5. If no token, add an error telling the admin to configure credentials in `secrets.settings.php`.
6. Return `RedirectResponse($referer)` back to the page the admin came from (`HTTP_REFERER`).

## Reusable API methods (call from custom code)

```php
$svc = \Drupal::service('acquia_flush_varnish.cloudutility');
$token = $svc->getaccesstoken();                     // ['access_token' => ...] on 200
$access = (string) $token['access_token'];
$data = $svc->getAcquiaApi($apiUrl, $access);        // GET
$data = $svc->getAcquiaApi($apiUrl, $access, 'POST', $postFields); // POST
```

- `getaccesstoken(): ?array` — POSTs `grant_type=client_credentials&client_id=…&client_secret=…`
  to `https://accounts.acquia.com/api/auth/oauth/token`; returns the decoded JSON (on non-200 it
  returns the decoded error body instead).
- `getAcquiaApi(string $api_url, string $access_token, ?string $method='GET', ?array $data=[]): array`
  — generic caller, sends `Authorization: Bearer {token}`; POST sends `$data` as post fields. Base
  API host is fixed to `https://cloud.acquia.com/api/`.

All HTTP uses core PHP `curl_*` with default options — TLS peer verification is left at its secure
default (not disabled).
