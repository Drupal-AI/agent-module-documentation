<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lightning Scheduler — agent index

Schedule future **Content Moderation** state transitions on any moderated entity; **cron**
executes each transition when due. Builds on core `content_moderation` + `datetime`.

- **Settings (`time_step`, `allow_past_dates`), how scheduling data is stored (the two base
  fields + the widget), and how cron processes it** →
  [configure/settings.md](configure/settings.md)
- **Permissions: the auto-derived `schedule <workflow> <transition>` set + `administer
  lightning scheduler`** → [permissions/permissions.md](permissions/permissions.md)

Key facts: for every moderated entity type it installs two revisionable, translatable,
unlimited-cardinality base fields — `scheduled_transition_date` (datetime) and
`scheduled_transition_state` (string) — via `hook_entity_base_field_info` and workflow
insert/update/delete hooks (`BaseFields`). The moderation widget
(`moderation_state_default`) is swapped to `ModerationStateWidget` to add the scheduling UI.
`hook_cron` → `TransitionManager::process()` applies due transitions (only if the workflow
actually allows the from→to transition; otherwise it logs). Settings config object:
`lightning_scheduler.settings` (route `lightning_scheduler.settings` at
`/admin/config/system/lightning/scheduler`). Most classes are `@internal`.

Note: the base fields only exist once a Content Moderation workflow is assigned to an entity
type. On a site with no moderated bundles, no scheduling fields are present.
