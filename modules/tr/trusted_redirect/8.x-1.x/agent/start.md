<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trusted Redirect (trusted_redirect) — agent index

Re-enables **external redirects** that Drupal core blocks, restricted to an admin-maintained
allowlist of **exact hostnames**. Version **8.x-1.13**, core `^9 || ^10 || ^11`, no non-core
dependencies. Ships optional submodule `trusted_redirect_entity_edit`.

## Understand what core does before removing it
Core refuses external `RedirectResponse` destinations *as a security control*. An **open
redirect** — an endpoint that sends visitors anywhere a parameter names — turns a link that
genuinely starts on your domain into a phishing vector. This module is the deliberate opt-in,
not a bug fix.

## Mechanism (read the source, not the guesswork)
- `src/EventSubscriber/TrustedRedirectSubscriber.php` — subscribes to `KernelEvents::RESPONSE`
  at **priority 1**, running *before* core's `RedirectResponseSubscriber`. For any
  `RedirectResponse` it evaluates three destination sources:
  1. legacy `?trusted_destination=` query param — if trusted, `setTargetUrl()` + `stopPropagation()`;
  2. `?destination=` param that is `UrlHelper::isExternal()` and trusted — re-wraps as
     `TrustedRedirectResponse` and swaps it in;
  3. otherwise, any non-`SecuredRedirectResponse` whose current target host is trusted — re-wraps
     as `TrustedRedirectResponse`.
- `src/TrustedRedirectHelpersTrait.php` — `isTrustedUrl($url)` does `parse_url()` then
  **`in_array($host, $trusted_hosts)`**: an *exact* host match. No wildcard, no subdomain/suffix
  logic. `getTrustedHosts()` reads `trusted_redirect.settings:trusted_hosts` and runs it through
  `hook_trusted_redirect_hosts_alter()`.
- `src/Form/ConfigForm.php` — the allowlist editor (textarea, one host per line) at
  `/admin/config/search/trusted_redirect`.

## The allowlist is the entire security control
Treat it like a firewall rule:
- name **specific hosts**, never assume any wildcarding exists (there is none);
- review it when partners change;
- trusting a host means trusting **every page on it**, including one an attacker can post content to;
- once a host is trusted the external redirect is reachable by **anonymous** users via `?destination=`.

## Gotchas
- **Permission machine name is misspelled: `admininister trusted redirect configuration`** (three
  `in`s). Matters when writing role config by hand or in deployment scripts. That single permission
  gates who can create open redirects.
- Config is `trusted_redirect.settings` with one key, `trusted_hosts` (sequence of strings);
  default install value is empty (no host trusted, module is a no-op until configured).

## Detail pages
- `agent/config/allowlist.md` — configuring / deploying the trusted-host list.
- `agent/api/hooks.md` — `hook_trusted_redirect_hosts_alter()`.
- `agent/submodules/entity_edit.md` — the `trusted_redirect_entity_edit` UUID edit-route submodule.

Legitimate cases: payment-provider handover, SSO round trip, partner handover, documented deep
links into a sister / satellite site.
