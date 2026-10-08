<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Changes the router path of entity-type routes on the fly, so entities can live at custom paths (e.g. `/article/{node}`, `/blog-post/{node}`) without generating individual path-alias entities.
---
Site builders create `path_rewrite` config entities at `/admin/config/search/path/rewrite` (`administer dynamic path rewrites`). A path processor (`PathRewriteProcessor`, both inbound and outbound) consults the `PathRewriteManager` to translate incoming custom paths back to the real system route and to rewrite outgoing URLs to the custom form; results are cached for performance. Rewrites can vary per entity-type bundle, and it works with any entity type route — but tokens are deliberately unsupported to avoid per-request overhead. An autocomplete controller (`/path-rewrite/autocomplete`, same admin permission) helps pick target routes, querying the `router` table with a parameterised, escaped `LIKE`.

This is a routing/developer tool. Both its routes (the config entity collection/forms and the autocomplete) require `administer dynamic path rewrites` (`restrict access: true`); the autocomplete input is `Xss::filter`ed and used with `escapeLike()` in a query builder, so there is no raw SQL concatenation. It is aimed at large sites that want changeable paths without the cost of many alias entities. Setup: add path rewrites mapping entity-type routes to custom base paths.
---
- Serve entities at custom base paths without path aliases.
- Map `/article/{node}` and `/blog-post/{node}` per node bundle.
- Rewrite paths for any entity type route.
- Vary rewritten paths per entity-type bundle.
- Rewrite inbound requests back to the real system route.
- Rewrite outbound URLs to the custom path form.
- Cache rewrites to keep subsequent requests fast.
- Avoid creating thousands of alias entities on large sites.
- Manage rewrites at `/admin/config/search/path/rewrite`.
- Restrict management with `administer dynamic path rewrites`.
- Use the autocomplete to find target router paths.
- Change an entity type's public path without content changes.
- Apply consistent URL patterns across a content type.
- Keep URLs editable centrally via config entities.
- Skip tokens intentionally to avoid runtime overhead.
- Combine with core routing for custom entity URLs.
- Export path rewrites as configuration.
- Provide cleaner URLs for custom entity types.
- Replace verbose system paths with friendly ones.