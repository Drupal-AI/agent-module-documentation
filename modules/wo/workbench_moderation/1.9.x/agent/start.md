<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Workbench Moderation — agent index

Editorial moderation states + transitions for revisionable content (the contrib predecessor
of core Content Moderation). Enable per bundle; content then moves Draft → Needs Review →
Published → Archived via configurable transitions, with forward (draft) revisions kept apart
from the live version. Depends on `views`, `options`. No Drush.

- **Enable moderation on a bundle; the admin overview / states / transitions UIs** →
  [configure/enable.md](configure/enable.md)
- **The `moderation_state` & `moderation_state_transition` config entities + defaults** →
  [configure/states-transitions.md](configure/states-transitions.md)
- **Services & the `moderation_state` field (moderation_information, validation, revision tracker)** →
  [api/api.md](api/api.md)
- **Permissions (static + dynamic `use <transition> transition`)** →
  [permissions/permissions.md](permissions/permissions.md)
- **The state-transition event** → [events/events.md](events/events.md)

Quick reference:
- Config entity types: `moderation_state` (keys `id`, `label`, `published`, `default_revision`),
  `moderation_state_transition` (keys `id`, `label`, `stateFrom`, `stateTo`, `weight`).
- Default states: `draft`, `needs_review`, `published`, `archived`.
- Per-bundle enable: third-party setting on the bundle config (e.g.
  `node.type.<bundle>` → `third_party_settings.workbench_moderation`):
  `enabled` (bool), `allowed_moderation_states` (array), `default_moderation_state` (string).
- Base field added to moderated entities: `moderation_state`.
- Config/overview routes under `/admin/structure/workbench-moderation` (route
  `workbench_moderation.overview`). Event id `workbench_moderation.state_transition`.
