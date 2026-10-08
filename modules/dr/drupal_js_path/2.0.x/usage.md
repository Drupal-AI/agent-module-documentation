<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drupal Path in JS exposes Drupal's route-to-URL resolution to client-side JavaScript through two global helpers, `Drupal.alias()` and `Drupal.path()`.

---

The module lets front-end code turn a route machine name (plus optional route parameters and URL options) into a real URL at runtime, instead of hard-coding paths in JavaScript files. It registers two POST endpoints (`/find/alias/{route}` and `/find/path/{route}`) backed by a small controller that uses core's route provider and URL generator, and it attaches a library on every page that defines `Drupal.alias(route, params, options)` (returns the generated, alias-aware URL) and `Drupal.path(route, params, options)` (returns the internal system path, e.g. `/node/1`). Both helpers perform a synchronous jQuery AJAX POST and return the decoded JSON `{ path: ... }` (or `{ message, path: null }` when the route cannot be resolved). There is no settings form, no configuration, and no dependency beyond Drupal core. It is aimed at module/theme developers who want AJAX callbacks and generated links to survive path or alias changes without editing JS.

---

- Resolve a Drupal route to its aliased URL from JavaScript with `Drupal.alias('entity.node.canonical', {node: 1})`.
- Resolve a Drupal route to its internal system path with `Drupal.path('entity.node.canonical', {node: 1})` (returns `/node/1`).
- Build AJAX request URLs in custom JS from a stable route name instead of a hard-coded path string.
- Keep front-end links working after an editor changes a node's URL alias, since the alias is generated server-side on each call.
- Point a custom widget's "load more" / autocomplete request at a controller route by name rather than by literal URL.
- Generate a URL that includes route parameters, e.g. `Drupal.alias('entity.user.canonical', {user: 5})`.
- Append query string or fragment options to a generated URL by passing route options, e.g. `Drupal.alias('view.frontpage.page_1', {}, {query: {page: 2}})`.
- Avoid duplicating path definitions across `drupalSettings`, Twig, and JS by resolving them on demand.
- Let a decoupled/progressive-JS component ask the server for the canonical path of a route it only knows by name.
- Produce an absolute URL from JS by passing `{absolute: true}` in the options argument.
- Retrieve the internal path for a view page to drive a client-side redirect (`window.location = Drupal.path(...).path`).
- Wire a theme's JavaScript navigation to core/contrib routes without maintaining a path map.
- Detect a resolution failure client-side: when the route is unknown the response carries a `message` field and `path: null`, which the helper logs to the console.
- Provide a single, cache-free source of truth for route URLs during rapid development when aliases are still changing.
- Use `core/once` to run the helper wiring exactly once per page (the library depends on `core/drupal`, `core/jquery`, `core/once`).
- Call the endpoints directly (POST `/find/path/{route}` with `params[...]` / `options[...]` body fields) from non-jQuery client code or tests.
- Migrate legacy JS that concatenated hard-coded `/node/...` paths over to route-name resolution incrementally.
