Decoupled Kit exposes read-only JSON:API resource endpoints that resolve the current front-end path to Drupal objects, blocks and redirects for a headless / decoupled front end.

---

Decoupled Kit is an umbrella module for progressively- or fully-decoupled Drupal sites. Its own `decoupled_kit` module ships a path-resolution service (`Drupal\decoupled_kit\DecoupledKit`) and one JSON:API resource, the **Router** (`%jsonapi%/decoupled_kit/route?current_path=…`), which takes a front-end URL path and returns the individual JSON:API document for the entity that path routes to (node, term, user, media, view result, …), with language-aware translation. A **Dashboard** admin form at `/admin/config/services/decoupled-kit/dashboard` (permission `administer site configuration`) lets you enter a path (and, when the block submodule is on, a theme and regions) and opens each resource endpoint in a new tab for inspection. Two optional submodules extend the kit: `decoupled_kit_block` returns the blocks that would render for a given page/theme/regions, and `decoupled_kit_redirect` returns any Redirect-module redirect matching a path. All resources are built on `jsonapi_resources` (a hard dependency); the endpoints are GET-only and keyed on a `current_path` query-string parameter. There is no field-, view- or content-level configuration beyond the stored default `current_path`.

---

- Resolve a Next.js / Nuxt / other JS front-end route to its backing Drupal entity via one call to `/jsonapi/decoupled_kit/route?current_path=/blog/my-post`.
- Return the full JSON:API individual document (attributes + relationships) for whatever entity a path maps to, without the front end knowing the entity type or UUID in advance.
- Drive a universal catch-all page component in a decoupled front end that fetches the router endpoint, reads the returned `type`, and renders the matching template.
- Get a language-aware entity payload: the router returns the translation for the site's current language when the entity has one.
- Resolve view-page routes (e.g. `/taxonomy/term/1`-style listing pages) to the underlying view display via the router's `view_id` / `display_id` handling.
- Return HTTP 404 (empty JSON:API data) when a path resolves to no entity, so the front end can render its own not-found page.
- Fetch the block layout for a given front-end page with `decoupled_kit_block`: `/jsonapi/decoupled_kit/blocks?current_path=/about&current_theme=olivero`.
- Limit the returned blocks to specific theme regions with `&selected_regions=header,content,footer`.
- Reproduce Drupal's block visibility rules (request-path, user-role, node-type / entity-bundle conditions) on the decoupled side so only blocks that would actually show are returned.
- Get computed breadcrumb links injected into the returned system-breadcrumb block so a headless front end can render a correct breadcrumb trail for the page.
- Sort returned blocks by region and weight to preserve Drupal's placement order in the front end.
- Look up whether a front-end path has a Redirect-module redirect with `decoupled_kit_redirect`: `/jsonapi/decoupled_kit/redirect?current_path=/old-url`.
- Read the redirect's destination plus a `meta.alias` (the path alias of the target) so the front end can issue the correct client-side or SSR redirect.
- Resolve incoming aliased paths to their internal path before redirect lookup, so redirects defined against internal paths still match.
- Preview every kit endpoint for a chosen path from the admin Dashboard form, which builds target-blank links to each enabled resource.
- Save a default `current_path` on the Dashboard so repeated inspections start from the same page.
- Build a decoupled request pipeline: check redirect first, then resolve the object, then fetch the block layout for the resolved page.
- Support progressive decoupling where only some regions/blocks are rendered by a JS app and the rest stay server-rendered.
- Give a headless CMS integration a single, stable contract (path in, JSON out) instead of bespoke controllers per content type.
- Inspect how block visibility conditions evaluate for a specific path/role during front-end debugging.
- Serve as a lightweight alternative to hand-rolling custom JSON:API resource plugins for path-to-entity resolution.
