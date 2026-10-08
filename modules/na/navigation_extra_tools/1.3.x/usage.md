Navigation Extra Tools adds a "Tools" submenu to Drupal core's new Navigation toolbar with shortcuts for clearing caches, running cron, and running database updates — the Navigation-era equivalent of the "Admin Toolbar Extra Tools" submodule.

---

Navigation Extra Tools brings the familiar administrative shortcuts of `admin_toolbar_tools` to Drupal core's modern Navigation module. It adds a top-level **Tools** item (a wrench icon) to the admin Navigation menu, under which it exposes one-click links for flushing all caches, flushing individual caches (CSS/JS, plugins, static, routing & links, Twig, render, and a theme-registry rebuild), running cron, and running outstanding database updates. Each cache/cron action is a CSRF-protected route handled by `NavigationExtraToolsController`, which performs the operation and redirects back to the page you were on with a status message. The menu is built statically from `navigation_extra_tools.links.menu.yml` plus a `ToolsMenuDeriver` plugin deriver that conditionally adds extra sections: if the **Devel** module is enabled a **Development** submenu appears (its contents mirror the Devel Toolbar settings at `/admin/config/development/devel/toolbar`), and if **Project Browser** is enabled a Project Browser section with a "Clear storage" link appears. The module has no configuration form of its own. Access is gated by two dedicated permissions — one for the cache-flushing links and one for the cron link — so administrators must grant those permissions before users can see and use the corresponding Tools items. It depends only on the core `navigation` module and works on Drupal 10.3+, 11, and 12.

---

- Add a "Tools" menu to the core Navigation toolbar with admin shortcuts.
- Flush all caches with one click from the Navigation menu (`/admin/flush`).
- Clear the CSS and JavaScript aggregation cache without visiting the Performance page.
- Clear the plugins cache from the toolbar.
- Reset all static caches on demand.
- Flush the routing and menu-links cache and rebuild menu links.
- Clear the Twig template cache after editing templates.
- Clear the render cache from the toolbar.
- Invalidate the Views cache.
- Rebuild the theme registry after adding theme hooks or templates.
- Run cron manually from the Navigation menu (`/run-cron`).
- Run outstanding database updates via the toolbar (`system.db_update`).
- Give a Navigation-toolbar cache/cron menu to sites migrating off Admin Toolbar's Extra Tools.
- Expose a Development submenu of Devel shortcuts when Devel is installed.
- Surface Webprofiler settings under the Development submenu when Webprofiler is present.
- Add an "Execute PHP Code" shortcut when Devel PHP is enabled.
- Clear Project Browser non-volatile storage to force a data refresh (development/debugging).
- Grant editors cache-flush access without full admin rights via a dedicated permission.
- Grant a role the ability to run cron from the UI via a dedicated permission.
- Give administrators quick individual-cache flushing during theme or module development.
- Speed up a build/deploy checklist by clearing specific caches from the toolbar.
- Provide a consistent admin-tools experience for sites standardizing on the Navigation module.
- Let site builders rebuild routing after adding new routes without a full cache clear.
- Attach the module's wrench icon library only to users who can access the Navigation toolbar.
