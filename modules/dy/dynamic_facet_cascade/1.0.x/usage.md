<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a customizable block with AJAX dependent dropdowns that pre-filter a Search API view through the Facets module.

---

Dynamic Facet Cascade turns a wall of Search API facet options into a guided, step-by-step funnel. You define a "preset" (a config entity) that points at a Search API-backed Views page and lists an ordered chain of cascade levels — each level bound to an existing Facets entity. On the site front end the preset is exposed as a block of dependent AJAX select dropdowns: choosing a value in one dropdown narrows the options in the next (for example Make -> Model -> Version), because each level's options are queried from the taxonomy vocabulary behind the parent's Facets entity via an auto-discovered entity-reference field. A preset can also define one or more tabs, each adding an independent "dominant" dimension (such as Year or Type) that can be shown, pre-selected, or silently applied. On submit the block converts the selections into a Facets-compatible `f[]` URL (as term IDs, names, or slugs) and redirects to the results view. An optional "cascade on existing content only" mode filters each dropdown against the live Search API index so only combinations with published content are offered. The module requires core Views plus the Search API and Facets contrib projects; the 1.0.x series is currently a pre-release alpha.

---

- Give visitors a Make -> Model -> Version style guided search funnel instead of long facet checkbox lists.
- Pre-filter a Search API view before the results page loads, from a block placed above it.
- Chain two or more taxonomy dimensions where each dropdown depends on the previous selection.
- Reuse existing Facets entities for a view without re-declaring vocabularies or fields (all derived at runtime).
- Offer separate search "tabs" (e.g. By Year, By Type) over the same cascade, each with its own dominant dimension.
- Pre-select a default term for a tab's dominant dimension that the user can still override.
- Silently inject a fixed dominant term (hidden dropdown) so a block always scopes to, say, one product line.
- Encode selections in the redirect URL as numeric term IDs (`f[]=brand:42`) for maximum performance.
- Encode selections as raw term names (`f[]=brand:Toyota`) when facets are configured to accept names.
- Encode selections as clean lowercase slugs (`f[]=brand:toyota`) for human-friendly URLs.
- Restrict dropdown options to only terms that have published indexed content (content-based cascade mode).
- Show the full taxonomy hierarchy regardless of content availability (taxonomy-based cascade mode, the default).
- Pre-populate the dropdowns from the current URL when a visitor arrives from an already-faceted results page.
- Automatically reset downstream dropdowns when a parent selection is cleared, avoiding orphaned filters.
- Expose one distinct, labelled block per preset in Block Layout via a plugin deriver.
- Place multiple cascade blocks on different search pages, each driven by its own preset.
- Build a car / vehicle finder (brand, model, trim) over a Search API index.
- Build a real-estate finder (region, city, neighbourhood) or a product catalogue drilldown.
- Deploy presets through configuration management (config import / Features) like any config entity.
- Manage all presets from a single admin listing at Configuration -> Search and Metadata -> Dynamic Facet Cascade.
- Let a "By Type" tab automatically restrict cascade options to items matching a selected type, with no extra configuration.
