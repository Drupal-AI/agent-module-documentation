# purge_ui — agent start

Admin dashboard for the **purge** framework. Enable it to manage the pipeline in the browser
at **Admin → Config → Development → Performance → Purge** (`/admin/config/development/performance/purge`,
config route `purge_ui.dashboard`). Depends on `purge`.

Capabilities (all via the dashboard, AJAX modal forms; writes to `purge.plugins` config):
- Add / configure / reorder / delete **purger** plugins.
- Enable/disable **processor** and **queuer** plugins; change the **queue** backend.
- Browse and empty the queue; read **diagnostic** results; set logging verbosity.
- `PurgeBlock` block (`Plugin/Block/PurgeBlock`) — a manual front-end purge button, backed by
  its own `PurgeBlockProcessor` + `PurgeBlockQueuer`.

No config schema or permissions of its own (uses core `administer site configuration`).
No solution docs — everything is UI. For CLI equivalents see the `purge` core drush docs.
