Admin Toolbar Extra Tools adds a set of one-click administrative action links — flush caches, run cron, run updates, logout, and shortcuts to add content/bundles — under the Drupal icon in the Admin Toolbar.

---

This submodule of Admin Toolbar enriches the toolbar's Drupal-icon menu with practical action links that site builders reach for constantly. It exposes granular cache-flushing operations (all caches, CSS/JS, plugins, static caches, menus, render cache, views, Twig, theme rebuild) as CSRF-protected routes, plus a Run cron link and quick links to add content, create new bundles, manage fields, and log out. Extra links are generated dynamically with a menu-link derivative plugin (`ExtraLinks`), so the menu reflects the entity types and bundles actually present on the site. A settings form controls how many bundles per entity type are listed (to keep the menu manageable) and whether local tasks are shown in the toolbar. Because the flush routes are real URLs guarded by the `administer site configuration` permission and a CSRF token, they can be bookmarked or triggered directly. It requires the base Admin Toolbar module. It is what most people actually mean when they say "the admin toolbar with the flush cache button."

---

- Flush all Drupal caches with one click from the toolbar.
- Selectively clear only CSS/JS aggregates during theme work.
- Rebuild the plugin cache after adding a plugin.
- Clear the render cache without a full cache rebuild.
- Flush the Views cache after editing a view.
- Clear compiled Twig templates during template development.
- Trigger a theme registry rebuild.
- Flush the menu cache after changing menu links.
- Run cron on demand from the toolbar.
- Jump straight to "Add content" for any content type.
- Quickly create a new content type, vocabulary, or other bundle.
- Reach field and display management pages in one hover.
- Log out of the site via a toolbar link.
- Limit how many bundles per entity type appear to keep the menu tidy.
- Optionally surface local tasks (tabs) inside the toolbar.
- Speed up the develop → clear cache → verify loop for developers.
- Give content editors fast "add content" shortcuts.
- Bookmark the `/admin/flush` URL for a direct cache-clear link.
- Provide CSRF-protected admin action endpoints for power users.
- Reduce trips to `/admin/config/development/performance` for cache clears.
- Standardize a productivity toolbar across developer environments.
