CacheFlusher adds a link to the admin navigation toolbar that flushes all Drupal caches with one click, then returns you to the page you were on.

---

CacheFlusher is a tiny convenience module (package "Cache", core `^10 || ^11`). It registers a single route `/admin/cacheFlusher` handled by `CacheFlusherController::cacheFlusherCacheClear()`, which calls Drupal's `drupal_flush_all_caches()`, shows an "All Caches cleared." status message, and redirects back to the referring page. A menu link (`cacheflusher.links.menu.yml`, parent `system.admin`) surfaces the action in the admin toolbar/menu, and `hook_page_attachments()` attaches the `cacheflusher/cacheflusher-styling` CSS library (a reload icon). Access is controlled by the single permission `access cache flusher`; there are no configuration settings, config schema, services, plugins, entities, or Drush commands. It is meant to save developers and site builders the trip to the performance page or a `drush cr` during development, theme and config work. A full cache flush is expensive and rebuilds caches for the whole site, so grant the permission only to trusted admin roles.

---

- Flush all Drupal caches from the admin toolbar with one click.
- Skip the Performance settings page (`/admin/config/development/performance`) for a routine cache clear.
- Skip `drush cr` when a browser is already open.
- Clear stale render/page caches after editing content.
- Refresh caches after changing theme templates or CSS/JS during theme development.
- Rebuild the container/discovery caches after config or plugin changes.
- Return automatically to the page you were viewing after the flush (via the HTTP referer).
- Grant `access cache flusher` to a developer or site-builder role so non-super-admins can clear caches.
- Restrict cache clearing to trusted roles by withholding the permission.
- Give QA staff a fast cache-clear button without CLI access.
- Provide a toolbar shortcut for frequent cache clears during a content-migration review.
- Confirm a fix depends on a cache clear (clear, then re-test) without leaving the page.
- Show the reload icon in the admin menu under Administration (`system.admin`).
- Use the light/dark reload icons shipped in `presentation/icons/` via the attached CSS library.
- Enable with `drush en cacheflusher`; no configuration step is required afterwards.
- Uninstall cleanly (`drush pmu cacheflusher`) — it stores no config or state.
- Teach new site builders a one-click cache-clear workflow.
- Reduce friction when iterating on Twig templates.
- Trigger a full cache rebuild before a demo to ensure fresh output.
- Understand that clearing caches degrades performance briefly for all users while caches rebuild.
