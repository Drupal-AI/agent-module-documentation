<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Microsite by Path turns a Domain config entity into a "microsite" served at a sub-path of an existing hostname (e.g. example.com/marketing) instead of at its own domain name.

---

Built on the contrib Domain module, this module lets a Domain record act as a full domain that lives under a base path of a parent domain rather than under a distinct hostname. Each microsite is a normal Domain entity with three extra third-party settings — `is_domain_microsite`, `parent_domain_id` and `base_path` — added through the standard domain add/edit form. On every request `hook_domain_request_alter()` inspects the incoming path, matches it (longest-prefix first) against the base paths of microsites belonging to the current hostname, and, if it finds one that is active (or if the visitor is a domain admin), sets that microsite as the active domain. A registered inbound/outbound path processor (`DomainMicrositePathProcessor`) then removes the base path from the requested path and re-adds it to every generated URL, and a replacement `url.site` cache context keys page caches by domain id so cached markup does not bleed between microsites and the parent. Because the microsite is a real Domain entity, content scoping, per-domain theming, configuration and source URLs are provided by the rest of the Domain ecosystem (Domain Access, Domain Source, Domain Config, Domain Path/domain_path) — this module supplies only the path-based negotiation and URL rewriting. It ships no routes, permissions, Drush commands or config objects of its own. This is the 2.x development branch (no tagged stable release) and the project is seeking a new maintainer.

---

- Serve a marketing or campaign site at `example.com/promo` without registering or configuring a new hostname.
- Give a department, brand or sub-brand its own path-based site (e.g. `example.com/hr`, `example.com/press`) under a shared parent domain.
- Reuse an existing SSL certificate and DNS for many "sites" because they all live under one hostname.
- Combine with Domain Access so nodes assigned to the microsite are viewable only under its base path and 403 on the parent path.
- Combine with Domain Source so a node's canonical/outbound links point at the domain (and base path) it is sourced to.
- Provide per-microsite front pages, menus, blocks and theme settings using Domain Config / core per-domain configuration overrides.
- Run several microsites off the same parent domain, each with a distinct base path, all resolved by longest-prefix matching.
- Prototype or stage a new section of a site behind a sub-path before promoting it to a full domain.
- Present affiliate or partner areas as first-class sites while keeping them on the primary hostname.
- Let editors manage a microsite exactly like any other domain record from `admin/config/domain` (create, edit, disable, delete).
- Temporarily disable a microsite (uncheck its domain status) so anonymous visitors get normal routing while admins can still preview it.
- Keep inbound requests clean: visiting `/promo/about` internally routes to `/about` within the microsite's domain context.
- Keep outbound links correct: links, the site logo and menu items rendered inside a microsite automatically get the base-path prefix.
- Route cross-domain entity links to the right site by honouring `field_domain_access` (all-affiliates) and `field_domain_source` when building outbound URLs.
- Cooperate with domain_path so a node's per-domain path alias is applied when generating links from within a microsite.
- Fix contextual-links caching under microsites (the module rewrites the contextual-links placeholder id to include the base path).
- Migrate legacy configuration automatically via update hook 8105 (old `canonical_hostname` setting converted to `parent_domain_id`).
- Enforce that a microsite cannot be the default domain and cannot itself be a parent of another microsite (form validation).
- Prevent duplicate microsites: validation rejects a second microsite with the same parent domain and base path.
- Present a friendlier domain overview: the admin list shows each record's site URL instead of a raw hostname and hides the "make default" action for microsites.
