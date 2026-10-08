<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cludo Search embeds the Cludo hosted (SaaS) site-search widget in a Drupal site: it renders a search form and result containers, and Cludo's browser JavaScript does the querying and result rendering client-side.

---

Cludo Search connects a Drupal site to Cludo, a hosted (SaaS) site-search product, as a
**client-side widget**. The module itself makes no server-side calls to Cludo and keeps no local
search index. Instead it renders a search form plus empty result containers, loads Cludo's external
JavaScript bundle in the browser, and passes it two **public** identifiers — the Cludo `customerId`
and `engineId` — via `drupalSettings`. Cludo's script then queries Cludo's API from the visitor's
browser and injects the results into the page. Cludo's own crawler indexes the site behind the
scenes.

Use it when site search is being outsourced to Cludo for its relevance tuning, analytics and
merchandising features rather than run through Search API/Solr locally. Configuration is minimal: a
settings page collects the customer ID, engine ID and the path of the results page, plus a few
display toggles (autocomplete, results count, "did you mean", filters). It provides a placeable
search block and a search page, and a permission to administer the settings. Note that
`customerId`/`engineId` are public widget IDs that appear in page source by design — this module has
**no private API key** to protect. The privacy consideration that does apply is that visitors'
**search terms are sent to Cludo** (from the browser), and search availability depends on Cludo
being reachable. The trade-off versus a local backend is the usual SaaS one: less infrastructure to
run, but a dependency on Cludo's availability and data handling. (Community project; not sponsored or
supported by Cludo.)

---

- Add Cludo hosted search to a Drupal site as a client-side widget.
- Use Cludo's SaaS crawler instead of a local index.
- Let Cludo's browser JavaScript query the Cludo API (no server-side call).
- Render Cludo search results client-side into module-provided containers.
- Configure the public Cludo customer ID and engine ID.
- Set the path of the Cludo results page.
- Understand customerId/engineId are public, not secrets.
- Place a Cludo-backed search block anywhere in the theme.
- Provide a dedicated Cludo search page (default `/csearch`).
- Redirect a block-form query to the search page via a URL fragment.
- Toggle autocomplete, results count, "did you mean", and filters.
- Administer Cludo settings via a dedicated permission.
- Avoid running a local Solr/Search API index.
- Understand query terms are sent to Cludo from the browser.
- Depend on Cludo availability for search to render.
- Outsource site search to Cludo for relevance and analytics.
- Rely on Cludo for merchandising features.
- Replace or complement core search with Cludo.
- Trade search infrastructure for a SaaS dependency.
- Style the Cludo widget with the bundled CSS.
