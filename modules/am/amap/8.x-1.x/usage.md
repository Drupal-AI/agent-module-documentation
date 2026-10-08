aMap places a block that embeds a bundled inline SVG map (the USA) and colors/styles/links its regions from JSON fetched over AJAX from an administrator-configured URL.

---

aMap ("Ajax Map") ships one block plugin, `amap_block`. When placed, the block renders an inline SVG (the module's bundled `svg/usa_oa.svg`) inside a themed wrapper and attaches a small jQuery behavior (`js/amap.js`). That behavior reads the block's configuration from `drupalSettings`, performs a client-side AJAX GET to the configured `svg_url`, and for each JSON object in the response uses configurable field machine names to (a) add a CSS class to the matching SVG element and its `_Label`, (b) set the element's `fill` style, and (c) make the element, its `_Label`, and its `_Text` clickable to navigate to a per-item URL. The SVG element IDs are matched against a value drawn from each JSON row. The module is display-only: it defines no permissions, routes, services, entities, install hooks, or config schema, and depends only on core `node` and `block`. Block configuration is edited by users who can administer blocks, and the JSON endpoint it consumes is chosen by that administrator (commonly a Views REST/JSON export of node/location content).

---

- Add a clickable, data-driven SVG map of the USA as a block.
- Recolor US states/regions based on live JSON data.
- Highlight states that match some status (e.g., published vs. unpublished content).
- Link each state/region to a landing page or node when clicked.
- Drive the map from a Views REST export that returns JSON.
- Show a "coverage" or "where we operate" map on a landing page.
- Display per-region counts or statuses using CSS classes.
- Style regions with a fill color supplied by the data feed.
- Place the map in any block region via Block layout.
- Point the map at different JSON endpoints per block placement.
- Pass current URL path segments through to the AJAX endpoint as filters.
- Forward the current query string (`?...`) to the JSON endpoint.
- Build a state-selector navigation UI from an SVG.
- Reuse the bundled `usa.svg` / `usa_oa.svg` as the base graphic.
- Add CSS (e.g., `.amap-unpublished`) to theme regions by class.
- Show an interactive US map without a third-party mapping service or API key.
- Prototype a choropleth-style map from Drupal content.
- Present editorial content grouped by state.
- Provide a site-builder map block that needs no custom code.
- Support Drupal 10.1+ and Drupal 11.
