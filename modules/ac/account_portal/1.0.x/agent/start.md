<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Account Portal (account_portal) — agent index

A **routing / consumer-negotiation layer** that turns Drupal's user + OAuth routes into a
per-consumer "account portal" in front of Simple OAuth's authorize endpoint (Google-accounts
style). It adds **no pages, entities, permissions, plugin types or Drush** — it only rewrites
paths and picks the current Consumers entity from the URL. Depends on **`consumers`** (`^1.19`).
Core `^10.3 || ^11`, PHP `>=8.1`. License GPL-2.0-or-later. Version 1.0.2.

- **Service parameters, routing, event subscriber, path processors, the no-op settings form** →
  [config/settings.md](config/settings.md)
- **`AccountPortalUtility` + `AccountPortalPathResolver` helper API** →
  [api/utility.md](api/utility.md)

## What it actually is

- **Base path prefix**: inbound requests look like `/account-portal/realm/<client-id>/user/login`.
  The `<client-id>` is a Consumers `client_id`. Everything after the prefix is a normal Drupal path.
- **One admin route**, `account_portal.settings` at `/admin/config/account-portal/settings`
  (`account_portal.routing.yml`), permission core **`administer account settings`**. Its form
  `AccountPortalSettingsForm` (`src/Form/`) only prints "Configuration of this module is done via
  service parameters." — `submitForm()` is empty. **No config entities, no config schema.**
- **Configuration is service parameters only** (in your own `services.yml`): `account_portal.base_path`
  (`/account-portal/realm`), `account_portal.invalid_consumer_id_destination` (`<front>`; null =
  no redirect), `account_portal.custom_referer_header` (null), `account_portal.routes` (list of route
  names to prefix: `user.login`, `user.pass`, `user.register`, `user.logout`, `oauth2_token.authorize`).

## Moving parts (from source, `account_portal.services.yml`)

- `AccountPortalPathResolver` (`src/Routing/`) — regex-matches the base path + `([a-zA-Z0-9-_]+)`
  against `Request::getPathInfo()`; returns the full prefix (`getPortalPathPrefix`) and the embedded
  consumer id (`getPortalConsumerId`).
- `AccountPortalPathProcessor` (`src/PathProcessor/`, tagged inbound+outbound priority 200) —
  **inbound** strips the prefix so Drupal routes the clean path; **outbound** re-adds the prefix to
  generated links whose route carries the `_account_portal` default and only while the current request
  is itself a portal request.
- `RouteSubscriber` (`src/Routing/`) — on route rebuild, sets `_account_portal = TRUE` on every route
  named in `account_portal.routes` (that flag is what the outbound processor keys on).
- `KernelEventSubscriber` (`src/EventSubscriber/`) — `KernelEvents::REQUEST` at priority **9999**:
  if the path is a portal path, either redirects to `invalid_consumer_id_destination`
  (via `Url::fromRoute`, an internal route name) when the client-id matches no `consumer` entity, or
  sets the `consumerId` query param so `consumer.negotiator` picks that consumer. An `X-Consumer-ID`
  header still takes precedence downstream.
- `AccountPortalUtility` (`src/`, static) — `getRedirectUri()` / `getRedirectBaseUri()` resolve the
  visitor's origin from `redirect_uri` (searched recursively through a `destination` param) or the
  `referrer`/custom header, for downstream code to return users to the external app.

## Not provided

No hook_permission/`*.permissions.yml`, no `config/install` or `config/schema`, no Drush commands,
no plugin types, no blocks, no entities, no libraries. Tests: `tests/src/Functional/AccountPortalTest.php`,
`tests/src/Unit/AccountPortalUtilityTest.php`.
