# navigation_extra_tools — agent start

Adds a **Tools** submenu (wrench icon) to Drupal core's Navigation toolbar with shortcuts to
flush caches, run cron, and run database updates — the Navigation-era analog of
`admin_toolbar_tools`. Depends only on core `navigation`. Has **no configuration form** of
its own (`configure` is null). Works on Drupal 10.3+, 11, 12.

- The links it adds + their routes (flush caches, run cron, run updates, Devel/Project Browser sections) → [configure/navigation_extra_tools.md](configure/navigation_extra_tools.md)
- Permissions that gate the cache-flush and cron links → [permissions/navigation_extra_tools.md](permissions/navigation_extra_tools.md)
- The wrench icon pack / CSS library and how it attaches → [theming/navigation_extra_tools.md](theming/navigation_extra_tools.md)
