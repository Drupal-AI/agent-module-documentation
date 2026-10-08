<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTTPS and WWW Redirect issues a 301 redirect on every request so a site is always reached through one canonical scheme (HTTP or HTTPS) and one canonical host (with or without a `www.` prefix), configurable from a single admin settings page.

---

The module registers an event subscriber (`HttpsWwwRedirectSubscriber`) on the kernel request event that runs very early (priority 299, after user authentication). On each request it reads a single config object, `httpswww.settings`, and compares the incoming scheme/host against the desired canonical form: `scheme` can force all traffic to `https` (or leave it `mixed`, i.e. no redirect), and `prefix` can add a `www.` prefix (`yes`), strip an existing `www.` prefix (`no`), or leave it alone (`mixed`). When `prefix` is `yes`, an `exclude_subdomains` list lets specific subdomains (e.g. `api`, `shop`) keep their bare host instead of gaining `www.`. A master `enabled` boolean gates the whole subscriber, and a `bypass httpswww redirect` permission lets trusted users (e.g. site admins testing on a raw IP or internal hostname) skip the redirect entirely so they are never redirected or logged out. All settings are edited through a single settings form at `/admin/config/system/httpswww`, gated by the `administer httpswww` permission; the module ships no config schema and no default config, so `httpswww.settings` holds no values until the form is saved (or the config is set programmatically) and the subscriber is effectively a no-op until `enabled` is turned on.

---

- Force an entire site to be served only over HTTPS by setting `scheme` to `https`.
- Redirect bare-domain traffic to the `www.` subdomain for a single canonical hostname.
- Redirect `www.` traffic down to the bare domain when the bare domain is preferred.
- Consolidate duplicate-content SEO issues caused by a site being reachable at both `http://` and `https://`.
- Consolidate duplicate-content SEO issues caused by a site being reachable at both `example.com` and `www.example.com`.
- Enforce a single canonical URL for search engines to index, improving SEO signal consolidation.
- Exclude specific subdomains (e.g. `api.example.com`, `shop.example.com`) from having `www.` forced onto them while the main site gets it.
- Let a QA or staging environment keep mixed HTTP/HTTPS access while production forces HTTPS.
- Grant the `bypass httpswww redirect` permission to administrators so they aren't logged out or locked out while testing redirect changes.
- Grant `administer httpswww` only to trusted roles since misconfiguration can make the site briefly inaccessible or degrade SEO.
- Migrate a long-running HTTP-only site to HTTPS after installing an SSL certificate, without writing custom redirect code.
- Undo an accidental `www.` prefix policy by switching `prefix` back to `mixed` (no redirect).
- Configure the redirect declaratively via `drush config:set httpswww.settings` in a deployment pipeline instead of clicking through the UI.
- Read back the current redirect policy on a live site via `drush config:get httpswww.settings` for auditing or debugging.
- Avoid writing a custom `hook_kernel_request`/event subscriber just to normalize scheme and host.
- Provide a lightweight, dependency-free alternative to a full redirect module when only scheme/www normalization is needed.
- Ensure canonical URLs are consistent before submitting a sitemap or configuring canonical link tags.
- Protect SEO ranking by avoiding scheme/host splits that dilute inbound link equity across `http`/`https` or `www`/non-`www` variants.
- Standardize on one canonical host across a multisite or multi-domain setup, subdomain by subdomain, using `exclude_subdomains`.
- Prevent mixed-content warnings by redirecting all HTTP traffic to HTTPS at the earliest point in the request lifecycle.
- Apply the redirect before most of Drupal's kernel processing runs, minimizing wasted work on requests that will be redirected anyway.
- Quickly toggle the whole feature off (`enabled = false`) during an incident without deleting the configured scheme/prefix choices.
- Test a fresh HTTPS certificate rollout by leaving `scheme` at `mixed` until the certificate is verified, then switching to `https`.
- Redirect legacy bookmarked `http://www.` links to the new canonical `https://` non-www host in one config change.
- Support compliance requirements that mandate HTTPS-only access to a public-facing site.
- Give a site owner a simple settings form for scheme/host canonicalization instead of editing `.htaccess` or web server rewrite rules.
