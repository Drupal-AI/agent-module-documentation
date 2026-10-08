<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Coveo security-provider plugin type & token endpoint

Search components mint a Coveo **search token** for the current user through a pluggable security
provider. This is what lets the browser-side Atomic UI query Coveo scoped to who is logged in.

## Plugin type `coveo_security_provider`

- Manager: `plugin.manager.coveo_security_provider` (`src/Plugin/CoveoSecurityProviderManager.php`,
  extends `DefaultPluginManager`; interface `CoveoSecurityProviderManagerInterface`).
- Discovery: attribute `Drupal\coveo\Attribute\CoveoSecurityProvider` (id/title/description); a legacy
  `Drupal\coveo\Annotation\CoveoSecurityProvider` also exists. Plugins live in
  `src/Plugin/Coveo/SecurityProvider/`.
- Plugin interface: `CoveoSecurityProviderPluginInterface::generateToken(CoveoSearchComponent, AccountInterface): string`
  and `getIdentityProviderId(): string`. `CoveoIdentityProviderPluginInterface` adds identity-provider
  wiring for secured search.

## Shipped providers

- **`TokenProvider`** (`token_provider`, "Token Provider") — `generateToken()` returns the search
  component's `searchKey()` unchanged. Its own description flags it: *"Trivial implementation that
  passes through the provided token. Not a best practice, use with care."* `getIdentityProviderId()`
  throws (not implemented). Use only when the component's search key is itself a public search token.
- **`AbstractSecuredUserProvider`** — base that builds Coveo `RestTokenParams` with a single
  `RestUserId` (name = `getName($account)`, provider = `getIdentityProviderId()`, type `User`),
  dispatches a **`CoveoTokenAlter`** event so listeners can add analytics/permissions, then calls
  `$search->getSearchApi()->token($params, $orgId)`. On failure it logs via
  `Neclimdul\OpenapiPhp\Helper\Logging\Error::logError` and returns the literal string `'fail'`.
- **`EmailProvider`** (`email_provider`, "Email Provider") — extends the abstract; `getName()` returns
  `$account->getEmail() ?? 'anon@example.com'`, `getIdentityProviderId()` = `Email Security Provider`.
  Targets Coveo's out-of-the-box Email Security Provider.

The `coveo_secured_search` submodule adds a **`DrupalProvider`** (`drupal_provider`) whose `getName()`
is the Drupal user id — see that submodule's docs.

## Token endpoint `/coveo/refresh`

- Route `coveo.token_refresh` → `Controller\SearchTokenRefresh::getNewToken`, permission
  **`access coveo search`**.
- Requires a `?search=<component id>` query param; 404 (`NotFoundHttpException`) if missing or the
  `coveo_search_component` does not load.
- Calls `$search->getToken($request, $this->currentUser())` → the component's security provider →
  returns `JsonResponse(['token' => $token])`, or a 500 JSON on failure.
- Client side: `modules/coveo_atomic/js/coveo_atomic.js` calls `$.getJSON('/coveo/refresh', {search})`
  and hands the token to `atomic-search-interface.initialize({accessToken, organizationId,
  renewAccessToken})`. Grant `access coveo search` to whichever roles (including anonymous, for a
  public search) should be able to obtain a search token.

## Related events (`src/Event/`)

`CoveoTokenAlter`, `CoveoBatchAlter`, `CoveoOrganizationSync` — dispatched at token generation, batch
push and org sync respectively; subscribe to adjust parameters before they reach Coveo.
