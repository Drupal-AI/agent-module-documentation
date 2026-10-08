<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Protects faceted search pages from crawler abuse by appending a short-lived token to facet links and serving a lightweight blocking page (HTTP 410) when a facet request arrives without a valid token.

---

Facets Protection is a small, dependency-light add-on to the Facets module aimed at the specific load problem caused by bots (increasingly AI crawlers) that walk through previously cached faceted URLs and trigger expensive filtered queries. It works by attaching a rotating, time-limited token to facet links: a `KernelEvents::REQUEST` subscriber (`FacetsProtectionRequestSubscriber`) inspects every incoming request, and when it sees a facet query parameter (`f`) without a valid `_fp` token it short-circuits the request and returns a minimal blocking page with status 410 ("Gone") instead of running the facet query. The token is a single site-wide value stored in Drupal `State`, regenerated after a configurable TTL (default 1800 seconds) with the current and previous token both accepted, so links stay clickable across one rotation. A JavaScript behavior rewrites facet widget links on facet blocks so real, JS-capable visitors carry the current token automatically, and `hook_preprocess_block()` injects that token into `drupalSettings` for facet blocks. The module ships two blocking-page templates — a plain "URL changed" page that reveals the corrected link after 2.5 seconds, and an "Are you human?" CAPTCHA-style page that forwards after a click — both overridable in a custom theme. A settings form (`/admin/config/search/facets/facets_protection`, permission `administer facets_protection settings`) exposes the enable toggle, the token TTL, and the template choice. The maintainers are explicit about scope: this protects against bots replaying cached URLs, not bots that crawl in real time, and is intended as interim protection until facets can be migrated to Facets 3 exposed filters.

---

- Reduce server load caused by bots hammering faceted Views through cached facet URLs.
- Add short-lived token protection to existing facets without rebuilding them as Views exposed filters.
- Serve a lightweight HTTP 410 blocking page instead of executing an expensive filtered query for untokened facet requests.
- Gate faceted-search traffic that lacks a valid, time-limited `_fp` token.
- Keep faceted browsing working for real, JavaScript-capable visitors while deflecting simple crawlers.
- Let visitors reach the intended results via the "URL changed" page that reveals the corrected link after 2.5 seconds.
- Present an "Are you human?" click-to-continue page as an alternative blocking template.
- Configure how long a facet token stays valid (TTL) to balance protection against normal browsing rhythm.
- Enable or disable the whole protection from one settings toggle without uninstalling the module.
- Choose between the two shipped blocking templates from the settings form.
- Override the blocking pages' markup by copying the templates into a custom theme.
- Automatically append the current token to facet widget links via the module's JS behavior.
- Rotate the protection token on a schedule (current + previous both honored) so links survive one rotation window.
- Interim-protect a site's facets until a planned migration to Facets 3 and Views exposed filters.
- Restrict who can change the protection settings via the `administer facets_protection settings` permission.
- Combine with other anti-bot measures (e.g. a WAF or Facet Bot Blocker) as one layer of defense.
- Signal search engines not to index blocking pages (templates carry `noindex, nofollow`).
- Clean up its state token and cache tags automatically on uninstall.
- Protect facet blocks provided by the Facets module across all URLs carrying facet query parameters.
- Give budget- or time-constrained teams a stop-gap against facet-crawler performance incidents.
