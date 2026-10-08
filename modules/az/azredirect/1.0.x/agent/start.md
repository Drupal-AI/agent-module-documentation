<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AZRedirect (azredirect) — agent index

Glue module that **forces anonymous visitors into the Azure AD (Entra ID) OpenID Connect login flow** on every route except a small login/callback whitelist. Package `Other`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0.

- **The one setting, the request subscriber that does the redirect, routes and how to operate it** →
  [config/settings.md](config/settings.md)

## What it actually is

- **One event subscriber:** `AzredirectSubscriber` (`src/EventSubscriber/AzredirectSubscriber.php`), service `azredirect.event_subscriber`, tagged `event_subscriber`. Subscribes to `KernelEvents::REQUEST` (`onKernelRequest`) and `KernelEvents::RESPONSE` (`onKernelResponse` — empty no-op).
- **One config form:** `AzSettingsForm` (`src/Form/AzSettingsForm.php`, `final`, extends `ConfigFormBase`), form id `azredirect_az_settings`, at route `azredirect.az_settings` → `/admin/config/system/az-settings`, permission `administer site configuration`. Menu link `azredirect.az_settings` (title "AZ Redirect") under `user.admin_index`.
- **One config object:** `azredirect.settings` with a single key `user_route` (boolean). **No `config/install` default and no `config/schema`** — the object is created only when the form is saved and is schema-less.
- **No** entities, permissions (`*.permissions.yml` absent), plugins, hooks (`azredirect.module` is an empty stub), Drush, or libraries of its own.

## Dependencies

- Declared in info.yml: `openid_connect_windows_aad`. composer.json requires `drupal/openid_connect:^3.0`. The subscriber also consumes core `openid_connect` services directly, so **both `openid_connect` and `openid_connect_windows_aad` must be enabled**.
- Injected services (see `azredirect.services.yml`): `openid_connect.session`, `plugin.manager.openid_connect_client`, `openid_connect.claims`, `config.factory` (twice), `current_user`, `current_route_match`, `logger.channel.default`.

## Mechanism (from source)

- `onKernelRequest()` runs only when `azredirect.settings:user_route` is truthy **and** `currentUser->isAnonymous()` **and** the current route name is **not** in the whitelist `['user.reset','user.login.http','user.login','openid_connect.redirect_controller_redirect','openid_connect_windows_aad.sso','user.reset.login']`.
- When it fires it: calls `openid_connect.session->saveDestination()` (so OIDC returns the user to their original path), logs the route name at notice level, loads the **hard-coded** `openid_connect.client.windows_aad` settings via `getEditable(...)->get('settings')`, creates the `windows_aad` OIDC client plugin, sets `$_SESSION['openid_connect_op'] = 'login'`, and returns `$client->authorize($scopes)` as the response — a redirect to Azure's authorize endpoint. The redirect target is the fixed OIDC client, not a request-supplied URL.

## Operate it

Enable `openid_connect` + `openid_connect_windows_aad`, configure the `windows_aad` OIDC client, then enable AZRedirect and tick **Login route** at `/admin/config/system/az-settings`. Uncheck to disable. Details in [config/settings.md](config/settings.md).
