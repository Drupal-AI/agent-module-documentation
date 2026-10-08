Renders an Algolia InstantSearch.js search UI (search box, live results, optional pagination) as a Drupal block, driven by settings stored in Drupal State.

---

Algolia Search Interface is a thin front-end integration with the Algolia hosted-search service. It does not crawl or index anything itself — indexing is expected to be handled separately (for example by the search_api_algolia module) so that an Algolia index already exists. This module only builds the client-side search experience: an admin form at `/admin/algolia/configurations` captures the index name, Algolia Application ID, API key, a Mustache/Hogan hit template, and a pagination toggle. Those values are saved in Drupal State and attached to `drupalSettings` on every HTML page. A placeable "Instant Search Block" attaches the `algolia_search_interface/algolia-javascript` library, which loads the Algolia and InstantSearch CDN assets and wires a search box, a hits widget (rendering each result through the configured template), and — when enabled — a pagination widget. Because the search client runs entirely in the browser, use the Algolia Search-only (public) API key for the API key field, not a write/admin key. The look and behaviour can be extended by overriding the library or the `instantsearchblock` template.

---

- Add an as-you-type Algolia search box to a Drupal site without writing JavaScript.
- Surface an existing Algolia index (populated by search_api_algolia or another pipeline) in the site UI.
- Place a live-results search block in a region (header, sidebar, dedicated search page) via Block layout.
- Render each Algolia hit with a custom HTML template using `{{attribute}}` placeholders (e.g. `{{name}}`, `{{image}}`, `{{price}}`).
- Highlight matched terms in results using Algolia's `{{#helpers.highlight}}` template helper.
- Toggle result pagination on or off from the settings form (page size is controlled in the Algolia dashboard).
- Point the search UI at a specific Algolia index by name from the admin form.
- Switch Algolia applications/indexes by editing the App ID, API key and index name in one place.
- Rapidly prototype a hosted-search front end during an Algolia 14-day trial.
- Provide instant search for product catalogues, article archives, or documentation indexed in Algolia.
- Ship an Algolia search experience that works for anonymous visitors (settings are attached to all pages).
- Style results with the bundled Algolia InstantSearch theme CSS (loaded from CDN) out of the box.
- Override `templates/instantsearchblock.html.twig` in a theme to change the search box / hits / pagination markup and IDs.
- Override or extend the `algolia-javascript` library to add InstantSearch widgets (refinement lists, sorting, stats) beyond the built-in three.
- Move Algolia credentials between environments by exporting/setting the `algolia_settings` State value rather than config.
- Keep search rendering separate from indexing so the two concerns can be maintained independently.
- Give editors a configurable hit template without needing a code deployment for markup tweaks.
- Serve search results directly from Algolia's edge, offloading query load from the Drupal/back-end stack.
