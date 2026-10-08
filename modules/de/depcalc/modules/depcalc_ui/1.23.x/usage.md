Depcalc UI is a tiny glue submodule that adds a "Clear depcalc cache" button to the core Performance settings page, since a normal cache rebuild does not clear the depcalc cache.

---

The submodule contains only a `.module` file. It implements `hook_form_system_performance_settings_alter()` to add a `Clear depcalc cache` submit button (with the hint that "Clear all caches will not clear depcalc cache") to `/admin/config/development/performance`. Its submit handler resolves the `cache.depcalc` service and calls `deleteAllPermanent()`, then shows a status message. It defines no routes, permissions, config, services or plugins of its own and simply depends on `depcalc`. It is the UI equivalent of the `drush depcalc:clear-cache` command.

---

- Clear the depcalc cache from the admin UI without using Drush.
- Give non-CLI admins a button to empty the dependency cache on the Performance page.
- Recover from stale dependency data after content changes by clicking the button.
- Provide a visible reminder that "Clear all caches" does not clear the depcalc cache.
- Offer a UI alternative to `drush depcalc:clear-cache` for the same effect.
- Let a site builder flush depcalc without shell access to the server.
- Reset cached dependency calculations before a content export or migration.
- Troubleshoot Acquia Content Hub / packaging issues by clearing stale depcalc data.
- Empty the depcalc bin after bulk-editing entities that changed their references.
- Add the clear action to an existing admin routine on the Performance settings page.
- Confirm to editors why a normal cache rebuild left dependency data in place.
- Force recalculation of an entity's dependencies on the next request.
- Clear depcalc cache as a quick step while debugging dependency collectors.
- Give a support role a one-click way to invalidate the whole depcalc bin.
- Use the button in environments where Drush is unavailable or restricted.
- Verify a dependency fix took effect by clearing then re-triggering a calculation.
- Provide parity between the CLI (`dep-cc`) and the UI for clearing depcalc cache.
- Include depcalc cache clearing in a manual pre-deploy checklist via the UI.
- Remove outdated cached module dependencies after enabling/disabling modules.
- Let admins clear depcalc cache from the same page they clear other caches.
