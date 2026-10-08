<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Account Portal — configuration, routing & request handling

Install: `composer require drupal/account_portal` (pulls `drupal/consumers ^1.19`), then
`drush en account_portal`. Core `^10.3 || ^11`, PHP `>=8.1`.

There is **no configuration UI**. `account_portal.routing.yml` exposes one route,
`account_portal.settings` → `/admin/config/account-portal/settings`, permission
**`administer account settings`** (a core permission, not defined here). Its form
`AccountPortalSettingsForm::buildForm()` renders a static markup notice and
`submitForm()` does nothing. All settings are **Symfony service parameters** — set them in a
site/module `services.yml` (or `sites/*/services.yml`) and rebuild the container (`drush cr`).

## Service parameters (`account_portal.services.yml` defaults)

| Parameter | Default | Meaning |
|---|---|---|
| `account_portal.base_path` | `/account-portal/realm` | Prefix before the consumer id. Portal URLs are `<base_path>/<client-id>/<real-drupal-path>`. |
| `account_portal.invalid_consumer_id_destination` | `<front>` | Route name to redirect to when the URL's client-id matches no consumer. `null` = do not redirect (just set the id). |
| `account_portal.custom_referer_header` | `null` | Extra request header name checked by `AccountPortalUtility` when resolving origin. |
| `account_portal.routes` | `user.login`, `user.pass`, `user.register`, `user.logout`, `oauth2_token.authorize` | Route names that get the portal prefix on generated links. |

## Services (`account_portal.services.yml`, all autowired)

- **`AccountPortalPathResolver`** (`src/Routing/AccountPortalPathResolver.php`) — injected the
  `base_path` param. `getPortalPathMatch()` builds regex `/^<escaped base_path>\/([a-zA-Z0-9-_]+)/`
  and matches `Request::getPathInfo()`. `getPortalPathPrefix()` returns `$matches[0]` (base path +
  client-id); `getPortalConsumerId()` returns `$matches[1]` (the client-id). Returns `NULL` when the
  path is not a portal path.

- **`AccountPortalPathProcessor`** (`src/PathProcessor/AccountPortalPathProcessor.php`) — tagged
  `path_processor_inbound` and `path_processor_outbound`, both **priority 200**. Injected the
  resolver, `base_path` and `routes`.
  - `processInbound()`: if the resolver finds a prefix, returns `substr($path, strlen($prefix))` —
    i.e. strips the whole `<base_path>/<client-id>` prefix so Drupal's router sees the real path.
  - `processOutbound()`: no-ops unless `$request` and `$options['route']` are set **and** the route's
    `_account_portal` default is TRUE **and** the current request is itself a portal request; then it
    prepends the current prefix to the generated link. So links only get portalized when you are
    already inside the portal, keeping normal site links untouched.

- **`RouteSubscriber`** (`src/Routing/RouteSubscriber.php`, extends `RouteSubscriberBase`) —
  `alterRoutes()` iterates `account_portal.routes` and calls `$route->setDefault('_account_portal', TRUE)`
  on each that exists in the collection. This flag is the sole signal the outbound processor keys on.
  Add a route to `account_portal.routes` and rebuild to have its links portalized.

- **`KernelEventSubscriber`** (`src/EventSubscriber/KernelEventSubscriber.php`) — subscribes to
  `KernelEvents::REQUEST` at **priority 9999** (very early). `onRequestSetConsumer()`:
  1. Gets the client-id via `pathResolver->getPortalConsumerId($request)`; if none, does nothing.
  2. If `invalid_consumer_id_destination` is set **and** `validateConsumerId()` fails
     (`entityTypeManager->getStorage('consumer')->loadByProperties(['client_id' => $id])` is empty),
     it issues a `RedirectResponse` to `Url::fromRoute($destination, [], ['query' => $params])`,
     carrying the request's `redirect_uri` query param along so the user can still return to origin.
     The destination is an internal **route name**, so the redirect target is not attacker-controlled.
  3. Otherwise sets `$request->query->set('consumerId', $id)` so the Consumers module's
     `consumer.negotiator` selects that consumer. A downstream `X-Consumer-ID` header still wins.

## Operating notes

- The base path is matched by a hand-built regex; if you change `base_path`, keep it slash-delimited
  (the resolver escapes `/`). The client-id charset accepted in the URL is `[a-zA-Z0-9-_]+`.
- `<front>` works as the default destination because it is a valid route name for `Url::fromRoute`.
- Nothing here defines config objects — there is no `config/install` or `config/schema`, so
  `provides_config_schema` is false and there is nothing to export with `drush cex`.
