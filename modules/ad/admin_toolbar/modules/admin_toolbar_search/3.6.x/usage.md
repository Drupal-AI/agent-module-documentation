Admin Toolbar Search adds a search/filter box to the Admin Toolbar so you can type to jump straight to any administration link instead of hunting through drop-down menus.

---

This submodule of Admin Toolbar puts a live search field in the toolbar that filters every link in the administration menu as you type, letting administrators reach a destination by keyword rather than by navigating nested fly-outs. The searchable link index is built server-side by the `admin_toolbar_search.search_links` service, which walks the menu tree (and Admin Toolbar Tools' extra links, when present) and returns matches over an AJAX endpoint guarded by the `use admin toolbar search` permission. A configurable keyboard shortcut (Alt + a by default) focuses the search box instantly, and a setting controls whether the search field renders inline in the toolbar or as a menu item. Results are cached with the toolbar cache for performance. It is especially valuable on large sites where the admin menu is deep and finding a specific settings page by memory is slow. It depends on core's Toolbar module and pairs naturally with the base Admin Toolbar and Extra Tools submodules.

---

- Type a keyword to jump to any admin page instead of browsing menus.
- Find a deeply nested configuration form by name in seconds.
- Focus the search box with the Alt + a keyboard shortcut.
- Search across Admin Toolbar Tools' extra action links too.
- Speed up navigation on sites with hundreds of admin links.
- Let new team members discover admin pages by searching keywords.
- Filter to a content type's settings without remembering the path.
- Reach field/display management pages by typing the field name.
- Display the search field inline in the toolbar for one-key access.
- Alternatively render search as a menu item to save toolbar space.
- Gate the search endpoint behind a dedicated permission.
- Reduce reliance on memorized `/admin/config/...` URLs.
- Provide a keyboard-driven admin workflow for power users.
- Improve accessibility by offering search as an alternative to hover menus.
- Cache search results with the toolbar cache for fast repeat use.
- Help agencies onboard staff to unfamiliar client sites faster.
- Quickly locate module settings pages after installing new modules.
- Search for "cron", "cache", or "permissions" and go straight there.
- Standardize a searchable admin UX across a multisite platform.
