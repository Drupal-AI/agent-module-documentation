<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Page Not Found Passthrough lets you specify domains attempted as a fallback to find content when a 404 error is encountered.

---

Page Not Found Passthrough (notfoundpassthrough) handles 404s by trying configured **fallback domains** —
when a page isn't found on your site, it attempts to find the same path on a specified other host and
redirect/serve it, useful during a site migration to a new platform (gradually moving content while old URLs
still resolve). It depends on the Redirect module, is configured at `notfoundpassthrough.settings`, provides
its own permissions, in the Redirect package.

Use it as a migration fallback for old URLs. Security-relevant point: it makes a **server-side request to the
configured fallback host(s)** on a 404 — the fallback host(s) are **admin-configured** (not per-request
user-controlled), so this is not open SSRF, but keep the fallback list to **trusted hosts** and use **HTTPS**;
be aware it forwards the requested path to that host. It has no access-control role beyond its permission.
Configure the fallback domains.

---

- Try fallback domains on a 404.
- Find content on another host.
- Support gradual site migration.
- Depend on the Redirect module.
- Configure at notfoundpassthrough.settings.
- Provide its own permissions.
- Make a server-side request to the fallback host on 404.
- Use admin-configured hosts (not open SSRF).
- Keep the fallback list to trusted hosts.
- Use HTTPS to the fallback.
- Have no access-control role beyond permission.
- Configure the fallback domains.
- Handle 404 fallback.
- Redirect on 404.
- Configure the passthrough.
- Handle old URLs.
- Fall back to another host.
- Configure fallbacks.
- Handle migration URLs.
- Serve fallback content.
