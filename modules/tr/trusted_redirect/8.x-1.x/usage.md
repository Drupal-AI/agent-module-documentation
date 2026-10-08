<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Trusted Redirect re-enables redirects to external destinations, restricted to an administrator-maintained allowlist of exact hostnames.

---

Drupal core refuses to send a `RedirectResponse` to an external URL, and that refusal is a security control rather than a limitation. An **open redirect** — an endpoint that will send a visitor anywhere a request parameter names — is what turns a link that genuinely starts on your domain into a phishing vector, and it is a recurring class of advisory across every web framework. Core's position is that internal destinations are safe and external ones must be opted into deliberately. Sometimes the requirement is real: a checkout that hands off to a payment provider, an SSO round trip, a partner handover, a documented deep link into a sister site. This module supplies that deliberate opt-in. `TrustedRedirectSubscriber` is a `KernelEvents::RESPONSE` subscriber registered at priority `1` so it runs **before** core's `RedirectResponseSubscriber`; for any `RedirectResponse` it checks the target host (from the response target URL, the `?destination=` parameter, or the legacy `?trusted_destination=` parameter) against the configured `trusted_hosts` list via `TrustedRedirectHelpersTrait::isTrustedUrl()`, and if it matches it re-wraps the response as a core `TrustedRedirectResponse` so the redirect is permitted. The match is an **exact `in_array($host, $trusted_hosts)` on the parsed host** — no wildcards, no subdomain or suffix matching — so `evil-example.com` does not match `example.com`. The allowlist lives in `trusted_redirect.settings:trusted_hosts` (one host per line, edited at Configuration > Search and metadata > Trusted redirect) and can be extended in code with `hook_trusted_redirect_hosts_alter()`. Version **8.x-1.13** on `^9 || ^10 || ^11`; no dependencies outside core. **The allowlist is the entire security control**, so it deserves the care of a firewall rule: name specific hosts, review it when partners change, and remember that trusting a host means trusting every page on it, including one an attacker may be able to post content to. Two practical wrinkles: once a host is trusted, the external redirect is reachable by **anonymous** visitors via `?destination=`, and the permission's machine name is misspelled — **`admininister trusted redirect configuration`**, with three `in`s — which matters when writing a role's configuration by hand or in a deployment script. The optional `trusted_redirect_entity_edit` submodule is a separate convenience: it adds a `/entity/{uuid}/edit` route (permission `use entity uuid routes`) that looks a content entity up by UUID and redirects to its normal edit form, and a high-priority subscriber that forces that particular redirect to stay internal.

---

- Redirect to a payment provider after checkout.
- Hand off to an external SSO / federated login endpoint.
- Link into a trusted partner's site.
- Allow a documented external destination via `?destination=`.
- Re-enable external redirects that core would otherwise block.
- Configure an allowlist of exact trusted hostnames.
- Support a booking or reservation handover to another domain.
- Redirect after submitting a form that targets an external service.
- Allow a deep link into a synced sister / satellite site.
- Redirect to an external documentation host.
- Restrict redirects strictly to a set of known hosts.
- Support a staged migration to a new domain.
- Redirect to a campaign microsite on another domain.
- Allow an external API callback destination.
- Extend the trusted-host list programmatically with `hook_trusted_redirect_hosts_alter()`.
- Audit which external hosts a site is configured to redirect to.
- Keep the legacy `?trusted_destination=` parameter working after an upgrade.
- Edit any content entity by its UUID instead of its numeric id (submodule).
- Provide a stable edit URL that is identical across synced Drupal instances (submodule).
- Cover redirects issued by the destination parameter, not just handcrafted responses.
