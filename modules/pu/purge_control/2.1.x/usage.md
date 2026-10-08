<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Purge control adds a config-driven pause switch to the Purge pipeline, so cache invalidation can be suspended during a bulk operation and resumed afterwards, with an optional cron safety net that turns it back on.

---

Purge's job is to tell an external cache — a CDN, Varnish — what to invalidate, and it does that faithfully: every entity save queues invalidations, which is right during normal editing and wrong during a migration, a bulk resave or a large import, when hundreds of thousands of invalidations are queued and forwarded in minutes. The consequences range from a rate-limit ban at the CDN to a cache stampede when the edge refetches everything at once. This module turns pausing into a first-class operation built on one config object, `purge_control.settings`, with two booleans: `disable_purge` (the kill switch) and `purge_auto_control` (an automation flag). The switch is enforced through Purge's own diagnostics — the module supplies a `PurgeDiagnosticCheck` plugin (`purge_enabled`) that returns a `SEVERITY_ERROR` while purging is disabled, which marks Purge's system as "on fire" and stops its processors and queuers, so no invalidations reach the external cache. A `ConfigFormBase` settings form at `/admin/config/development/performance/purge/purge-control` (behind `administer site configuration`) toggles both flags; a `purge_control.purge_control` service exposes `enablePurge()`, `disablePurge()`, `autoEnablePurge()`, `autoDisablePurge()`, `setAutomation()`; and a `purge-control`/`pc` Drush command drives it from deployment and migration scripts. `hook_cron` calls `autoEnablePurge()`, which re-enables purging only when automation is on — a recovery mechanism so a forgotten pause self-heals; before a deployment you therefore turn automation off first so cron does not undo the pause. Requirements are PHP 8.1+ and Purge `^3.0.0`, core `^10 || ^11`. The operational caution: invalidations that would have happened while paused are simply skipped, so plan a full "everything" invalidation after resuming.

---

- Pause purging during a content migration.
- Avoid a CDN rate-limit ban during a bulk import.
- Suspend invalidation while resaving all nodes.
- Resume purging after a deployment, then flush everything once.
- Pause and resume from a Drush deployment script.
- Prevent a cache stampede after bulk edits.
- Keep Purge configured but idle during maintenance.
- Avoid disabling the Purge module by hand.
- Control purging from a CI/CD pipeline.
- Reduce CDN costs during a large operation.
- Turn off cron auto-recovery so a deployment pause holds.
- Let cron re-enable a forgotten pause automatically.
- Stop invalidation while debugging cache behavior.
- Protect an external cache from an invalidation flood.
- Coordinate purging with a release window.
- Wrap a long Drush command with pre/post pause hooks.
- Toggle purging from the settings form for a quick one-off.
- Surface a "Purging is disabled" warning on the Purge status page.
- Reduce load on a shared CDN account during batch work.
- Script a migration workflow that pauses and resumes purging.
- Add a diagnostic that flags when purging has been left off.
- Re-enable purging site-wide with a single `drush pc enp`.
