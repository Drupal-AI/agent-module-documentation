Current Route Block provides a single "Current Route Info Block" that prints the active route's name, parameters, path pattern, and HTTP methods on any page where it is placed.

---

The module ships one block plugin (`current_route_block`, admin label "Current Route Info Block", category "Development"). When placed via the block layout it reads Drupal's `current_route_match` service and renders four facts about the page's route as a themed item list: the route name (e.g. `entity.node.canonical`), the JSON-encoded upcast route parameters, the route path pattern (e.g. `/node/{node}`), and the allowed HTTP methods. The block sets `getCacheMaxAge()` to `0` so it is never cached and always reflects the current page. It has no settings form, no permissions, no configuration schema, no routes, and no dependencies beyond Drupal core (`^10 || ^11`, PHP `>=8.1`). It is a lightweight development and debugging aid rather than a production display component.

---

- Show the machine name of the current route on any page during theme or module development.
- Identify which route (`entity.node.canonical`, `view.frontpage.page_1`, etc.) actually renders a given URL.
- Inspect the upcast route parameters for the current page, such as the node or taxonomy term being viewed.
- Read the route path pattern (e.g. `/node/{node}/edit`) to confirm the route definition behind a URL.
- See which HTTP methods a route allows while debugging routing or access issues.
- Confirm that a custom route you defined in a `*.routing.yml` file resolves as expected on the front end.
- Verify block visibility conditions by placing this block in a region and checking the route it reports.
- Teach or demonstrate Drupal's routing system to new developers by exposing route data visually.
- Debug why a page is served by an unexpected controller by revealing the matched route name.
- Check the route context when troubleshooting `current_route_match`-based logic in custom code.
- Diagnose 404/403 pages by reading the route the request resolved to.
- Confirm parameter upcasting is working by viewing the JSON-encoded parameters for entity routes.
- Place the block temporarily in an admin theme region to inspect admin route names.
- Use it as a quick reference when writing route-based access checks or breadcrumb logic.
- Validate multilingual or path-alias behavior by seeing the underlying route path pattern.
- Assist QA in reporting the exact route name associated with a bug on a specific page.
- Support layout builders by revealing the route serving a page they are editing.
- Provide a no-code alternative to `drush` or Webprofiler for a quick route name lookup.
- Verify that a contributed module's routes are registered by browsing to their URLs with the block enabled.
- Remove the block after development by deleting it from the block layout, leaving no residual configuration.
