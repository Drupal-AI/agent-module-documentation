<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Site Integrator integrates an external site into Drupal.

---

Site Integrator **integrates an external site into Drupal** — surfacing or embedding an external site's content
within the Drupal site (e.g. proxying/embedding pages). It provides its own permissions, in the Services package.

Use it to bring an external site's content into Drupal. It is an integration feature with security considerations:
if it fetches/proxies the external site server-side, treat it like a proxy (confirm the target host is trusted;
constrain what can be requested to avoid SSRF), and if it embeds via iframe, be aware of third-party-content
implications; if it forwards requests/cookies, avoid leaking session data. It has no access-control role beyond its
permission. Configure the external-site integration.

---

- Integrate an external site.
- Surface/embed external content.
- Bring external pages into Drupal.
- Provide its own permissions.
- Serve integration.
- Embed/proxy the external site.
- Treat server-side fetch like a proxy (trusted host, constrain requests - SSRF).
- Be aware of iframe third-party-content implications.
- Avoid leaking session data if forwarding requests/cookies.
- Have no access-control role beyond permission.
- Configure the integration.
- Handle site integration.
- Integrate sites.
- Configure the integration.
- Embed sites.
- Handle the external site.
- Surface content.
- Proxy content.
- Trust the target.
- Provide external-site integration.
