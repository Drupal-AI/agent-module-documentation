Decoupled Kit Block exposes a JSON:API endpoint that returns the blocks (with breadcrumb) that would render for a given front-end path, theme and regions.

---

`decoupled_kit_block` is a submodule of Decoupled Kit that adds one JSON:API resource,
`Drupal\decoupled_kit_block\Resource\Blocks`, on route `decoupled_kit.block` at
`%jsonapi%/decoupled_kit/blocks`. Given a `current_path` (and optional `current_theme` and
`selected_regions` query args) it enumerates the enabled blocks of the theme's visible regions,
filters them through Drupal's block visibility conditions (request-path, user-role and
node-type / entity-bundle:node) as they would evaluate for that page, sorts them by region and
weight, and returns them as a JSON:API collection. Block `visibility` settings are stripped from the
output. For the system breadcrumb block it computes the page's breadcrumb (reusing the base module's
path→route-match resolution and cleaning up the JSON:API breadcrumb artifacts) and includes it in
the block's settings. It also implements `hook_system_breadcrumb_alter` (via
`Drupal\decoupled_kit_block\Resolver\BreadcrumbAlter`) to rebuild breadcrumbs when they were
generated inside a JSON:API request. Requires `decoupled_kit` and core `block`.

---

- Fetch the block layout for a decoupled page: `/jsonapi/decoupled_kit/blocks?current_path=/about`.
- Render a headless page's regions using the same blocks Drupal would place server-side.
- Target a specific theme with `&current_theme=olivero` (defaults to the active theme).
- Limit the response to chosen regions with `&selected_regions=header,content,footer`.
- Reproduce request-path block visibility (`request_path`, with negate and wildcard matching) on the front end.
- Reproduce user-role block visibility so role-restricted blocks are included/excluded correctly for the current user.
- Reproduce node-type / `entity_bundle:node` visibility so per-content-type blocks resolve for the resolved entity.
- Preserve Drupal's block placement order by sorting returned blocks by region then weight.
- Get computed breadcrumb links inside the returned system-breadcrumb block for a headless breadcrumb trail.
- Map the front-page path (`/`) to `<front>` automatically when querying blocks for the home page.
- Drive a universal layout component that reads the returned blocks array and renders each block plugin.
- Combine with the Router endpoint: resolve the page entity, then fetch its block layout.
- Inspect which blocks show on a given page/theme from the Decoupled Kit Dashboard's generated block link.
- Strip block visibility metadata from the payload so the front end receives only render-relevant data.
- Support progressive decoupling where only some regions are rendered by the JS app.
- Build a block-driven navigation/footer in a decoupled front end from live Drupal block config.
- Debug how block conditions evaluate for a specific path/role during front-end development.
