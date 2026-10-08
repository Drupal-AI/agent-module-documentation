Rabbit Hole controls what happens when a content entity is viewed at its own canonical page — you can show the page, return "access denied" or "page not found", or redirect elsewhere, per entity type, per bundle, or per individual entity.

---

Many entities in Drupal exist only to be referenced (a taxonomy term used for filtering, a media item embedded in an article, a "component" node) yet Drupal still gives each one a full-page canonical URL that visitors and crawlers can land on. Rabbit Hole intercepts requests to those canonical pages and applies a configurable **behavior**: display the page as normal, deliver a 403 Access Denied, deliver a 404 Page Not Found, or issue an HTTP redirect (301/302/303/304/305/307) to any path or URL, with token support in the redirect target. Behaviors are chosen through a "Rabbit Hole settings" vertical tab that the module injects into entity and bundle edit forms, and defaults set on a bundle can optionally be overridden on individual entities. The base `rabbit_hole` module supplies the shared framework — two plugin types (behavior plugins and entity plugins), a settings config entity, a request event subscriber that performs the action, and per-entity-type permissions — while thin submodules (`rh_node`, `rh_media`, `rh_taxonomy`, `rh_user`, and others) register the specific entity types it can act on. It integrates with the Token module so redirect targets can include entity field values, and exposes alter hooks so the computed values and the final response can be changed in code. This makes it a standard tool for hiding "utility" entities, consolidating SEO by redirecting thin pages, and building headless or component-driven sites where most entities should never render standalone.

---

- Return a 404 for taxonomy term pages that only exist to power listings.
- Redirect thin "landing" nodes to a richer campaign page.
- Deny access to media entity canonical pages so files aren't reachable standalone.
- Hide user profile pages by returning access denied on `/user/*`.
- Redirect an entity's own page to the first article that references it.
- Set a site-wide default behavior per bundle, overridable per node.
- Issue a permanent 301 redirect from a retired product page to its replacement.
- Use a temporary 302 redirect during a campaign or A/B test.
- Redirect using tokens, e.g. `[node:field_external_url]`.
- Prevent "component" or "block-like" content types from ever rendering as a page.
- Send commerce product canonical pages to their category or a store page.
- Keep paragraphs library items from being viewed as standalone pages.
- Return "page not found" instead of "access denied" to avoid revealing that content exists.
- Configure a fallback behavior for when a redirect target is empty or invalid.
- Grant editors permission to change Rabbit Hole settings for one entity type only.
- Let trusted roles bypass the Rabbit Hole action and always see the real page.
- Redirect group entity pages to a members dashboard.
- Consolidate duplicate/near-empty pages for SEO by 301-ing them away.
- Configure behavior directly on the bundle (content type) settings form.
- Override the bundle default on a single high-value entity.
- Apply behaviors to file entities via the `rh_file` submodule.
- Redirect to `<front>` for entities that shouldn't have their own page.
- Alter the computed Rabbit Hole values in code with `hook_rabbit_hole_values_alter()`.
- Swap the final redirect response in code with `hook_rabbit_hole_response_alter()`.
- Add Rabbit Hole support to a custom entity type by writing an entity plugin.
- Define a brand-new behavior (beyond redirect/deny/not-found) with a behavior plugin.
- Send crawlers a proper 301 while keeping content editable in the admin.
- Build a decoupled/headless site where canonical pages should not resolve.
