<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure domain_301_redirect

Settings form: `/admin/config/search/domain-301-redirect`
(`Domain301RedirectConfigForm`, route `domain_301_redirect.settings`, permission
`administer domain 301 redirect`). Config object `domain_301_redirect.settings`:

| Key | Type | Install default | Meaning |
|---|---|---|---|
| `enabled` | bool | `true` | Master switch for redirection. (No redirect happens while `domain` is empty regardless.) |
| `domain` | string | `''` | The canonical target, e.g. `https://www.example.com`. Include the scheme; without one it is treated as `http://`. May include a port. |
| `applicability` | int | `0` | `0` = *EXCLUDE_METHOD* (redirect everywhere **except** listed pages); `1` = *INCLUDE_METHOD* (redirect **only** on listed pages). |
| `pages` | string | `''` | Newline-separated paths, wildcard `*` supported; `<front>` for the front page. Matched against the **path alias** of the current request. |

```bash
ddev drush cset domain_301_redirect.settings domain 'https://www.example.com' -y
ddev drush cset domain_301_redirect.settings enabled 1 -y
```

## How the redirect works

`DomainRedirectEventSubscriber::responseHandler()` subscribes to `KernelEvents::RESPONSE`
at **priority 31** (ahead of core 404/redirect handling) and, for every request:

1. Returns early if `enabled` is false, if the user has `bypass domain 301 redirect`, if
   `domain` is empty, or if `checkPath()` says to bypass for this path (per `applicability` +
   `pages`, alias-aware via `path.matcher` + `path_alias.manager`).
2. Parses `domain` into scheme/host/port. If the request's host **or** scheme differs from the
   configured domain, returns `new TrustedRedirectResponse($domain . $requestUri, 301)` with
   header `X-Redirect-ID: 0` (used by the Redirect module / Varnish). Path and query are
   preserved because the raw `getRequestUri()` is appended.
3. The response is cached permanently with cache tag `config:domain_301_redirect.settings` and
   contexts `url.path`, `url.site`, `user.permissions`.

## Domain verification (check route + token)

Before enabling, `Domain301RedirectConfigForm::validateForm()` calls
`Domain301RedirectManager::checkDomain($domain)`, which Guzzle-GETs
`<$domain>/domain-301-redirect-check?token=<token>` (retries 3×, 5s apart) and requires HTTP
200. That route (`domain_301_redirect.check`, `/domain-301-redirect-check`) has custom access:
it is allowed only when the `token` query arg equals
`Crypt::hmacBase64('domain_301_redirect_check_domain', Settings::getHashSalt() . privateKey)`
(`Domain301RedirectController::access`). The controller response is a small JSON
`{"enabled": …}` — its purpose is just to confirm the configured domain resolves back to this
same Drupal site (shared hash salt + private key) before you switch redirection on.

Enabling fails with a form error if the domain is not a valid URL (`UrlHelper::isValid`) or the
check request does not return 200.
