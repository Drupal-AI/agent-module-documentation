<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Event Platform Bundle (event_platform) — agent index

**An install-time bundle that configures an event/conference site (sessions, speakers, sponsors, scheduler).**

- **Version:** 2.0.x
- **Core:** ^10.3 || ^11
- **Bundles in:** event_platform_details, _job_listings, _sessions, _speakers, _sponsors, _scheduler, _ratings (+ optional _olivero, _flag)
- **Contrib deps:** add_content_by_bundle, auto_entitylabel, config_pages, field_group, field_permissions, hide_revision_field, smart_date, eca
- **Scheduler routes:** `/admin/event-details/scheduler` (`edit any session content`), `/settings` (`administer site configuration`), `/time_slots` (`edit terms in time_slot`), ajax `assign/{node}/{rid}/{tid}` and `unassign/{node}` (`edit any session content`)
- **Note:** the top-level module chiefly imports config and can be uninstalled after setup; only the Scheduler keeps a live UI. Re-install requires deleting the created bundles first.
- **Security:** scheduler/config endpoints all permission-gated to session-content editors/admins; no anonymous or unauthenticated mutating routes. No security findings.
