AJAX Placeholder provides an `ajax_placeholder` render element that shows a lightweight placeholder on first render and then replaces itself with real content fetched over a follow-up AJAX request.

---

The module is a developer building block, not a configurable feature. You add an element of `'#type' => 'ajax_placeholder'` with a `'#callback'` (a `service_id:method` or `Class::method` string, plus an argument array) anywhere in a render array. During the initial page render, `AjaxPlaceholder::preRender()` stashes the callback and current request URI in a shared tempstore under an MD5 hash of the callback and emits only a small `container` (with optional `#markup`, defaulting to `Loading...`) carrying a `data-hash` attribute and the `ajax_placeholder/ajax` library. The bundled behaviour (`js/ajax-placeholder.js`) then requests `/ajax/placeholder/{hash}`; the controller `AjaxPlaceholderBuilder::ajaxCallback()` looks the hash up, re-checks access to the original page URL, invokes the stored callback via `DoTrustedCallbackTrait::doTrustedCallback()`, and returns an `AjaxResponse` with a `ReplaceCommand` that swaps the placeholder for the rendered result. Because the expensive fragment is excluded from the cached HTML, this improves cacheability and perceived performance, and (unlike BigPipe) the fragment requests load asynchronously in parallel — useful when a page has many independent, hard-to-cache pieces. No config, no permissions of its own (the route uses core's `access content`), no schema, and no submodules.

---

- Defer an expensive dashboard widget (aggregated stats, external API call) so it loads after the main page paints.
- Make a heavily personalized block cacheable by rendering a placeholder in the cached page and pulling the per-user content over AJAX.
- Replace a custom lazy-builder that blocks the initial render with an async placeholder that loads in parallel.
- Load a "recommended for you" / personalization strip after the page is interactive.
- Defer rendering of a slow third-party embed (maps, charts, feeds) until after first paint.
- Show a `Loading...` (or custom `#markup`) skeleton in place of content that takes time to compute.
- Load "current user" fragments (cart summary, notification count) on an otherwise anonymously-cached page.
- Split a dashboard of many independent panels into several parallel AJAX fetches instead of one long render.
- Defer content whose cache metadata (cache tags/contexts) would otherwise poison the page cache.
- Render a placeholder for a Views block that is expensive to build on every request.
- Provide a progressive-enhancement fallback: show `#markup` for no-JS clients, real content for JS clients.
- Load below-the-fold report tables only when the surrounding page is already served.
- Wrap a callback that returns a fully-built render array so it is themed exactly as if rendered inline.
- Pass fixed arguments (entity IDs, a date range) into the deferred callback via the `#callback` array.
- Use a controller definition string (`\Drupal\my\Controller::method`) or a service method (`my.service:method`) as the callback target.
- Improve Core Web Vitals by moving costly server-side rendering off the critical path.
- Build admin overviews where each metric loads independently and failures stay isolated to one panel.
- Reduce time-to-first-byte on pages that otherwise wait on many synchronous render callbacks.
- Combine with block/page caching so the shell is fully cached while dynamic islands hydrate over AJAX.
- Prototype async content loading without writing any custom JavaScript or routing.
- Defer content that depends on request state resolved later (geolocation, A/B assignment) into the AJAX step.
