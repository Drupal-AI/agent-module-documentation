TabPanelWidget makes the third-party TabPanelWidget JS/CSS library available in Drupal, rendering title/content pairs as responsive, accessible tabs that collapse to accordions at narrow widths.

---

The base module does not, by itself, add any tabs to a page. It ships the `Tpw` value object (`src/Tpw.php`) plus the `TpwItem` item object (`src/TpwItem.php`), a `tpw` / `tpw_item` theme pair, a site-wide settings form at `/admin/config/content/tabpanelwidget`, and three asset libraries that attach the compiled `tabpanelwidget` library (which must be installed separately under `/libraries/tabpanelwidget`, e.g. via asset-packagist). Other code — most commonly the module's own `tabpanelwidget_views` and `tabpanelwidget_quicktabs` submodules, or your custom code/module — builds a `Tpw`, calls `addItem($title, $content, $default)` for each panel, sets the display options (elements, behavior, tab style, tab/accordion options), and returns `$tpw->build()` as a render array. Behavior is "responsive" by default: it displays as horizontal tabs when they all fit on one row and switches to a stacked accordion otherwise. Tab titles are supplied by the calling code (Views group values, Quick Tabs tab titles, or your own strings) and tab bodies are passed through as normal render arrays, so field/entity access is enforced by whatever produced them.

---

- Turn a set of content sections into responsive tabs that gracefully become an accordion on mobile.
- Provide accessibility-focused tabs (keyboard navigation, ARIA roles handled by the library) for a government or compliance-driven site.
- Group Views results by a field and display each group as its own tab or accordion panel (via the Views submodule).
- Convert an existing Quick Tabs instance's tabs into the TabPanelWidget look and behavior (via the Quick Tabs submodule).
- Force a tabset to always render as horizontal tabs regardless of viewport width.
- Force a tabset to always render as a stacked accordion (e.g. long-form FAQ pages).
- Build an FAQ page where each question is an accordion header and each answer the panel body.
- Present product specifications, shipping, and reviews as separate tabs on a product page.
- Show "Overview / Details / Documents" panels on a landing page from a single custom render array.
- Choose the heading level (`h2`–`h5`) for tab/accordion headers so the tabset nests correctly under existing page headings for accessibility.
- Style tabs as "standard", "fancy", "pills", or "bar" to match a theme.
- Center tabs or give them rounded corners through the tab options checkboxes.
- Render a disconnected accordion (spaced, rounded headers) for a card-like FAQ layout.
- Move accordion expand/collapse icons to the end of headers, or swap chevrons for plus/minus signs.
- Animate accordion expand/collapse icon state changes.
- Mark one panel as the default open tab/section (`addItem(..., TRUE)`), or leave an accordion fully closed on load.
- Serve an optional IE10/11 (ResizeObserver) polyfill site-wide for older-browser support.
- Set site-wide default tab/accordion options once, then override per Views display or per Quick Tabs instance.
- Embed a tabset programmatically from a custom module or controller by constructing `Tpw`, adding items, and returning `build()`.
- Provide a consistent tab/accordion component across an entire site by reusing the shared `Tpw` builder instead of ad-hoc markup.
- Display multi-step or sectioned reference material where readers jump between sections without page reloads.
