<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scheduled Transitions — agent index

Schedule a content-moderation revision to change moderation state at a future date/time.
Requires core **Content Moderation** + **Dynamic Entity Reference**. Each scheduled change is a
`scheduled_transition` content entity; due ones are processed via a cron queue.

Key facts:
- `configure` route = `scheduled_transitions.settings` → `/admin/config/workflow/scheduled-transitions`.
- Config object `scheduled_transitions.settings` (bundles enabled, automation, message templates, mirror_operations, retain_processed).
- Collection: `/admin/content/scheduled-transitions`. Per-entity tab: "Scheduled transitions".
- Queue worker id `scheduled_transition_job`; Drush `scheduled-transitions:queue-jobs` (alias `sctr-jobs`).
- Only works for entity types/bundles that are (a) moderated by a content_moderation workflow and (b) enabled in settings `bundles`.

- **Settings form + config keys + enabling a bundle** → [configure/settings.md](configure/settings.md)
- **Schedule / process transitions in code (the `scheduled_transition` entity, runner, jobs)** →
  [api/schedule.md](api/schedule.md)
- **Permissions (3 dynamic per-bundle + 2 global)** → [permissions/permissions.md](permissions/permissions.md)
- **Drush command** → [drush/commands.md](drush/commands.md)
- **Override which revision is transitioned (event)** → [hooks/events.md](hooks/events.md)
