<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Registration Scheduled Action — agent index

Cron-driven actions (usually emails) run a configurable time before/after a registration date, across
all matching registrations. Configure route:
`entity.registration_scheduled_action.collection` → `/admin/structure/registration/schedule`.

- **The config entity, its datetime offset, the action plugin, and cron** →
  [configure/scheduled-action.md](configure/scheduled-action.md)
- **Permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:

- Config entity `registration_scheduled_action.<id>` keys: `label`, `weight`, `status`,
  `datetime` (`length` int, `type` minutes|hours|days|months, `position` before|after),
  `target_langcode`, `plugin` (a `registration`-type Action plugin id, e.g.
  `registration_send_email_action`), `configuration`.
- Cron worker `Drupal\registration_scheduled_action\Cron\RegistrationSchedule` runs them.
- Permission: `administer registration scheduled action`.
