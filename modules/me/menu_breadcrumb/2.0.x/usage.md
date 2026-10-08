Menu Breadcrumb replaces Drupal's default breadcrumb with one built from the menu hierarchy (or taxonomy membership) that the current page belongs to, giving accurate, context-aware breadcrumb trails.

---

Core Drupal derives breadcrumbs from the URL/route path, which often produces sparse or wrong trails for menu-driven sites. Menu Breadcrumb provides a higher-priority `breadcrumb_builder` service that instead walks the active menu trail: for a page placed in a menu it emits the ancestor menu links as the breadcrumb, and it can attach a taxonomy-derived trail for content that is a member of a term whose menu link has "Taxonomy Attachment" enabled. A settings page (`/admin/config/user-interface/menu-breadcrumb`) exposes extensive options: which menus to consider and in what order/weight, whether to append the current page (as plain text or a link), whether to include the taxonomy-membership page, disabling on admin pages, removing or forcing a Home link, choosing the Home title source, excluding empty-URL or disabled menu items, stopping at the first menu match, and per-menu language handling. It relies only on core and its behavior is fully exportable configuration, making it a lightweight, near-universal way to get correct hierarchical breadcrumbs and improve navigation and SEO.

---

- Show breadcrumbs that follow a page's position in the main navigation menu.
- Build trails from a custom menu instead of the URL path.
- Prioritize which menu supplies the breadcrumb when a page is in several.
- Append the current page title to the end of the breadcrumb.
- Make the current-page crumb a plain label rather than a link.
- Add a breadcrumb trail from taxonomy term membership.
- Attach a term's menu trail to nodes tagged with that term.
- Disable menu-based breadcrumbs on admin pages.
- Remove the leading "Home" link from breadcrumbs.
- Force a Home link as the first crumb even when absent from the menu.
- Choose how the Home title is displayed (site name, "Home", etc.).
- Exclude menu items that have no URL from the trail.
- Skip disabled menu items when building the trail.
- Stop the trail at the first matching menu entry.
- Improve SEO with accurate hierarchical breadcrumb markup.
- Give deep content pages meaningful navigation context.
- Handle multilingual sites with per-menu language settings.
- Derive the active trail from the route match for tricky routes.
- Provide consistent breadcrumbs across a large menu-driven site.
- Order multiple menus by weight to control which wins.
- Show the taxonomy-attachment final crumb as a link.
- Replace a theme's weak default breadcrumb without custom code.
- Export breadcrumb behavior as config for deployment.
