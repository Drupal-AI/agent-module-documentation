Other View filter adds a Views filter — "Other view result" — that filters the current view's rows against the result set of *another* view/display, letting you include only, or (by default) exclude, the IDs that the other view returns.

---

The module registers a single Views filter plugin (`other_views_filter`, class `OtherView` extending core's `InOperator`) and, via `hook_views_data_alter()`, exposes it as an "Other view result" filter on the base/id field of every content-entity table, every Search API index table, and any other base table that declares a base field. In the filter's settings you pick one or more `view:display` combinations whose output should drive the filter; at query time the plugin runs each selected display (respecting that display's own access check via `$view->access()`), collects the value of the base field (e.g. node id) from each result row, and applies an IN / NOT IN condition on the current view. The operator defaults to **"not in"**, so the common use case — showing a general listing that excludes items already shown in a curated/featured display — works out of the box. An "Inherit contextual filter(s)" option passes the parent view's arguments into the selected views so contextual filters carry over. If the selected views return no rows, a NOT IN filter is a no-op (all rows show) while an IN filter forces an empty result (`1 = 2`). Because each selected display is fully executed on every request, the module and its UI warn that using more than one view here, or uncached views, will significantly degrade performance — keep selected views simple and cache aggressively. It has no settings form of its own, no permissions, and no Drush; everything is configured inside the Views UI. Config schema for the filter's options ships in `config/schema/other_view_filter.views.schema.yml`.

---

- Exclude items already shown in a curated/featured block from the main content listing.
- Show a "related content" list that omits the nodes on the current page's promoted view.
- Build an "everything except" listing by NOT-IN filtering against another view.
- Include only rows that also appear in another view (set the operator to "in").
- De-duplicate two views that appear together on the same page.
- Exclude editor-picked nodes from an automated "latest content" feed.
- Filter one entity type's view by the results of a view over a different display.
- Filter a Search API index view by the results of another (Search API) view.
- Filter any custom base-table view that exposes a base field.
- Carry the parent view's contextual filter arguments into the referenced view (inherit option).
- Exclude a user's own content from a global listing by referencing a "my content" display.
- Force an empty result when a gating view returns nothing (IN operator).
- Keep a promoted-items region and a general region mutually exclusive automatically.
- Cross-reference two taxonomy-driven listings to show only the overlap.
- Show products not present in a "featured products" view.
- Build a "recently viewed excluded" style listing from another view's output.
- Combine several views' outputs into one exclusion set (at a performance cost).
- Avoid writing a custom Views filter plugin for simple cross-view exclusion.
- Prototype content-relationship filtering without SQL or custom code.
- Respect the referenced display's access control when filtering (its access() is checked).
