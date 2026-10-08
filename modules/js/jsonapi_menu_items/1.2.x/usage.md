<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Menu items exposes each Drupal menu's link tree as a JSON:API resource at `/%jsonapi%/menu_items/{menu}`, so a decoupled/headless front-end can fetch a site's navigation menus over the JSON:API.

---

Core's JSON:API does not expose menu **link trees**; this module fills that gap by registering a
dynamic route (via `route_callbacks`) `jsonapi_menu_items.menu` at `/%jsonapi%/menu_items/{menu}`
(e.g. `/jsonapi/menu_items/main`), backed by a `jsonapi_resources` `ResourceBase` resource. It loads
the menu's tree with `menu.link_tree`, keeps only **enabled** links, runs core access + sort
manipulators, and returns each link as a JSON:API resource object whose attributes include
`title`, `url`, `route` (name + parameters), `weight`, `enabled`, `expanded`, `menu_name`,
`parent`, `provider`, `options`, `description`, and `meta` — plus, for `menu_link_content` links,
the entity's own fields. It supports both user-created `menu_link_content` links and, when the
`menu_link_config` module is present, config-defined links; extra fields added by Menu Item Extras
come through too. Requests can be narrowed with query filters: `min_depth`, `max_depth`, `parent`
(a root plugin id), `parents` (comma-separated plugin ids), and arbitrary `conditions[]`. The route
is access-`TRUE` at the router level but each link is still access-checked individually. The module
has no configuration, permissions, schema, services, or Drush commands — it is purely this read-only
resource. An optional submodule, **jsonapi_menu_items_hypermedia**, adds discoverable `menu_items`
links (one per menu) to the `/jsonapi` root document via JSON:API Hypermedia.

---

- Fetch a site's main navigation menu as JSON for a React/Vue/Next decoupled front-end.
- Render a headless site's footer menu from `/jsonapi/menu_items/footer`.
- Build a mobile app's navigation from Drupal-managed menus over JSON:API.
- Retrieve a menu's full link tree (titles, URLs, weights, hierarchy) in one request.
- Get resolved `url` strings for menu links without re-implementing Drupal routing on the client.
- Limit a menu response to the top two levels with `?filter[max_depth]=2`.
- Skip the first level of a menu with `?filter[min_depth]=2`.
- Load only the subtree under a given parent with `?filter[parent]=system.admin`.
- Restrict a tree to specific parents with `?filter[parents]=system.admin,system.admin_structure`.
- Apply a custom query condition, e.g. only system-provided links: `?filter[conditions][provider][value]=system`.
- Expose config-defined menu links (menu_link_config) alongside content menu links.
- Include extra fields on menu links added via Menu Item Extras in the JSON:API output.
- Return only enabled menu links (disabled links are omitted automatically).
- Respect per-link access so unauthorized links don't leak to anonymous clients.
- Get each link's `route` name and parameters to map to client-side routes.
- Read a link's `options` (e.g. attributes, target) for rendering.
- Detect which links are `expanded` to pre-open menu branches in the UI.
- Preserve menu ordering via the module's use of core sort manipulators.
- Combine with JSON:API Hypermedia to make menus discoverable from the `/jsonapi` root.
- Cache menu responses (the resource attaches cacheable metadata and filter cache contexts).
- Serve multilingual menu links (translations resolved from context).
- Power a site-map or breadcrumb component in a headless build.
- Avoid writing a custom controller to output menus as JSON.
- Fetch any menu by its machine name simply by changing the `{menu}` path segment.
