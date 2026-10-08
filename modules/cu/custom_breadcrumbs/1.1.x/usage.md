<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom breadcrumbs lets you define breadcrumb trails as configuration entities — matched either by content-entity type/bundle or by URL path pattern — with each crumb's URL and title built from plain text or Token replacements, plus special tokens for no-link crumbs and taxonomy-term hierarchies.

---

The module registers a high-priority `BreadcrumbBuilder` (service `custom_breadcrumbs.breadcrumb`, priority 1003) that replaces the site breadcrumb when a matching `custom_breadcrumbs` config entity applies. Each entity has a **type**: `1` = content entity (matched by `entityType` + `entityBundle` + `language`) or `2` = path (matched by a `pathPattern`, wildcards allowed, aliases resolved). The trail is defined by two newline-separated textareas, **breadcrumbPaths** and **breadcrumbTitles** (one crumb per line, paired by index); both support Token replacement against the matched entity. Special syntax: `<front>` links to the home page, `<nolink>` renders a crumb with no link, and `<term_hierarchy:field_name>` expands a taxonomy term reference field into its full parent-to-child term hierarchy. A global settings form (`/admin/config/user-interface/custom-breadcrumbs`, route `custom_breadcrumbs.config`, config object `custom_breadcrumbs.settings`) toggles a leading Home crumb (and its label), a trailing current-page crumb (optionally linked), title trimming, disabling on admin pages, and a site-wide mode that applies the builder everywhere. Entities are managed at *Structure → Custom breadcrumbs* (`/admin/structure/custom-breadcrumbs`). The module also exposes a **"Breadcrumbs" pseudo-field** on every entity view display (via `hook_entity_extra_field_info`) so a breadcrumb can be rendered inside a node teaser (e.g. in search results). Requires the Token module; a single permission (`administer custom_breadcrumbs`) gates all of it.

---

- Give all nodes of a content type a fixed breadcrumb trail (e.g. Home › Blog › [node:title]).
- Build breadcrumbs for a URL path pattern like `/products/*` without touching entities.
- Insert a taxonomy category hierarchy into breadcrumbs via `<term_hierarchy:field_tags>`.
- Add a non-clickable section label crumb using `<nolink>`.
- Use Token values (`[node:title]`, `[term:name]`) to make crumb titles dynamic.
- Localize breadcrumbs by defining a separate entity per language.
- Show a "Home" crumb with a custom label ("Start") site-wide.
- Append the current page title as the last crumb, optionally linked.
- Disable custom breadcrumbs on all admin pages while keeping them on the front end.
- Turn on a site-wide breadcrumb that applies to every route.
- Trim long crumb titles to a maximum length with an ellipsis.
- Render breadcrumbs inside a node teaser (search results) using the Breadcrumbs extra field.
- Create breadcrumbs for Views pages or controller routes by matching their path.
- Point a crumb at an internal path (`/about`) or the front page (`<front>`).
- Provide different trails for different bundles of the same entity type.
- Add query-aware caching (e.g. `url.query_args:search`) for search-result breadcrumbs via extra cache contexts.
- Replace the default core breadcrumb on term pages with a hierarchy-aware trail.
- Deploy breadcrumb definitions as configuration across environments.
- Enable/disable an individual breadcrumb definition via its status toggle.
- Build department landing-page breadcrumbs keyed to a path wildcard.
- Combine a static prefix (Home › Docs) with a dynamic entity title crumb.
- Keep breadcrumbs consistent across nodes, Views, and Page Manager pages.
- Use tokens in the path pattern itself to match dynamic routes.
- Give editors a UI (Structure → Custom breadcrumbs) to manage trails without code.
