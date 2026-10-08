Facet Active by Default is a small add-on for the Facets module. It adds one facet processor, "Make first facet active", that automatically selects the first value of a facet when the visitor arrives with no facet chosen, so the listing is never shown unfiltered.

---

The module extends the contrib Facets module (it works only when Facets is installed, even though its info.yml does not formally declare the dependency). It ships a single build-stage processor plugin with the id `make_first_facet_active`. You enable it per facet on the facet's edit form, under the processor / "Facet settings" section, the same place you toggle other facet behaviors such as hiding inactive items or count limits. When the processor runs during a request where none of that facet's results are active, it first replays any enabled sort processors so the "first" value respects the facet's configured ordering, takes the top result, and stashes that result's URL on the request. A response event subscriber then issues an HTTP redirect to that URL, so the user lands on the page with the first facet value already applied. If any value is already active the processor does nothing and returns immediately. To keep the redirect working on every fresh visit, the processor sets the facet's cache max-age to zero, and the module's `hook_block_build_alter()` disables lazy-builder placeholdering for facet blocks that use this processor so the redirect decision is made during the main request rather than in a deferred placeholder render. There is no settings form, no permission, no Drush command, and no configuration schema; the only choice you make is whether the processor is enabled on a given facet.

---

- Force a product-catalog view to always open filtered to the first category rather than showing all products at once.
- Ensure a faceted search page never displays an unfiltered "everything" result set on first load.
- Pre-select the first brand, color, or size facet so shoppers immediately see a narrowed listing.
- Make a documentation or knowledge-base listing default to the first topic facet.
- Default a job board to the first location or department facet when the user has not chosen one.
- Land visitors on the alphabetically or weight-first taxonomy term of a facet automatically.
- Combine with a facet sort processor so the "first" auto-selected value honors your custom ordering (weight, count, display value).
- Auto-apply the top facet value on hierarchical (parent/child) facets, since the processor sorts children too.
- Provide a sensible starting filter for large result sets to reduce initial page weight.
- Give SEO-friendly, always-filtered facet landing URLs because the module redirects to the real facet URL.
- Guarantee a "no empty state" experience where a listing must always show a filtered subset.
- Steer users into a guided browsing flow that begins from one predetermined facet value.
- Default an events listing to the first date-range or event-type facet value.
- Pre-filter a media or asset library to the first file-type or collection facet.
- Ensure a store's clearance or featured facet is the default landing filter.
- Keep a facet block from rendering as an unfiltered placeholder by forcing a real, filtered request.
- Set up demo or client sites where stakeholders should always see filtered example results.
- Reduce "zero interaction" bounce by presenting relevant filtered content immediately.
- Apply a default region/country facet on a multi-region catalog.
- Turn any single facet into an implicit required filter without custom code.
