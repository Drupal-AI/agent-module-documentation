Taxonomy Views Integrator (TVI) lets you replace the default taxonomy term-listing page with a View of your choice, chosen per individual term, per vocabulary, or globally.

---

Since Drupal 8, the taxonomy term page (`/taxonomy/term/{tid}`) is rendered by a core View (`taxonomy_term:page_1`), but core gives no way to point different terms or vocabularies at different Views. TVI fills that gap: it alters the `entity.taxonomy_term.canonical` route to its own controller (via a route subscriber that runs after Views), then a manager service inspects TVI config to decide which View + display to render for the requested term. You assign a View and display on the taxonomy **term edit form** and the **vocabulary edit form** (TVI injects a settings fieldset there), and a **global** default on the settings form at Admin → Configuration → User interface → Taxonomy Views Integrator. Settings are stored as config objects: `tvi.global_settings`, `tvi.taxonomy_term.{tid}`, and `tvi.taxonomy_vocabulary.{vid}`. Resolution follows a precedence order — a per-term override wins, then an inheriting vocabulary/parent-term override, then the global override, then the core default View (unless the default is disabled entirely). TVI passes the term id (and optionally all extra URL arguments) to the chosen View as contextual arguments, and a route enhancer keeps `view_id`/`display_id` correct so modules like Search API and Facets still detect the active View. Permissions are per-vocabulary, letting you delegate who may set the View for a vocabulary or for terms within it.

---

- Show a calendar View on every term page of an "Events" vocabulary while leaving other vocabularies on the default listing.
- Give one specific term (e.g. a featured category) its own custom View while sibling terms use the vocabulary default.
- Set a single global View to render all taxonomy term pages across the site.
- Override the presentation of all terms in one vocabulary without touching individual terms.
- Have child terms inherit a parent term's or vocabulary's View via the "inherit settings" option.
- Disable the default core View entirely so terms fall through to plain taxonomy rendering.
- Use a block-display View (rather than a page display) to render term pages, as the module recommends.
- Change the page title of a term listing by using a page-display View with a custom title.
- Point news, blog, and event vocabularies each at a different View display.
- Pass all trailing URL arguments (after `/taxonomy/term/`) to the View for advanced contextual filtering.
- Pass just the term id and term-id-with-depth to the View for standard depth-aware listings.
- Reuse a clone of the core `taxonomy/term/*` View as a TVI View since the arguments are identical.
- Keep Search API and Facets working on overridden term pages thanks to the route enhancer correcting the active view id.
- Delegate to an editor the right to choose the View for a single vocabulary via the "define view for vocabulary X" permission.
- Delegate the right to set a View on individual terms within a vocabulary via "define view for terms in X".
- Deploy term/vocabulary/global View assignments between environments as exported configuration.
- Restrict who can reach the global TVI settings form with the "administer taxonomy views integrator" permission.
- Automatically clean up TVI settings when a term or vocabulary is deleted (handled by the module's delete hooks).
- Fall back gracefully to the default core term View when a selected View is missing or disabled.
- Provide different displays of the same View (e.g. a grid vs. a list) to different vocabularies.
- Establish a site-wide default term View while still allowing per-term exceptions to override it.
- Render a map or geospatial View on location-tagged term pages instead of a plain node list.
- Swap the term listing for a media grid View on an image-category vocabulary.
