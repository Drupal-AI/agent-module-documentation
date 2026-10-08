<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Route Condition provides a single Drupal Condition plugin (id `route`) that evaluates to TRUE or FALSE based on the **name** of the active route, so you can show or hide blocks (and drive any other condition-aware feature) by route name instead of by URL path.

---

The module ships exactly one plugin: `RouteCondition`, a `ConditionPluginBase` with the condition id `route`. It is the route-name analogue of core's "Pages" (`request_path`) condition — instead of matching URL path patterns it matches machine route names such as `entity.node.canonical`, `user.login`, or `system.404`. The condition exposes a single configuration key, `routes`: a textarea of one route name per line. Two operators are supported per line: a `*` wildcard (compiled to a `.*` regex, so `entity.*.canonical` matches every entity's canonical view route) and a leading `~` tilde to exclude/negate a specific route. Matching is case-insensitive (input is lowercased) and the first matching line wins. With no routes entered the condition returns TRUE (matches everywhere). Like all condition plugins it also honors the standard "Negate the condition" checkbox provided by the base class. Because it is an ordinary Condition plugin it appears in the block placement "Visibility" tab and can be consumed by the Context module or any code using the `plugin.manager.condition` service. The current route is read through the injected `current_route_match` service.

---

- Show a block only on entity canonical pages using the wildcard `entity.*.canonical`.
- Hide a block on the user login route `user.login` with a `~user.login` exclusion line.
- Display a promotional block only on the front page route `<front>` / `view.frontpage.page_1`.
- Restrict a "Contact us" block to the `contact.site_page` route.
- Match all node view routes with `entity.node.*` regardless of view mode.
- Target the 403/404 system routes (`system.403`, `system.404`) for a custom help block.
- Show a block on every taxonomy term page via `entity.taxonomy_term.canonical`.
- Combine several route names (one per line) to place a block across a set of admin routes.
- Use `~` exclusions to place a block everywhere except a few specific routes.
- Replace fragile URL-path visibility rules with stable route-name rules that survive alias changes.
- Drive Context module reactions by active route name.
- Gate a block to the search results route `search.view_node_search` only.
- Show a sidebar only on the user profile canonical route `entity.user.canonical`.
- Match all views page displays that share a route-name prefix with a wildcard.
- Restrict a call-to-action block to a webform's canonical route.
- Show editorial help only on node edit routes `entity.node.edit_form`.
- Place a block on all comment reply routes using a wildcard.
- Programmatically evaluate route-based visibility via the `plugin.manager.condition` service with plugin id `route`.
- Store route-based visibility declaratively in a block's exported config (`visibility.route.routes`).
- Keep block placement logic readable by using semantic route names instead of regex path patterns.
- Show a block on the dashboard/admin overview route only.
- Target a single REST or API route by its route name.
- Apply route conditions to blocks placed in any theme region.
- Migrate "Pages"-based visibility to route-based visibility for routes that have no stable path.
