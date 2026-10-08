<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API endpoint — route, authentication & controller

## Route (`drupitor_client.routing.yml`)

```yaml
drupitor_client.api_updates:
  path: '/drupitor/api/v1/updates'
  defaults:
    _controller: '\Drupal\drupitor_client\Controller\DrupitorClientController::getUpdates'
  requirements:
    _drupitor_api_access: TRUE
  options:
    no_cache: TRUE
```

`GET` only in practice. `_drupitor_api_access` is a custom access-check requirement, not core
`_access`/`_permission`.

## Authentication (`src/Access/DrupitorApiAccessCheck.php`)

Service `drupitor_client.api_access_check`, tagged `access_check` with
`applies_to: _drupitor_api_access` (`drupitor_client.services.yml`) — so the requirement above is wired to
this class's `access()`. It returns `AccessResult` and denies (`AccessResult::forbidden()`, logging the
client IP to the `drupitor_client` channel) unless **all** hold:

1. config `enabled` is truthy;
2. config `api_token` is non-empty (empty → forbidden — no anonymous fall-through);
3. the request carries a non-empty token;
4. `hash_equals($configured_token, $provided_token)` is true (timing-safe comparison).

`getTokenFromRequest()` extracts the token, in order: `Authorization: Bearer <token>` (regex), a raw
`Authorization: <token>` matching `^[a-zA-Z0-9._-]+$`, the `X-API-Token` header, then the `?token=`
query parameter (documented as least secure). Only on a successful `hash_equals` does it return
`AccessResult::allowed()`.

## Controller (`src/Controller/DrupitorClientController.php::getUpdates`)

1. Re-checks config `enabled`; if off, returns JSON `{error}` with HTTP 403.
2. `collectUpdates()`:
   - `getProjectRoot()` walks up to 5 parent dirs from `DRUPAL_ROOT` to find `composer.json`.
   - Validates `composer.json` / `composer.lock` paths with `isValidPath()` (rejects `..` and null
     bytes, requires the resolved dir to sit inside `DRUPAL_ROOT` / project root) and parses them with
     `parseJsonFile()` (10 MB cap).
   - `getInstalledPackages()` reads `composer.lock` `packages` + `packages-dev` → name, current_version,
     description, type, homepage.
   - `enrichPackagesWithLatestVersions()` runs `composer show --latest --format=json` via `proc_open()`
     with `escapeshellarg()` on the project root and Composer path, a non-blocking read loop bounded by
     `command_timeout` (capped at 120 s), then fills `latest_version` and `is_outdated`. `getComposerPath()`
     re-validates the configured path against `^[a-zA-Z0-9\/_.-]+$`, falling back to `composer`.
   - Returns `{project_root: basename, total_packages, packages[], scan_time}`.
3. `encryptData()` requires config `encryption_key` (throws → HTTP 500 if empty). Derives the key with
   `hash('sha256', encryption_key, true)`, generates a random IV, and encrypts the JSON with
   `openssl_encrypt` using `encryption_method` (AES-256-GCM adds an auth `tag`; else AES-256-CBC).
4. Success response: JSON `{status: 'success', timestamp, encrypted: true, data: {payload, iv, [tag],
   method}}`. On any exception: `{error, timestamp}` with HTTP 500.

`decryptData()` exists for the Drupitor host / testing (mirrors the encryption). Every step logs to the
`drupitor_client` channel. The module never initiates outbound HTTP — the Drupitor SaaS polls this route.

## Operating it

Enable the module functionality and set `api_token` + `encryption_key` (form or `settings.php`), then have
the client `GET /drupitor/api/v1/updates` with the token in a header (preferred), e.g.
`Authorization: Bearer <token>` or `X-API-Token: <token>`. The client decrypts `data` with the shared
encryption key.
