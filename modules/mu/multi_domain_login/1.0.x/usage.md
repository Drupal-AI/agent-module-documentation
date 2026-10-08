<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Multi domain login logs a user into every domain of a multi-domain Drupal site with a single login, so someone who signs in on one domain is silently signed in on all the others too.

---

Use it when the same Drupal site is served on several domains — for example one translated domain per language (`www.english.com`, `www.nederlands.nl`, `www.francais.fr`) — and you want a login on one domain to carry over to the rest without the user re-authenticating on each. You list the domains (one per line, with scheme) on a small settings page at `/admin/config/multi_domain_login`. After a normal Drupal login, the module intercepts the post-login redirect and walks the browser through the configured domains in a chain of server redirects: on each domain it presents a signed, short-lived login URL that finalizes a session there, then hands off to the next domain, and finally returns the user to a configured landing path on the domain they started on. The signing mirrors Drupal core's one-time login-link scheme — each hop's URL carries a uid, a timestamp and an HMAC keyed on the site hash salt plus the user's stored password hash, is compared in constant time, and is rejected once the configured **Timeout** (default 30 seconds) elapses, so URLs cannot be forged and expire quickly. A **Force logout** option decides what happens when a different user is already logged in on a target domain (log them out and switch, or leave them). Logging out on any domain deletes that user's session so the sign-out propagates too. Because the flow is a chain of full-page redirects across real domains (not iframes or a shared cookie), every listed domain must serve the same Drupal site and share the same hash salt and user table, and each hop is a visible navigation. Extension points let other modules alter the domain list, the current-domain detection, and each generated hop URL.

---

- Sign a user in on all of a site's domains from a single login form.
- Carry a login across per-language translated domains (`.com` / `.nl` / `.fr`).
- Give a multi-domain site a lightweight single-sign-on experience without an external SSO server.
- Avoid making editors re-log-in on each domain when switching languages to translate content.
- Keep authenticated sessions in sync across affiliate or regional domains of one Drupal install.
- Configure the exact list of domains that participate in the shared login.
- Set how long (seconds) each cross-domain login URL stays valid before it expires.
- Redirect the user to a chosen landing path once the cross-domain login chain completes.
- Force-log-out and replace a different user already signed in on a target domain.
- Leave an already-authenticated session on a target domain untouched (force logout off).
- Propagate a logout on one domain to the user's sessions on the other domains.
- Support multilingual sites by preserving the interface language across the redirect chain.
- Let a custom module add or remove domains at runtime via `hook_multi_domain_login_domains_alter()`.
- Override how the module decides which configured domain the current request belongs to.
- Rewrite each generated per-domain login URL from a custom module before the redirect.
- Enable extra debug logging of each per-domain login/logout step for troubleshooting.
- Diagnose failed cross-domain logins from watchdog entries (expired link, blocked user, invalid hash).
- Provide "log in once, browse every regional storefront signed in" behavior for a brand's domains.
- Keep a staging/preview domain and a production domain logged in together during review.
- Reuse core's proven one-time-login-URL signing for cross-domain authentication rather than sharing cookies.
