<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Control Admin Access — middleware, form, config and operation

Everything this module does lives in two classes plus three YAML files. Reading this is shorter than reading the
source.

## Install / enable

- `drush en control_admin_access -y`. No dependencies beyond Drupal core; nothing to composer-require beyond the
  module itself. No install hook, no default config is shipped — `control_admin_access.adminsettings` starts empty
  until you save the form, so **enabling alone blocks nothing**.

## The middleware — `CaaMiddleware` (`src/CaaMiddleware.php`)

- Service `control_admin_access.middleware`, class `Drupal\control_admin_access\CaaMiddleware`, tagged
  `http_middleware` with **priority 250** (comment: "come before page caching, so you don't serve cached pages to
  banned users"). Arguments: `@config.factory`, `@path.matcher`. It decorates `HttpKernelInterface`.
- `handle(Request $request, ...)`:
  1. `$config = configFactory->get('control_admin_access.adminsettings')`.
  2. If `blocked_urls` is a non-empty array → `checkUrl()`.
  3. `checkUrl()` = `pathMatcher->matchPath($request->getRequestUri(), implode("\n", $blocked_urls))`. The
     patterns are **Drupal path globs** (`*` wildcards), matched against the **raw request URI**
     (`getRequestUri()`, which includes the query string).
  4. If matched **and** `whitelist` is a non-empty array → `checkIp()` =
     `IpUtils::checkIp($request->getClientIp(), array_filter(array_map('trim', $whitelist)))` (Symfony `IpUtils`,
     supports IPv4/IPv6 single addresses and CIDR ranges).
  5. Not in allowlist → returns `new Response()` with `setStatusCode(401)`. Otherwise
     `httpKernel->handle($request, ...)` proceeds normally.

Key behavioral facts:

- The gate fires **only when both lists are populated**. `blocked_urls` non-empty but `whitelist` empty ⇒ no
  block at all (the middleware falls through to the kernel).
- The response on denial is a **bare 401** with no body/headers set beyond the status code.
- Matching is on `getRequestUri()` (raw, pre-routing, case-sensitive glob), not the resolved internal route path.
  Author your `blocked_urls` patterns against the actual request paths you want to cover.

## The form — `AdminControlAccess` (`src/Form/AdminControlAccess.php`)

- `ConfigFormBase`, form id `control_admin_access`, editable config `control_admin_access.adminsettings`.
- Two textareas:
  - **`whitelist`** — "Enter IPs or IP ranges (Whitelist)"; placeholder `127.0.0.1` / `192.168.0.0/25`. One entry
    per line.
  - **`blocked_urls`** — "Enter URLs to block except for Whitelist"; placeholder `/*/admin` / `/*/admin/*`. One
    entry per line.
  - Plus a static `#markup` warning that adding rules can block all out-of-range IPs.
- `submitForm()` stores each field as an array via `explode("\n", trim($form_state->getValue(...)))` and calls
  `->save()` (two separate saves), then shows "All values have been saved." Note: values are split on newlines
  with **no per-line validation/trimming at save time** — leading/trailing spaces on lines are trimmed later in
  the middleware (`array_map('trim', ...)`) for the whitelist only.

## Config object `control_admin_access.adminsettings`

| key | type | meaning |
|-----|------|---------|
| `whitelist` | array of strings | IPs / CIDR ranges allowed through blocked URLs (one per element). |
| `blocked_urls` | array of strings | Path glob patterns to gate (one per element). |

No `config/schema/*` is shipped, so these keys are **schema-less** (config export works, but there is no typed
schema/translation metadata). Manage with `drush cget/cset/cdel control_admin_access.adminsettings`.

## Route, menu, permission

- Route `control_admin_access.form`: path `/admin/config/system/control-admin-access`, `_form` =
  `AdminControlAccess`, `_title` "Access admin control", requirement `_permission: 'administration access vpn'`,
  option `_admin_route: TRUE`.
- Menu link `control_admin_access.admin` (title "Control access VPN") under `system.admin_config_system`
  (*Configuration → System*), weight 100.
- Permission `administration access vpn` ("Administer access VPN module"). Grant it only to trusted admins — it
  controls who can change (or remove) the IP gate.

## Operating / recovery

- Verify against a throwaway path before pointing `blocked_urls` at `/admin` — a wrong allowlist locks admins out
  of the blocked paths.
- Behind a proxy/CDN, configure Drupal **trusted reverse proxy** settings so `getClientIp()` reflects the true
  client IP; otherwise the allowlist compares against the proxy address.
- Lockout recovery: `drush cdel control_admin_access.adminsettings` (or clear the two keys with
  `drush cset control_admin_access.adminsettings whitelist "[]"`), then `drush cr`.
