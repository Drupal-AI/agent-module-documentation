Menu Trail By Path sets the active-trail (and expands the corresponding menu items) based on the current URL's path structure, so pages that aren't in the menu still highlight the right parent.

---

By default Drupal only marks a menu item as active if a menu link points directly at the current page, which breaks navigation highlighting for the many pages you deliberately keep out of the menu (hundreds of blog articles, taxonomy pages, referenced nodes, etc.). Menu Trail By Path decorates core's `menu.active_trail` service and instead walks the current path — for `/blog/category1/article1` it looks for menu links at `blog`, `blog/category1`, and `blog/category1/article1` and applies the active-trail class to whichever exist, expanding the menu accordingly. It works purely from the URL, so it pairs naturally with Pathauto's path-structured aliases. Behavior is configurable globally at Admin → Configuration → System → Menu Trail By Path: a **trail source** (By Path, Drupal Core Behavior, or Disabled) and a **maximum path parts** depth limit to bound the performance cost of resolving deep paths. The trail source can additionally be overridden per menu via third-party settings added to the menu edit form, letting you enable path-based trails only on the main menu while leaving footer or special menus on core behavior or disabled. All settings are stored as config schema and export/deploy like normal configuration. The module has no dependencies and defines no permissions of its own (the settings page uses the core "administer site configuration" permission).

---

- Highlight the correct parent menu item on a blog article that isn't in the menu.
- Expand a multi-level menu based on the current URL path.
- Set the active trail for taxonomy term pages without menu links.
- Keep navigation highlighting correct for hundreds of nodes not added to the menu.
- Pair with Pathauto so path aliases drive the menu trail automatically.
- Show the right active section for View pages that live under a menu path.
- Limit trail resolution depth with a maximum-path-parts setting for performance.
- Choose By Path behavior globally across all menus.
- Fall back to Drupal core active-trail behavior when preferred.
- Disable active trail entirely for a footer or utility menu.
- Override the trail source per menu from the menu edit form.
- Enable path-based trails only on the main navigation menu.
- Make breadcrumb-adjacent highlighting consistent with the URL hierarchy.
- Avoid bloating the menu with every piece of content just to get highlighting.
- Correctly highlight referenced-node pages under their section.
- Provide predictable active states on decoupled-friendly path structures.
- Keep active trail working across languages via the language-aware service.
- Reduce editorial overhead of maintaining large menus.
- Give product/catalog pages the right active section from their URL.
- Highlight a landing page's children even when only the landing page is in the menu.
- Tune performance by restricting which menus use path resolution.
- Ensure event or news detail pages light up their parent listing.
- Support deep hierarchical URLs like /docs/section/topic/page.
- Improve UX by always showing users where they are in the site structure.
- Deploy the trail configuration between environments as exported config.
