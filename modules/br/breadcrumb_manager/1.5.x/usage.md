Breadcrumb Manager replaces Drupal's default breadcrumb builder with a path-based one that builds breadcrumbs automatically from the current URL, resolving each path segment's title through a configurable, weighted chain of "title resolver" plugins (menu link title, page title, raw path component).

---

The module registers a `breadcrumb_builder` service (`BreadcrumbManagerBuilder`, priority 9000) that extends core's `PathBasedBreadcrumbBuilder`. For the current path it walks the parent segments, matches each to a route, checks access, and resolves a title for each segment via the enabled title-resolver plugins in weight order — the first non-empty title wins. Shipped resolvers: `menu_link_title` (title from a menu link on that route), `request_title` (the route's page title), and `raw_path_component` (a humanized version of the last path element, used for "fake" segments that have no route). Behavior is controlled from one config form at `/admin/config/user-interface/breadcrumb-manager` (permission `administer breadcrumb manager`): excluded paths (wildcards allowed), whether to show the breadcrumb on the front page, whether to show and relabel a "Home" link, whether to show the current page (and as a link or plain text), whether to include route-less "fake" segments, and the enabled/weight of each resolver (drag-and-drop table). Config lives in `breadcrumb_manager.config`. A `hook_breadcrumb_manager_path_alter()` and a `hook_breadcrumb_manager_fake_segments_alter()` let modules rewrite the path or fake segments; the resolver set is itself a plugin type you can extend. The `breadcrumb_manager_context` submodule adds a resolver that pulls titles from the Context module.

---

- Get automatic path-based breadcrumbs site-wide without configuring each content type.
- Resolve breadcrumb segment titles from menu links when available.
- Fall back to the page/route title when there is no menu link.
- Show humanized breadcrumbs for path segments that have no route ("fake segments").
- Exclude specific paths (e.g. `/user`, `search/*`) from breadcrumb generation using wildcards.
- Choose whether the breadcrumb appears on the front page.
- Add or hide a "Home" link at the start of the breadcrumb.
- Relabel the "Home" link text (e.g. to a site name).
- Show or hide the current page as the last breadcrumb segment.
- Render the last segment as a link or as plain text.
- Reorder the title-resolver priority via a weight table.
- Enable/disable individual title resolvers.
- Rewrite the breadcrumb path before building via `hook_breadcrumb_manager_path_alter()`.
- Map a route-less path segment to a custom title/URL via `hook_breadcrumb_manager_fake_segments_alter()`.
- Add a custom title-resolver plugin (e.g. from a field or taxonomy) for breadcrumb titles.
- Respect route access — segments the user cannot access are skipped.
- Keep breadcrumbs correct on aliased paths (aliases resolved during matching).
- Provide consistent breadcrumbs across a deep content hierarchy defined by URL structure.
- Integrate Context reactions as a title source via the `breadcrumb_manager_context` submodule.
- Cache breadcrumbs per URL/parent path with proper cache tags on the config.
