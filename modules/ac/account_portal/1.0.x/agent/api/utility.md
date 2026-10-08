<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Account Portal — helper API (`AccountPortalUtility`, `AccountPortalPathResolver`)

Two helper classes downstream/portal code calls to (a) figure out where the visitor originally
came from and (b) parse the portal path. Neither renders output or performs a redirect itself.

## `Drupal\account_portal\AccountPortalUtility` (`src/AccountPortalUtility.php`)

Static utility. Used by portal/consumer code to send a user back to the external OAuth
application after a multi-step flow.

- **`getRedirectUri(Request $request): ?string`** — resolves the origin URL:
  1. `getQueryParam($request, 'redirect_uri')` — the `redirect_uri` query param
     (set by the OAuth Authorization Code Grant).
  2. else the `referrer` request header.
  3. else, if `account_portal.custom_referer_header` is configured, that header's value.
  4. else `NULL`.

- **`getRedirectBaseUri(Request $request): ?string`** — calls `getRedirectUri()`, then
  `parse_url()`s it and rebuilds just `scheme://host[:port]`. Returns `NULL` if there is no
  redirect URI or it lacks a scheme/host.

- **`getQueryParam(Request $request, string $name): ?string`** (protected) — returns
  `$request->query->get($name)` if present; otherwise, if a `destination` query param exists, it
  does `Request::create($destination)` and searches **recursively** inside that nested URL for the
  same param. `Request::create()` only constructs a request object from the string — it does **not**
  fetch the URL.

Caller responsibility: the returned URI comes from user-controlled input (`redirect_uri`/Referer)
and is **not validated against allowed consumer origins by this module**. Code that redirects a
browser to this value must validate it against the consumer's registered redirect URIs first
(as Simple OAuth's authorize flow does) — the utility is a resolver, not a policy.

## `Drupal\account_portal\Routing\AccountPortalPathResolver` (`src/Routing/AccountPortalPathResolver.php`)

Injectable service (`autowire`), constructed with the `account_portal.base_path` parameter.

- **`getPortalPathMatch(Request $request): ?array`** — regex
  `/^<escaped base_path>\/([a-zA-Z0-9-_]+)/` against `Request::getPathInfo()`. Returns the
  `preg_match` `$matches` array or `NULL`.
- **`getPortalPathPrefix(Request $request): ?string`** — `$matches[0]`: the full
  `<base_path>/<client-id>` prefix.
- **`getPortalConsumerId(Request $request): ?string`** — `$matches[1]`: the embedded client-id.

Use it when you need to know, inside a controller/subscriber, whether the current request came
through the portal and for which consumer.

## Tests

`tests/src/Unit/AccountPortalUtilityTest.php` covers the redirect-URI resolution;
`tests/src/Functional/AccountPortalTest.php` covers request-time portal behavior.
