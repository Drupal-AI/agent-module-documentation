Coffee adds an Alfred/Spotlight-style quick-search box that lets editors and admins jump to any admin page by keyboard, without clicking through menus.

---

Coffee is a productivity tool for site builders and content teams: press a keyboard shortcut (by default Alt/Ctrl + K/D) and a search overlay appears, letting you type the name of an admin page and hit Enter to navigate straight there. It indexes items from the site's admin menus (configurable in settings), so "add article", "people", or "modules" resolve to the right routes. A toolbar link is also provided as an entry point. The number of results shown and which menus are searched are configurable at Admin → Configuration → User interface → Coffee. It supports special commands: prefixing input lets it match specific command patterns, and developers can extend the command list via `hook_coffee_commands()` to surface custom routes or even Views results inside the search box. Access is gated by an "Access Coffee" permission, with a separate "Administer Coffee" permission for configuration. It is purely a navigation aid — no content is changed — and it dramatically speeds up repetitive admin work on large sites. The front end is a small JS/CSS library built on core jQuery, autocomplete, and once.

---

- Jump to any admin page by keyboard instead of clicking through menus.
- Open the "Add content" form for a specific content type in two keystrokes.
- Navigate to People, Modules, or Configuration pages instantly.
- Speed up repetitive admin tasks for editors on large sites.
- Trigger the search overlay with a keyboard shortcut (Alt/Ctrl + K/D).
- Launch Coffee from a toolbar link.
- Limit which admin menus are searched via configuration.
- Cap the number of results shown in the overlay.
- Use command prefixes (e.g. `:x`) to target specific quick commands.
- Add custom navigation targets via `hook_coffee_commands()`.
- Surface Views results (e.g. recent nodes) directly in the search box.
- Give power users a Spotlight/Alfred-like workflow inside Drupal.
- Reduce reliance on the admin toolbar for frequent destinations.
- Provide fast navigation on sites with deep, nested admin menus.
- Restrict access to trusted roles via the "access coffee" permission.
- Separate who can configure Coffee via "administer coffee".
- Onboard new editors with a discoverable, searchable admin.
- Bookmark-free access to routes that aren't in the toolbar.
- Quickly reach a module's settings form by name.
- Jump to a user's edit page or the roles/permissions screen.
- Add a custom command that links to an external tool or dashboard.
- Improve accessibility of navigation for keyboard-first users.
- Deploy the searched-menu configuration between environments as config.
- Cut clicks for content moderators reviewing many sections daily.
