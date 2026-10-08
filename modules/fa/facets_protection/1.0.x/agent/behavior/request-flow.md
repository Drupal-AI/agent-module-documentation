<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Request-blocking flow, token lifecycle & JS

## Event subscriber

File/class: `src/EventSubscriber/FacetsProtectionRequestSubscriber.php` →
`FacetsProtectionRequestSubscriber implements EventSubscriberInterface`. Service
`facets_protection.request_subscriber`, tagged `event_subscriber`.
`getSubscribedEvents()` registers `onKernelRequestFacetsProtection()` on `KernelEvents::REQUEST`
(default priority). Constructor args (`*.services.yml`): `@language_manager`, `@config.factory`,
`@router.request_context`, `@path_processor_manager`, `@facets_protection.helper`, `@renderer`.

### Decision flow (`onKernelRequestFacetsProtection`)

1. If `facets_protection.settings:enabled` is false → `return` (no interference).
2. Clone the request and read all query params (`$request->query->all()`).
3. If there is **no `f` query parameter** → `return`. (`f` is the Facets module's active-facet
   parameter; only requests carrying it are candidates for blocking.)
4. Read `_fp`: if absent, `$access = FALSE`; otherwise `$access = $helper->checkToken($_fp)`.
5. If `$access` is true (token valid) → `return`, request proceeds normally.
6. Otherwise build a corrected URL for the same path with the **current** token injected
   (`$request_query['_fp'] = $helper->getToken()`, `Url::fromUserInput($path, ['query' => …])`),
   render the configured blocking template via `renderer->renderInIsolation()`, and set the event
   response to a `Symfony … Response` with **status 410** and that content.

The subscriber runs before routing and keys only off the presence of `f`, so it applies site-wide to
any URL bearing a facet parameter, not just registered facet routes. It fails open for everything that
lacks `f` (including admin routes, which normally have no `f` parameter).

## Helper / token lifecycle

File/class: `src/FacetsProtectionHelper.php` → `FacetsProtectionHelper`. Service
`facets_protection.helper` (args `@config.factory`, `@state`). Token lives in `State` under
`facets_protection_data` as `['current' => ['token','time'], 'previous' => ['token','time']]`.

- `processToken()` — if no state exists, generates one `md5(random_bytes(55))` token used as both
  current and previous, stores it, and invalidates the `facets_protection` cache tag. If state exists
  and `time() - current.time > ttl` (`ttl` default 1800), it rotates: previous ← current, current ← a
  new random token, then invalidates the cache tag. Returns the data array.
- `getToken()` — returns `current.token` (rotating first if the TTL elapsed).
- `checkToken($token)` — true if `$token` matches either the current or previous token
  (`in_array`). Because both are honored, links minted just before a rotation keep working for up to
  another full TTL window (effective max validity ≈ `2 × ttl`).

The token is a single site-wide value, not per user/session/IP; it is a freshness signal for facet
links, not an authentication credential.

## Block preprocess + JS behavior

`facets_protection.module`:

- `hook_preprocess_block()` — for blocks whose `configuration.provider` is `facets` or `facets_block`,
  attaches library `facets_protection/facets_protection`, sets
  `drupalSettings.facets_protection.token = $helper->getToken()`, and adds the `facets_protection`
  cache context so the block re-renders when the token rotates.
- `hook_theme()` — declares the two blocking templates (see
  [../theming/blocking-pages.md](../theming/blocking-pages.md)).

`js/facets_protection.js` (library deps `core/jquery`, `core/drupal`, `core/once`) — `Drupal.behaviors.
facetsProtection` replaces the Facets widget's default `facets_filter.facets` handler with its own
`facets_filter.facets-protection` handler that, before navigation, rewrites the target URL to carry
`_fp=<drupalSettings token>` (replacing an existing `_fp`, or appending with `?`/`&` as appropriate)
then sets `window.location`. This lets real, JS-capable visitors pass the token check transparently;
clients that do not run this JS hit the blocking page and follow the corrected link it provides.

## Uninstall

`hook_uninstall()` (`facets_protection.install`) deletes the `facets_protection_data` state and
invalidates the `facets_protection` cache tag.
