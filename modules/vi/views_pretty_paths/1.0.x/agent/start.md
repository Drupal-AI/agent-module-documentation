<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Pretty Path (views_pretty_paths) — agent index

**Rewrites Views exposed-filter query strings into clean SEO-friendly path segments (both inbound and outbound).**

- **Version:** 1.0.x  (info.yml `1.0.3`)
- **Core:** ^8 || ^9 || ^10 || ^11  •  **Depends on:** redirect, views, path_alias
- **Admin form:** route `views_pretty_paths.views_pretty_paths_admin_form` → `/admin/config/views-pretty-path` (`_permission: access administration pages`)
- **Path processor:** `ViewsPrettyPathProcessor` (inbound + outbound, priority -10000) — `src/PathProcessor/`
- **Filter handlers** (service tag `views_pretty_paths_filter_handler`): Text, Bundle, Date, Taxonomy — `src/FilterHandlers/`; extend via `ViewsPrettyPathFilterHandlerInterface` + `AbstractFilterHandler`
- **Decorator:** `RedirectRequestSubscriberDecorator` decorates `redirect.request_subscriber`
- **Config:** `views_pretty_paths.config` (`paths`, `views_filter_name_map`, `filter_subpath`)

**Security:** The only route is the admin config form, gated by *access administration pages*. Inbound URL segments (unauthenticated) are used only as bound values: the Taxonomy handler queries `taxonomy_term_field_data` with the query builder — `->condition('t.vid', $vid)` and `->condition('name', escapeLike($decoded), 'LIKE')` — with no SQL string concatenation, so no injection. Extracted segments are injected into `request->query` (not executed). Redirects use `TrustedRedirectResponse` built from configured aliases + site base URL (not from free-form user input). No mutating public endpoints.

See [configure/paths.md](configure/paths.md) and [extend/filter-handlers.md](extend/filter-handlers.md)
