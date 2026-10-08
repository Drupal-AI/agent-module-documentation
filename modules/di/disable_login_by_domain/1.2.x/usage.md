<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Disable login by domain turns user login off whenever the site is being served on a hostname you have listed, so one Drupal install answering to several domains can accept logins on some and refuse them on others.

---

The unit of matching is the **request's own hostname** — `Request::getHost()`, i.e. the `Host` / `X-Forwarded-Host` header the current visitor arrived on — not anything about the user's email or account. You maintain a single list of *disallowed* domains at `/admin/config/people/disable-login-by-domain` (one per line; the literal `*` disallows every domain), behind the `administer site configuration` permission. A `HostStatus` service compares the current host against that list by **exact string match** (`in_array`, so `www.example.com` blocks only `www.example.com`, not `example.com` or a subdomain), and when the host is disallowed the module shuts login down at four independent points: a route access check on `user.login` **and** `user.login.http` returns *forbidden* (so both the login page and core's REST/HTTP login route stop responding, and the page is also forbidden to already-authenticated users); `hook_block_access()` forbids the *User login* block, with a Layout Builder event subscriber doing the same for blocks placed through Layout Builder; `hook_form_user_login_form_alter()` strips the name, password and actions elements (and unsets the validate/submit handlers) from any embedded copy of the login form; and, when the optional **"Hijack login attempts"** setting is on (the default), `hook_user_login()` invalidates the session of anyone who nonetheless reaches `user_login_finalize()` on a disallowed host, logging them straight back out. That last catch-all is what covers auth paths the form/route checks do not touch — but the module's own settings form warns you to turn it **off** if you sign users in outside Drupal's login form (e.g. SSO), since it would log those users out too. Because the decision rests on the `Host` header, the module's README stresses configuring Drupal's Trusted Host Settings; it explicitly describes itself as a convenience feature rather than a hardened security control.

---

- Serve one Drupal install under a canonical domain and a legacy domain, and accept logins only on the canonical one.
- Block login on a CDN-fronted public hostname while allowing it on the VPN-only origin hostname.
- Keep the login form off a marketing domain that shares the codebase with the application domain.
- Disallow login on a redirect-only domain kept for old inbound links.
- Force all editor logins through a single hostname behind a VPN.
- Disable login on every domain at once with the `*` wildcard during a lockdown or migration window.
- Remove an unmonitored login endpoint on a legacy host that would otherwise be a quiet credential-stuffing target.
- Prevent logins on an origin hostname so they cannot bypass the CDN's rate limiting and bot protection.
- Turn off the *User login* block automatically on public domains without editing block visibility per theme.
- Keep an embedded login form (placed in a custom block) from working on disallowed domains.
- Disable login on a country-specific domain that should be content-only.
- Keep a preview or staging hostname read-only to anonymous visitors by refusing new logins.
- Support a split public/editorial architecture where authoring happens on a separate hostname.
- Log out anyone who reaches a session via a non-form path on a blocked host (with "Hijack login attempts" enabled).
- Pair with Drupal Trusted Host Settings to constrain which `Host` values are even accepted.
- Disable login on a domain served through a third-party proxy you do not fully trust.
- Enforce a single authentication host as an organizational policy across a multi-domain site.
- Keep the login page returning 403 on public domains rather than exposing a form that will not work.
- Disable the traditional login form on a domain while leaving SSO to handle auth (hijack option off).
- Temporarily disallow all logins ahead of a maintenance deploy without uninstalling authentication.
