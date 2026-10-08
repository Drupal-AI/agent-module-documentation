<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sites shield puts an HTTP Basic-Auth gate in front of an entire site, configured per site context through the Sites module.

---

Like the core-adjacent Shield module, it hides a site (typically staging or pre-launch) behind a username/password prompt. A kernel request subscriber (`SitesShieldSubscriber`, priority 33) runs on every main request: it reads the per-site `sites_shield` setting (`user` / hashed `pass`) from `@current_site`, and if a user is configured it demands matching credentials. Credentials are accepted from a custom `sites-shield` header, from `PHP_AUTH_USER`/`PHP_AUTH_PW`, or from `Authorization`/`REDIRECT_HTTP_AUTHORIZATION` base64 values; the password is verified with Drupal's password service (`$this->password->check()`), so the stored value is a hash rather than plaintext. Failing or missing credentials yield a `401` with a `WWW-Authenticate: Basic` challenge. Enforcement is entirely server-side in the request pipeline — there is no client-side bypass.

Two escape hatches exist: the `skip sites_shield auth` permission lets trusted roles through, and a page-cache request policy (`DisallowBasicAuthRequests`) prevents shielded Basic-Auth requests from being served or populated from the page cache. If no username is configured for a site, the shield is inactive for that site. Set it up by enabling Sites, then configuring the `sites_shield` site setting (user + password) for each site you want gated.
---
- Password-protect a staging or pre-launch site
- Gate one site in a Sites multisite while leaving others open
- Prompt for HTTP Basic-Auth credentials before any page loads
- Store the shield password as a hash, not plaintext
- Exempt trusted roles via the `skip sites_shield auth` permission
- Hide a site from search engines and casual visitors
- Return a 401 challenge to unauthenticated visitors
- Authenticate via the custom `sites-shield` header for automation
- Authenticate via standard `PHP_AUTH_USER`/`PHP_AUTH_PW`
- Keep shielded responses out of the page cache
- Disable the shield per site by leaving the username empty
- Protect a client preview environment with shared credentials
- Layer Basic-Auth on top of normal Drupal login
- Apply consistent access gating across environments via config
- Prevent crawlers from indexing an unfinished site
- Provide temporary access to reviewers without Drupal accounts
