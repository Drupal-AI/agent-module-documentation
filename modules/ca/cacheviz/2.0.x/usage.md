Cacheviz is a Drupal 11 developer tool that overlays render-cache metadata (tags, contexts, max-age) onto rendered pages so you can see and debug caching problems visually.

---

Cacheviz decorates Drupal's core `renderer` service to wrap each cacheable render-array element's output in HTML comments containing its final and pre-bubbling cache metadata, and a `ResponseSubscriber` injects page-level cache tags/contexts/max-age (read from the `X-Drupal-Cache-*` headers) into a `drupalSettings` blob plus the module's own CSS/JS. The client-side script (`cacheviz.comments.js` + `cacheviz.js`) parses those comments, computes statistics, detects issues by severity, and renders a floating panel with Overview, Issues and Elements views. It highlights uncacheable elements in red, per-user/session variations in orange, time-limited caches in purple and permanent caches in green, and can trace the "bubble chain" that shows how a `max-age: 0` on a deep child propagates up to make a whole region uncacheable. Everything is gated behind the restricted `view cacheviz debug` permission, a global on/off config flag, and a configurable list of excluded paths (default excludes `/admin`, `/admin/*`, and the login/register/password routes). It ships no database schema, no `.module` hooks, no Drush commands, and no extra module dependencies — only PHP 8.3+ and Drupal core `^11`. It is explicitly a development/staging tool and should not be enabled on production.

---

- Install and enable the module on a dev/staging site, then visit `/admin/config/development/cacheviz` to turn it on.
- Grant the "View Cacheviz debug information" permission to developer roles so they see the visualization.
- Debug why a page is not being cached by spotting the red-highlighted uncacheable (`max-age: 0`) elements.
- Identify which block, field or region set `max-age: 0` directly versus inherited it from a child (Direct vs Bubbled cause labels).
- Use the bubble-chain modal to walk from an uncacheable parent down to the exact child element that is the root cause.
- Find elements that vary per user (`user`, `user.*` contexts) and are therefore cached separately for every account.
- Spot session-based cache variation (`session`, `session.*` contexts) that can explode cache entry counts.
- Detect cookie-based cache contexts (`cookies:*`) that fragment the cache.
- Read the page-level cache summary (max-age, number of contexts, number of tags) in the Overview dashboard.
- See a breakdown bar of how many tracked elements are uncacheable vs time-limited vs permanent.
- Search the Elements view by selector, cache context or cache tag to inspect a specific component.
- Click "Locate" on an issue to scroll to and flash-highlight the offending element in the page.
- Click "Details" to view an element's full pre-bubbling and final cache metadata plus raw JSON.
- Confirm that a caching fix worked by re-loading and checking the element flips from red to green.
- Toggle the panel with `Ctrl+Shift+C` and element highlights with `Ctrl+Shift+H` while browsing.
- Enable "Auto-highlight problems on page load" to have issues highlighted automatically on every page.
- Exclude sensitive or noisy paths (e.g. `/admin/*`, a checkout flow) from visualization via the settings textarea with `*` wildcards.
- Use the exposed `window.cacheviz` console API (`cacheviz.query('context','user')`, `cacheviz.highlight()`) to script investigations from the browser console.
- Teach developers Drupal's cacheability model by letting them see tags/contexts/max-age live on real pages.
- Audit a custom module or theme's render arrays to verify they declare correct cache metadata.
- Compare a component's pre-bubbling versus final cache contexts to see what bubbled up during rendering.
- Quickly triage a "site feels slow / nothing is cached" report by loading the front page and reading the health badge.
