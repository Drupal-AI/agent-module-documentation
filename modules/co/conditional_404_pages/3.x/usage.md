<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Conditional 404 Pages lets site builders serve different custom "page not found" pages depending on the requested path, by mapping a core Request Path condition to a referenced node.

---

Drupal core lets you set a single site-wide 404 page (System > Basic site settings, `system.site:page.404`). Conditional 404 Pages replaces that one-size-fits-all behaviour: it adds a `conditional_404_page` config entity where each record references an existing node and a set of path patterns (via core's `request_path` condition plugin — supports `*` wildcards and `<front>`). On any 404, the module's decorator subscriber loads every enabled record, evaluates its path condition against the current request, and if one or more match, serves the highest-weight record's referenced node as the 404 body (still HTTP 404). If nothing matches, it falls back to the core-configured 404 page. Because the target is rendered through a normal internal sub-request, the referenced node's own view access, translation, theme and cache all apply. Records are managed at Administration > Structure > Conditional 404 Page, gated by the "administer conditional 404 page configuration" permission.

---

- Serve a different 404 page for each site section (docs, shop, blog).
- Give a multi-brand site a brand-specific not-found page per URL prefix.
- Map `/brand-a/*` to a Brand A "page not found" node.
- Map `/shop/*` to a store-styled 404 with product suggestions.
- Show a localized 404: the referenced node's translation renders for language-prefixed paths.
- Reference an existing published node as the 404 body instead of hand-coding a route.
- Prioritise overlapping conditions by weight (highest weight wins).
- Keep multiple 404 configurations and enable/disable each independently.
- Fall back to core's `system.site:page.404` when no conditional record matches.
- Use `*` wildcards to cover an entire path subtree.
- Match the front page as a condition via `<front>`.
- Add a marketing 404 for campaign landing-page subtrees.
- Provide a support-desk 404 under `/help/*` linking to contact info.
- Differentiate 404s for authenticated vs. public sections by path.
- Translate one 404 node and reuse it across language paths automatically.
- Keep the 404 status code intact while swapping the rendered content.
- Restrict who can edit 404 mappings to trusted administrators only.
- Preview a mapping by disabling it, then enabling once the node is ready.
- Consolidate per-section 404 handling into config that ships with your site.
- Export the `conditional_404_page.*` config entities between environments.
- Replace custom exception-subscriber code with declarative configuration.
- Delete a mapping through a standard confirm form without touching code.
