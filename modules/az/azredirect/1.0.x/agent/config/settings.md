<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AZRedirect — settings, subscriber and operation

Everything AZRedirect does is driven by one boolean config value and one kernel request subscriber.

## Install / enable

1. Enable OpenID Connect and the Azure client: `drush en openid_connect openid_connect_windows_aad`.
   (`azredirect.info.yml` only declares `openid_connect_windows_aad`, but the subscriber injects
   `openid_connect` services, so both are required at runtime.)
2. Configure an OIDC client whose machine name is exactly **`windows_aad`** (config object
   `openid_connect.client.windows_aad`) with client id/secret, tenant and redirect settings — this
   is done in openid_connect_windows_aad, not here. AZRedirect hard-codes this client name in
   `AzredirectSubscriber::onKernelRequest()`; there is no UI to choose a different client.
3. `drush en azredirect`.

## The setting

- Form: `Drupal\azredirect\Form\AzSettingsForm` (`src/Form/AzSettingsForm.php`), form id
  `azredirect_az_settings`, `getEditableConfigNames()` → `['azredirect.settings']`.
- Route: `azredirect.az_settings` → **`/admin/config/system/az-settings`**, title "Az redirect
  settings", requirement `_permission: 'administer site configuration'`
  (`azredirect.routing.yml`).
- Menu link `azredirect.az_settings` (title "AZ Redirect", parent `user.admin_index`, weight 10)
  from `azredirect.links.menu.yml` — appears under People/admin index, **not** under the route's
  own `/admin/config/system` path.
- One field: checkbox **`user_route`** ("Login route", description "Redirect enable or disable the
  login route."). `submitForm()` writes `azredirect.settings:user_route` = the checkbox value.
- Config object **`azredirect.settings`** has **no `config/install` seed and no `config/schema`**
  (there is no `config/` directory in the module). The object does not exist until the form is
  saved once; being schema-less it exports untyped. To enable programmatically:
  `drush cset azredirect.settings user_route 1 -y` (creates the object).

## What happens when enabled (`AzredirectSubscriber`)

Service `azredirect.event_subscriber` (`azredirect.services.yml`), tagged `event_subscriber`,
subscribes to `KernelEvents::REQUEST` → `onKernelRequest` and `KernelEvents::RESPONSE` →
`onKernelResponse` (the response handler is an **empty no-op**).

`onKernelRequest(RequestEvent $event)` acts only when **all** hold:

- `config('azredirect.settings')->get('user_route')` is truthy;
- `currentUser->isAnonymous()`;
- the resolved route name is **not** in the whitelist:
  `user.reset`, `user.login.http`, `user.login`,
  `openid_connect.redirect_controller_redirect`, `openid_connect_windows_aad.sso`,
  `user.reset.login`.

When it fires, in order:

1. `openid_connect.session->saveDestination()` — stores the current destination so OIDC can return
   the user to it after login.
2. `logger.channel.default->notice($route_name)` — logs the current route machine name at notice
   level on **every** matching anonymous request (expect high log volume on busy sites).
3. Reads `config.factory->getEditable('openid_connect.client.windows_aad')->get('settings')` and
   `pluginManager->createInstance('windows_aad', $configuration)`; `setParentEntityId('windows_aad')`.
4. `$scopes = claims->getScopes($client)`; sets `$_SESSION['openid_connect_op'] = 'login'`.
5. `$response = $client->authorize($scopes)` and `$event->setResponse($response)` — a redirect to
   the Azure authorize endpoint. The redirect URL comes from the fixed OIDC client configuration,
   not from the request.

## Operational notes / caveats

- **Whole-site gate.** Any route not in the whitelist is redirected for anonymous users. This
  includes anonymous-facing infrastructure routes (image-style derivatives, JSON:API/REST,
  webhook/callback endpoints, etc.). If anonymous access to such routes matters, enabling
  `user_route` will bounce them into the OIDC flow. Add needed route names to the whitelist array
  in the subscriber (code change) if that is a problem.
- **Hard-coded client.** The client name `windows_aad` is fixed in code. If no
  `openid_connect.client.windows_aad` config exists / the client can't be instantiated, the
  request handling will error — configure the client before enabling the setting.
- **Login loop safety.** The whitelist keeps `/user/login`, the password-reset routes and the OIDC
  redirect/SSO callbacks reachable so the login round-trip can complete; do not remove those
  entries.
- **Disable.** Uncheck "Login route" (or `drush cset azredirect.settings user_route 0`) to turn the
  forced redirect off. Test changes in a private window or after logging out, since authenticated
  users are never affected.
