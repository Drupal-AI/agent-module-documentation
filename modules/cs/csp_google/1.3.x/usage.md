<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CSP Google Supported Domains is a helper for the **CSP** (Content-Security-Policy) module that, per CSP directive, appends the country-code Google domains listed at `https://www.google.com/supported_domains` (each as both `domain` and `*.domain`) so Google features loading assets from ccTLDs are not blocked by the policy.

---

The module has no UI or routes of its own. It depends on `drupal/csp` (`^1.31 || ^2.0`) and works entirely by extending CSP's existing settings form and policy-building. `hook_config_schema_info_alter()` adds a `csp_google_add_google_domain_sources` boolean to CSP's `csp_policy` config schema mapping. `hook_form_csp_settings_alter()` injects an **"Add Google supported domains"** checkbox into every directive that has a *sources* option, for both the `report-only` and `enforce` policies, and appends a submit handler that saves each per-directive flag back into `csp.settings`. At install (`hook_install`) the `GoogleSupportedDomainsHelper` service fetches the supported-domains list once over Guzzle and caches it in Drupal **state** under the key `csp_google_supported_domains`. When CSP builds a header, the `CspPolicy` event subscriber listens on `CspEvents::POLICY_ALTER`; for each directive whose stored flag is on, it reads the cached domains via `getSupportedDomains()` (fetching and caching lazily if state is empty) and adds `*.<domain>` and `<domain>` entries to that directive before the header is emitted. `hook_uninstall()` deletes the state key. The list is refreshed only at install or when the state entry is missing — it is not re-fetched on a schedule. Because enabling the option on many directives can add a long list of domains, the combined `Content-Security-Policy` header can grow large enough to trip reverse-proxy / CDN header-size limits (the project README warns of possible 502s).

---

- Allow Google features that serve assets from country-code domains (e.g. `google.de`, `google.co.uk`) through a strict CSP without hand-listing every ccTLD.
- Whitelist Google ad-related resources that load from localized Google domains.
- Keep a CSP policy working with reCAPTCHA / Google widgets that redirect across ccTLDs.
- Add the Google domain set to the `script-src` directive of an enforced policy.
- Add the Google domain set to `img-src` so localized Google images/pixels load.
- Add the domains to `frame-src` for embedded Google iframes served from ccTLDs.
- Add them to `connect-src` for XHR/fetch calls to localized Google endpoints.
- Apply the Google domains only to the `report-only` policy while testing, before enforcing.
- Enable the domains selectively per directive rather than globally, to keep the header small.
- Extend an existing CSP module setup without writing custom `hook_csp_policy_alter()` code.
- Maintain the Google domain list automatically instead of tracking Google's ccTLD changes by hand.
- Cache the fetched domain list in state so runtime CSP building does no outbound HTTP.
- Refresh the cached domain list by re-running the module's install, or by clearing the `csp_google_supported_domains` state key so it re-fetches lazily.
- Combine an enforced CSP with Google Analytics / Tag Manager that pull from localized domains.
- Support Google Maps or other Google embeds that reference regional Google hosts.
- Provide both the wildcard (`*.google.de`) and bare (`google.de`) forms of each domain to a directive.
- Turn the option on for a single sensitive directive to minimize header bloat.
- Roll back cleanly: uninstalling removes the cached state and the config flags stop taking effect.
