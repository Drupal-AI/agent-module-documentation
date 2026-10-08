Current Page Crumb appends the current page's title to the breadcrumb trail as an unlinked final crumb, so the breadcrumb ends with the name of the page you are actually on.

---

The module ships a single service, `current_page_crumb.breadcrumb`, a `BreadcrumbBuilder` class that extends core's `PathBasedBreadcrumbBuilder` and is registered as a `breadcrumb_builder` with a high priority (`1003`) so it outranks the default builder and wins the breadcrumb for ordinary front-end pages. Its `build()` first calls the parent to get the normal path-based trail, then resolves the current route's title via the `titleResolver` and appends it with `Link::createFromRoute($title, '<none>')` — the `<none>` route makes that last crumb plain text, not a link. It deliberately does **nothing** on admin routes (routes whose `_admin_route` option is set) and on the front page, so those trails are left untouched. If the route has no resolvable title it falls back to the last raw path segment, converting dashes/underscores to spaces and upper-casing the first letter. It also adds sensible cacheability: `route`, `url.path` and `languages` cache contexts, a `config:views.view.<id>` cache tag when a `view_id` parameter is present, and any cacheable route parameter as a dependency. There is no configuration, no admin form (`configure` is `null`), no permissions, and no Drush — the only requirement is that the site's **Breadcrumb block** (`system_breadcrumb_block`) is placed in the active theme so breadcrumbs render at all.

---

- End every front-end breadcrumb trail with the name of the current page (e.g. `Home › Blog › My Article Title`).
- Give visitors a clearer sense of "where am I" by showing the current page as the last crumb.
- Show the page title as breadcrumb text even on routes that core's path-based builder would leave title-less.
- Add the current-page crumb without writing a custom `BreadcrumbBuilder` service yourself.
- Keep the last crumb **unlinked** (plain text) so it doesn't look clickable — it uses the `<none>` route.
- Automatically exclude the front page from getting a redundant title crumb.
- Automatically skip all admin pages so the back-office breadcrumb is untouched.
- Provide a fallback crumb label from the URL path when a route exposes no `_title` / `_title_callback`.
- Turn a slug like `annual-report` into a readable `Annual report` crumb when no title is set.
- Improve SEO/navigation UX by surfacing the page name in the breadcrumb component.
- Outrank the default breadcrumb builder site-wide via a single high-priority tagged service.
- Get correct breadcrumb cache invalidation on Views pages (adds the view's config cache tag).
- Preserve entity-driven cache invalidation by adding cacheable route parameters as dependencies.
- Vary the breadcrumb correctly per language (adds the `languages` cache context).
- Standardise breadcrumb behaviour across a multisite by enabling one dependency-free module.
- Complement a theme's placed Breadcrumb block so the trail includes the leaf page.
- Use on documentation or catalog sites where the current article/product name belongs in the trail.
- Add the current-page crumb on taxonomy term, node, and Views listing pages alike.
- Avoid maintaining a menu-based breadcrumb just to show the current page name.
- Drop it into an existing site with zero configuration and immediately see richer breadcrumbs.
- Give editors a breadcrumb that matches the page's `<h1>` title on content pages.
- Keep breadcrumbs working on paths with no menu link by relying on the path-based parent plus the title crumb.
