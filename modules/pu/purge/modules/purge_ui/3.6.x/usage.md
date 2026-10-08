Purge UI is the administrative dashboard for the Purge framework, letting site builders configure purgers, processors, queuers and the queue, inspect diagnostics, and manually clear caches through the UI.

---

This submodule adds the web interface for Purge at Admin → Configuration → Development → Performance → Purge (config route `purge_ui.dashboard`). From the dashboard you can add, configure, reorder, and remove purger plugins; enable/disable processors and queuers; change the queue backend; browse and empty the queue; and read diagnostic check results. All changes write to the `purge.plugins` config that the core framework reads. It uses AJAX modal dialogs for the add/configure/delete forms of each plugin type. It also ships a block (`PurgeBlock`) — with its own dedicated processor and queuer — that renders a manual "purge" button so privileged users can flush caches from the front end. It has no configuration schema of its own and no permissions beyond core's site-configuration permission. On production it is often enabled only while configuring, then left in place for occasional queue inspection.

---

- Configure the Purge pipeline through a web UI instead of Drush.
- Add a purger plugin for your CDN or reverse proxy.
- Reorder multiple purgers (move up/down).
- Remove a purger you no longer need.
- Enable the cron or late-runtime processor from the UI.
- Add or remove queuer plugins.
- Switch the active queue backend.
- Browse the current contents of the purge queue.
- Empty the queue from the dashboard.
- Read diagnostic checks (no purger, low capacity, etc.).
- Configure logging verbosity per Purge service.
- Open plugin config in an AJAX modal dialog.
- Place a manual "purge" block for editors.
- Let privileged users flush caches with one click.
- See at a glance which invalidation types are supported.
- Verify a new purger works before relying on cron.
- Diagnose why cache invalidation is not firing.
- Give site builders a no-CLI way to manage caching.
