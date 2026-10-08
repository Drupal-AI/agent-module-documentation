Decoupled Router exposes a single JSON endpoint, `/router/translate-path`, that a decoupled (headless) front end calls with any front-end URL or path alias and gets back the Drupal entity, its canonical/resolved URLs, redirect information, and (when JSON:API is enabled) the JSON:API individual resource link needed to fetch that entity's data.

---

In a decoupled/headless Drupal site the front end owns the URLs, but it still needs to turn a human path (such as `/blog/hello-world`) into the underlying entity so it can request that entity's data over JSON:API or REST. Decoupled Router solves this by adding a `GET /router/translate-path?path=<path>` route (permission `access content`, `_format: json`) whose controller dispatches a `decoupled_router.translate_path` event; the bundled `RouterPathTranslatorSubscriber` matches the path against the real router, finds the entity behind the matched route, checks `view` access, and returns a JSON document describing it. The response includes the `resolved` URL, an `isExternal`/`isHomePath` pair, an `entity` object (`type`, `bundle`, `id`, `uuid`, and `label` when visible), and, if JSON:API is installed, a `jsonapi` block with the `individual` resource URL, `resourceName`, and entry point. A second subscriber (`RedirectPathTranslatorSubscriber`, active only when the Redirect module is present) resolves configured redirects first and reports the redirect chain and final status. Aliases and canonical system paths both resolve to the same entity. A single `decoupled_router.settings` config key, `absolute_resolved_urls`, controls whether resolved/redirect URLs come back absolute or relative. The module invalidates its cached responses automatically when path aliases change, and other modules can enrich the payload through `hook_decoupled_router_info_alter()`. Unresolvable paths return a cacheable `404` with a `message`/`details` body.

---

- Resolve a front-end path alias (e.g. `/about-us`) to the Drupal node, term, or user behind it from a React/Vue/Next.js front end.
- Give a headless front end the JSON:API `individual` URL for an entity so it can fetch that entity's fields without hard-coding resource paths.
- Turn a canonical system path such as `/node/42` into its entity metadata (type, bundle, id, uuid, label).
- Detect and follow editorial redirects (with the Redirect module) so old URLs in a decoupled site still land on the right content.
- Report the redirect status code and target so the front end can issue a proper 301/302 to the browser.
- Determine whether a requested path is the site's configured front page (`isHomePath`) to render a home template.
- Recognize external URLs (`isExternal: true`) and pass them through without a Drupal lookup.
- Enforce content access control at resolve time: unpublished or restricted entities return `403` instead of leaking data.
- Return cacheable `404` responses for unknown paths so a decoupled router can render a not-found page.
- Look up an entity's `uuid` from a human-readable URL, since JSON:API addresses entities by UUID.
- Build language-aware routing: the endpoint resolves per content language and varies its cache by content language.
- Serve absolute resolved URLs for consumption by a separate front-end domain, or relative URLs for same-domain setups (`absolute_resolved_urls`).
- Enrich the resolved payload with extra fields per entity type via `hook_decoupled_router_info_alter()` (e.g. add a description or a computed field).
- Power a universal "path → content" gateway used by Gatsby/Next.js `getStaticPaths`/`getServerSideProps` style data fetching.
- Resolve taxonomy term pages (`/taxonomy/term/5` or their aliases) to term entities for listing pages.
- Resolve user profile paths to user entities in a headless account area.
- Provide a single integration point so the front end never needs to replicate Drupal's alias/redirect logic.
- Keep front-end routing in sync with editorial URL changes because alias inserts/updates/deletes invalidate the cached translations.
- Combine with JSON:API Extras to expose custom resource names while still resolving paths through one endpoint.
- Support multi-consumer setups where several front ends share one canonical path-resolution service.
- Migrate a monolithic Drupal theme to a decoupled front end incrementally by resolving legacy paths to entities.
- Validate that a given editor-entered URL points to real, viewable content before publishing a menu link in a headless CMS.
