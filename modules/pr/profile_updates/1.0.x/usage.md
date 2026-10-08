<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Profile Updates lets site administrators review optional configuration changes shipped by an install profile (or its modules) and decide, one by one or in bulk, which to apply — replacing forced `hook_post_update_N()` with a deliberate, opt-in action.

---

Distributions face a dilemma: forced update hooks give site owners no say and can overwrite local customizations. Profile Updates discovers *update tasks* — YAML files shipped as `ProfileUpdate` plugins (`EXTENSION/update_tasks/*.yml`, re-scanned every cache clear) — and computes each task's state live per site by diffing shipped config against active config (via `config_update`) and consulting a log: Pending, Blocked, Up to date, Applied or Skipped. Admins with `administer profile updates` open Configuration → Development → Profile updates, view a per-item config diff, then Apply (through Batch API) or Skip. Every choice is recorded in a permanent `profile_update_log` entity for audit; a skip can be undone (Restore) so the task recomputes to Pending. A Drush command set and an optional `profile_updates_export` submodule (which can generate update-hook or update-task scaffolding) round it out. All routes require the restricted `administer profile updates` permission.

Set up by requiring `config_update`, enabling the module, and having the profile ship `update_tasks/*.yml`; site owners then review and apply on their own schedule.

---
- Review optional profile config changes before applying them.
- Apply updates selectively, one at a time.
- Bulk-apply multiple pending updates via Batch API.
- Skip an update you never want on this site.
- Restore (un-skip) an update so it returns to Pending.
- See a live config diff for each update.
- Diff a past applied update from its log entry.
- Keep a permanent audit trail of applied/skipped updates.
- Ship update tasks as YAML plugins from a distribution.
- Auto-discover tasks on every cache clear (no import step).
- Let contrib modules ship their own update tasks.
- Compute each task's state per site (Pending/Blocked/Up to date/Applied/Skipped).
- Block updates until a required module or prior update lands.
- Run applies from Drush for CI/deploy pipelines.
- Generate update-hook scaffolding via the export submodule.
- Generate update-task YAML via the export submodule.
- View pending updates as an admin form list.
- Avoid overwriting local customizations from forced hooks.
- Restore an accidentally skipped update.
- Give site owners final say over distribution changes.
