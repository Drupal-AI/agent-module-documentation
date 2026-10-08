Adds the Eulerian analytics JavaScript tag and a configurable datalayer to your Drupal site.

---

Eulerian integrates the Eulerian analytics/marketing platform. On the pages you select it attaches
the `eulerian/init` JS library and a `drupalSettings.eulerian.datalayer` built server-side from your
configuration and the current request, then the init tag pushes that datalayer to Eulerian with
`EA_push()`. You configure it at `/admin/config/system/eulerian` (permission "Administer Eulerian"):
set the Eulerian domain, choose page-visibility rules (every page except a list, only a list, or —
with the PHP module and a restricted permission — pages where a PHP snippet returns TRUE), disable
tracking on 403/404 pages, enable cross-device hashed User ID, unify translation sets, track
internal site search, track Colorbox modals, and add token-based custom parameters (with a
built-in blocklist that rejects personally-identifying tokens). A Views display extender adds
search keys (GET parameters and Search API facets) to the datalayer, and click/link events are
collected client-side from `data-eulerian-*` attributes. The bundled Commerce submodules add cart,
checkout-complete and product datalayers. Like any analytics/tracking integration it has
privacy/consent implications — obtain consent, integrate cookie-consent and disclose the tracking.

---

- Add the Eulerian tracking tag to every page of a site.
- Enter the Eulerian website domain and start collecting analytics.
- Exclude admin, node-edit and user pages from tracking (default listed paths).
- Track only a specific set of pages by path with wildcards.
- Use a PHP snippet to decide tracking visibility per page (experts only).
- Stop tracking on 403 Access Denied pages.
- Stop tracking on 404 Not Found pages.
- Flag error pages to Eulerian with an `error` datalayer key.
- Track logged-in users across devices with a non-PII hashed User ID.
- Record statistics for the originating node of a translation set as one unit.
- Add custom Eulerian parameters to every page using tokens.
- Use node tokens in custom parameters on node pages.
- Block personally-identifying tokens (mail, uid, name, IP, etc.) in custom parameters.
- Clean parameter strings to Eulerian's recommended format before sending.
- Track internal site-search keywords and result counts.
- Report Views/Search API search keys and facets to Eulerian.
- Track content shown in Colorbox modal dialogs.
- Send click, link, download, button and action events from `data-eulerian-*` markup.
- Send Commerce product-page datalayers (product reference and name).
- Send Commerce cart datalayers (products, quantities, amounts).
- Send Commerce checkout-complete datalayers (order reference, total, currency, products).
- Alter the datalayer in JavaScript before it is pushed to Eulerian.
- Load the Eulerian tag asynchronously so it does not block page render.
- Integrate Eulerian Tag Manager.
- Pair with a cookie-consent solution to gate tracking until consent is given.
