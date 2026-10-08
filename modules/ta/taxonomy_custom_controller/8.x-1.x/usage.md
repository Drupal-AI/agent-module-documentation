<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy Custom Controller takes over the taxonomy term page route and dispatches an event while building it, so other modules can change what a term page renders without patching core or overriding the route themselves.

---

The stock term page is a view — `taxonomy_term` — and changing it usually means editing that view, or replacing `entity.taxonomy_term.canonical` in a route subscriber of your own. Both work; both are blunt. This module does the route subscription once (`EventSubscriber/RouteAlterSubscriber`), points the route at `Controller/TaxonomyCustomController`, and fires a `TermPageBuildEvent` that any subscriber can act on. The result is a supported extension point: several modules can contribute to the same term page without fighting over the route.

That makes it useful where term pages need to be more than a listing — a landing page assembled per vocabulary, a term page that mixes a description block with a filtered view, or one that changes shape depending on the term's depth in the hierarchy. It also gives a clean place to hang conditional behaviour that would otherwise end up in a preprocess function.

The trade is that you have moved the term page off Drupal's default path. Anything that assumes the term page is the `taxonomy_term` view — a contextual filter added by another module, a site builder editing the view and wondering why nothing changed — now needs to know this module is in play. Say so in the site's documentation, because the symptom is confusing and there is nothing in the views UI to hint at it.

---

- Alter what a taxonomy term page renders from a module.
- Build a per-vocabulary landing page on the term route.
- Combine a term description with a filtered listing.
- Vary a term page by the term's position in the hierarchy.
- Add a block to term pages without touching the view.
- Let several modules contribute to one term page.
- Replace a preprocess-function hack with an event subscriber.
- Render different content for a specific vocabulary.
- Keep term-page logic in code rather than in a view.
- Provide a custom empty state for terms with no content.
- Add per-term metadata to the page build.
- Redirect or reshape a term page under conditions.
- Extend term pages in a distribution without patching.
- Understand why editing the taxonomy_term view has no effect.
- Document the override so site builders are not surprised.
- Add per-vocabulary behaviour without new bundles.
