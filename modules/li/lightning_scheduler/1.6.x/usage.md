<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lightning Scheduler lets editors schedule one or more future moderation-state changes on any Content Moderation entity; cron executes each transition when its scheduled date arrives.

---

Lightning Scheduler builds on core Content Moderation. For every moderated entity type it adds two revisionable, translatable, unlimited-cardinality base fields — `scheduled_transition_date` (datetime) and `scheduled_transition_state` (string) — installed/removed automatically as workflows gain or lose entity types (`hook_entity_base_field_info`, plus `workflow` insert/update/delete hooks) via `BaseFields`. The moderation-state edit widget (`ModerationStateWidget`, which replaces core's `moderation_state_default` widget class) is augmented with a small JavaScript UI that lets an author queue a list of "on DATE, transition to STATE" entries; these are stored as parallel deltas across the two base fields and represented internally as a `TransitionSet` (JSON of `{state, when}` objects, sorted by time). On cron (`hook_cron` → `TransitionManager::process()` per entity type that has both fields), the module loads the latest revision of each entity whose earliest pending transition is due (looking back only as far as roughly three days before the last successful cron for performance), computes the expected target state, and — if the workflow actually defines a transition from the current to the target state — sets `moderation_state` and saves, then trims elapsed entries; otherwise it logs a warning. Validation rejects malformed data and, unless the site allows it, past dates. Two settings live in `lightning_scheduler.settings` (route `lightning_scheduler.settings` at `/admin/config/system/lightning/scheduler`, permission "administer lightning scheduler"): `time_step` (the time input's `step` in seconds — 1, 60, 300, 600, 900, 1800 or 3600) and `allow_past_dates` (boolean). Transition permissions are re-derived from the workflow's own transitions as `schedule <workflow> <transition>` (class `Permissions`). Most classes are marked `@internal`.

---

- Schedule an article to publish automatically at a specific future date and time.
- Schedule content to unpublish (e.g. an expiring promotion) on a set date.
- Queue several moderation changes in advance (draft → published → archived) on one entity.
- Let editors plan an editorial calendar without a person clicking "publish" at midnight.
- Move content from "Draft" to "Needs Review" on a deadline automatically.
- Auto-archive time-sensitive pages after an event ends.
- Schedule transitions on any moderated entity type, not just nodes (media, custom entities…).
- Schedule transitions per translation, since the fields are translatable.
- Have cron run due transitions, so no external scheduler is needed.
- Constrain the scheduling time picker to whole minutes (or 5/10/15/30-minute steps) via `time_step`.
- Constrain scheduling to 1-second precision or 1-hour steps as needed.
- Allow or forbid scheduling dates in the past with `allow_past_dates`.
- Grant only certain roles the right to schedule a specific workflow transition.
- Reuse an existing Content Moderation "editorial" workflow with zero new fields to configure.
- Publish a batch of embargoed news stories at a coordinated release time.
- Roll a landing page back to "Draft" automatically at campaign end.
- Ensure a transition only fires if the workflow legitimately allows it (invalid ones are logged, not forced).
- Recover missed transitions after a cron outage (it looks back ~3 days from last cron).
- Store the schedule as revisionable data so it travels with content revisions.
- Present authors a clean "add transition" UI on the entity edit form.
- Prevent accidental scheduling of malformed or out-of-order dates through built-in validation.
- Coordinate simultaneous state changes across many entities via a single cron run.
