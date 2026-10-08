# Current Page Crumb — agent index

Appends the **current page's title** to the breadcrumb as an **unlinked** last crumb. Pure
code: one tagged service, no config, no `configure` route, no settings form, no permissions,
no Drush, no plugins, no config schema. Dependency-free (core only).

- **How it works, the service, priority, admin/front-page exclusion, fallback title, and how
  to override/disable it** → [api/breadcrumb-builder.md](api/breadcrumb-builder.md)

Key facts:
- Service `current_page_crumb.breadcrumb` = class `Drupal\current_page_crumb\BreadcrumbBuilder`,
  `parent: system.breadcrumb.default`, tag `breadcrumb_builder` **priority `1003`** (outranks
  core's default builder).
- Adds the crumb with `Link::createFromRoute($title, '<none>')` → plain text, not a link.
- Skips admin routes (`_admin_route`) and the front page; falls back to the last URL path
  segment (dashes/underscores → spaces, first letter upper-cased) when the route has no title.
- Breadcrumbs only render where the theme has the **Breadcrumb block** (`system_breadcrumb_block`)
  placed — that is the module's only real prerequisite.
