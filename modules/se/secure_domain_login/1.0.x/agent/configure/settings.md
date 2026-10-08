<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Secure Domain Login

Route `secure_domain_login.config` at `/admin/config/secure-domain-login`, permission `administer secure domain login configuration`.

Single field:
- **WhiteList Domains** (`whitelist_domains`, required textarea) — comma-separated host names permitted to reach `/user` paths, e.g. `admin.example.com,intranet.example.com`. No spaces.

Runtime (`SecureDomainLogin::onRespond`, EventSubscriber/SecureDomainLogin.php:72):
- `whitelist = explode(',', whitelist_domains)`
- if `!in_array($request->getHttpHost(), whitelist)` AND `str_contains($path, '/user')` → `RedirectResponse` to `system.site:page.front`.

Caveats for agents: the host comes from the client Host header (spoofable behind a naive proxy); an empty config yields `['']` so no real host ever matches; `/user` is a substring match. Populate the whitelist before relying on it.
