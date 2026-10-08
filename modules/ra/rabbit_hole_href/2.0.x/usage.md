<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Rewrites entity link generation so `toLink()`/`toUrl()` output points at the Rabbit Hole redirect target instead of the entity's own canonical page.

---

The Rabbit Hole module can make an entity's canonical page redirect elsewhere (or return 403/404), but menus, views links and rendered `toLink()` output still generate the entity's own canonical URL — so users click a link only to be bounced by Rabbit Hole afterwards. This module closes that gap by altering the entity type's URI callback so the generated href already resolves to the Rabbit Hole action target.

It implements `hook_entity_type_alter()` to set a custom `uri_callback` (`rabbit_hole_href_redirect_uri`) and removes the `canonical` link template, and `hook_entity_bundle_info_alter()` to apply the callback per bundle. The callback delegates to the `rabbit_hole_href.canonical_link_modifier` service (`CanonicalLinkModifier`), which uses the Rabbit Hole behavior plugin manager to compute the correct URL. In this release the wiring is scoped to the `taxonomy_term` entity type (the code carries `@todo`s to generalise to any Rabbit-Hole-enabled entity type).

Setup is enable-and-go: install alongside `rabbit_hole`, configure Rabbit Hole redirect behaviour on your terms, and links generated for those entities will target the redirect destination directly. There is no settings form or permission of its own.

---

- Make menu links to taxonomy terms point at their Rabbit Hole redirect target
- Generate view/field links that skip the intermediate canonical redirect
- Avoid a visible double navigation (canonical then redirect) for users
- Honour Rabbit Hole page-redirect settings in `toLink()` output
- Rewrite the taxonomy term URI callback to the redirect destination
- Remove the canonical link template for Rabbit-Hole-managed terms
- Delegate URL computation to the Rabbit Hole behavior plugin manager
- Keep breadcrumbs and rendered links consistent with redirect config
- Improve UX for glossary/landing terms that redirect to a real page
- Reduce redirect hops for SEO on term links
- Use the `rabbit_hole_href.canonical_link_modifier` service to resolve a term's target URL programmatically
- Pair with Rabbit Hole's page-redirect action on taxonomy vocabularies
- Serve correct hrefs in navigation blocks referencing terms
- Avoid users landing on a term page that only bounces them onward
- Apply per-bundle link rewriting via bundle info alter
- Deploy where taxonomy terms are used purely as redirects to content
- Keep link output in sync when Rabbit Hole targets change
- Extend (with code) toward other Rabbit-Hole-enabled entity types
