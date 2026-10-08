<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Caps how many facet filters a visitor can have active at once in Search API faceted search, per-facet opt-in, showing a message instead of an error once the limit is reached.

---

Facets Max Facets adds one Facets `build`-stage processor (`respect_global_max_facets`) and a small settings form
at `/admin/config/search/facets/max-facets`. You set a site-wide maximum number of active facets and a message,
then tick **"Respect global max facets"** on each facet you want the cap to cover. Once a request already carries
that many active facet selections (the `?f[]` query parameters), the processor stops offering new facet options —
it keeps only the branches that lead to already-active selections so visitors can still remove filters — and shows
the configured warning message once per page. Setting the maximum to `0` disables the limit entirely. It depends
on the Facets module and lives in the Search package; it changes only which facet options are displayed and has no
access-control role — search results still follow the underlying index's access. Its stated purpose is to blunt
bots that select huge numbers of facets (creating expensive deep queries and bloated URLs) while letting real
visitors keep a normal, error-free page rather than the 410/403 that heavier tools like Facet Bot Blocker return.

---

- Cap the total number of facet filters a visitor can apply at once across a search page.
- Blunt bots that select an enormous number of facets to generate expensive, deeply filtered queries.
- Keep facet URLs and query strings manageable by limiting simultaneous active facets.
- Show a friendly warning message instead of a 410/403 error when the cap is hit.
- Let visitors keep browsing and remove existing filters even after reaching the maximum.
- Opt individual facets into the cap with the per-facet "Respect global max facets" checkbox.
- Leave un-enrolled facets completely unaffected by the global limit.
- Configure the site-wide maximum active-facet count on a single settings form.
- Customize the limit message shown to visitors, with a `:max-count` placeholder for the configured maximum.
- Disable the cap entirely by setting the maximum to `0` without uninstalling the module.
- Reduce server load from deeply nested faceted queries triggered by crawlers.
- Protect faceted-search performance on large Search API indexes.
- Pair with Facet Bot Blocker (set to max + 1) so bots pushing extra facets via URL still get "not allowed".
- Provide a softer, non-erroring alternative to Facet Bot Blocker for click-happy human users.
- Preserve active facet branches so the "remove filter" links keep working past the limit.
- Apply the cap at the Facets build stage (weight 100) so it runs late in facet result processing.
- Keep counting from the request's `?f[]` parameters so the limit reflects what the visitor actually selected.
- Enforce a consistent maximum-facet policy across multiple facets on the same search page.
- Manage everything from Drupal admin without writing custom code.
- Give site builders a lightweight guardrail on faceted search abuse.
