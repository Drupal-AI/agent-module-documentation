<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Purge Everything Queuer

A small helper for the Purge framework. It registers an `everything` queuer and exposes a `queueEverything()` service that empties the current purge queue and adds one everything-invalidation object (when an active purger supports it). A cron hook triggers this automatically once the queue exceeds 100,000 items, preventing a runaway queue.

---

# Installing & configuring

- Enable the module (requires `purge`).
- No settings form — behaviour is automatic via cron and the exposed service.
- Requires an active purger that supports 'everything' invalidation for the queuer to act.
- Call `\Drupal::service('purge_everything_queuer.everything')->queueEverything()` from custom code if needed.

---

- Registers an `everything` Purge queuer plugin (`EverythingQueuer`).
- `QueueEverything::queueEverything()` empties the queue then adds one everything invalidation.
- It silently no-ops if no purger supports everything invalidation (`TypeUnsupportedException`).
- It also no-ops during Purge uninstall/plugin-cache rebuilds (`PluginNotFoundException`).
- `hook_cron()` invokes it when `purge.queue.stats` reports >= 100,000 queued items.
- After queuing, it reloads `purge.diagnostics` to clear the queue-full error.
- If a cron purge processor exists, it triggers `purge_processor_cron_cron()`.
- No routes, forms, permissions or config are defined.
- No external HTTP calls or user input.
- The help page renders the module README.
- Purely an operational/performance utility.
- Prevents the purge queue from growing unbounded on busy sites.
- Intended for sites where full-flush is acceptable when tag purging falls behind.
- Behaviour is deterministic and admin-invisible (no UI).
- No security-relevant surface exists in the module.
- Safe to enable alongside any purger that implements everything invalidation.
