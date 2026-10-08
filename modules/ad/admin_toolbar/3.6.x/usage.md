Admin Toolbar turns Drupal's core Toolbar into a fast, fully expandable drop-down administration menu, so you can jump to any admin page in a single hover without loading intermediate pages.

---

Drupal core ships a Toolbar that only shows top-level administration links and requires a click and a page load to drill into each section. Admin Toolbar replaces that behavior with pure-CSS/JS drop-down menus that expose the entire administration menu tree on hover, dramatically speeding up navigation for site builders and administrators. It does not add its own menu items — it simply renders the existing admin menu (and any modules that add to it) as nested fly-out menus. Display is tuned through a small settings form: menu depth, sticky/hide-on-scroll behavior, an optional keyboard shortcut to toggle the toolbar, and hoverIntent timing so submenus do not flicker. It is intentionally lightweight and depends only on core's Toolbar module. Three optional submodules extend it: Extra Tools adds action links (flush caches, run cron, etc.), Search adds a link filter/search box, and Links Access Filter (deprecated) hides links a user cannot access. It is one of the most widely installed contrib modules and a near-default part of most Drupal installs.

---

- Navigate the whole admin menu via hover drop-downs instead of click-through pages.
- Reach any configuration page in one motion from the toolbar.
- Speed up day-to-day site building and content administration.
- Expose nested menu items (content types, vocabularies, views) as fly-out submenus.
- Control how deep the drop-down menu renders via the menu depth setting.
- Keep the toolbar sticky at the top of the viewport while scrolling.
- Hide the toolbar on scroll-down and reveal it on scroll-up to save space.
- Enable a keyboard shortcut to toggle the toolbar on and off.
- Tune hoverIntent timeout so submenus don't open/close on accidental passes.
- Provide a faster admin UX on large sites with deep menu structures.
- Replace legacy "Administration Menu" module with a maintained equivalent.
- Give editors quick access to add-content and moderation links.
- Serve as the base for Admin Toolbar Extra Tools cache/cron action links.
- Add a searchable link filter to the toolbar via the Search submodule.
- Improve accessibility of admin navigation with keyboard-toggleable toolbar.
- Standardize the admin navigation experience across a multi-site fleet.
- Reduce clicks for repetitive administrative workflows.
- Pair with contrib modules that add their own admin menu links for instant access.
- Export toolbar display preferences as configuration for deployment.
- Provide a consistent admin menu on Drupal 9, 10, and 11.
- Let themers restyle the drop-down menus via the module's CSS.
- Give agencies a familiar admin navigation across client sites.
