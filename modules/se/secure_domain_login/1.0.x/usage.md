<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Secure Domain Login gates access to the `/user` area by comparing the incoming HTTP host against an admin-defined comma-separated whitelist of domains.
---
The module adds a single kernel `RESPONSE` event subscriber (`SecureDomainLogin::onRespond`). On every response it reads the current path and the request host (`$request->getHttpHost()`), explodes the configured `whitelist_domains` string on commas, and — if the host is NOT in the list AND the path contains the substring `/user` — replaces the response with a redirect to the site front page. Configuration is a single required textarea at `/admin/config/secure-domain-login`, gated by the `administer secure domain login configuration` permission.

Operationally this is a coarse, best-effort guard, not a robust access-control layer. It matches `/user` as a substring anywhere in the path, trusts the client-supplied Host header, only fires at response time, and an empty/misconfigured whitelist (`explode(',', '')` yields `['']`) means every host is treated as un-whitelisted — which can redirect all `/user` traffic, including the login form, to the front page. Treat it as a soft deterrent layered on top of real server/webserver-level host restrictions, and populate the whitelist carefully before relying on it.

The typical setup task: enable the module, visit the config form, and enter the exact host(s) (e.g. `admin.example.com`) that are permitted to reach the login/account pages, comma-separated with no spaces.
---
- Enable the module to restrict `/user` access by request host.
- Open `/admin/config/secure-domain-login` to configure allowed domains.
- Enter a single allowed domain in the whitelist textarea.
- Enter multiple allowed domains as a comma-separated list.
- Restrict site login to a dedicated admin subdomain.
- Redirect account-page hits on the public domain to the front page.
- Grant the `administer secure domain login configuration` permission to a trusted role.
- Review the `whitelist_domains` config value before go-live.
- Combine with webserver host rules for defence in depth.
- Audit that the whitelist is non-empty to avoid locking out login.
- Verify the exact host string matches `getHttpHost()` output (host[:port]).
- Use it to hide `/user/login` from a marketing domain.
- Point non-whitelisted hosts at the configured front page.
- Test each domain by requesting `/user` and confirming the redirect.
- Add a staging host to the whitelist during QA.
- Remove a decommissioned domain from the whitelist.
- Document that Host-header trust makes this a soft control only.
- Layer it with a proper access module for sensitive sites.
- Confirm the config form permission is not granted to untrusted roles.
- Check behaviour under reverse proxies that rewrite the Host header.
