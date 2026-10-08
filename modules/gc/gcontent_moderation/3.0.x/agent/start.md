<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Content Moderation — agent index

Makes core **Content Moderation** transition and latest-revision access decisions **group
permission-aware** by decorating two core services. Depends on `content_moderation` + `group`.
**No settings form** (`configure: null`); you configure a content-moderation workflow and grant
the module's group permissions to group roles.

- **Setup: workflow, the group permissions to grant, the Moderated-content view, the Views filter** →
  [configure/setup.md](configure/setup.md)
- **The dynamically-generated group permissions (`use <workflow> transition <id>`, "view latest version")** →
  [permissions/group-permissions.md](permissions/group-permissions.md)
- **How it works: the two decorated services (`ServiceProvider`)** →
  [extend/decorated-services.md](extend/decorated-services.md)

Key facts: decorates `content_moderation.state_transition_validation` (→ `GroupStateTransitionValidation`)
and `access_check.latest_revision` (→ `LatestRevisionCheck`). Group permission pattern:
`use <workflow_id> transition <transition_id>`, plus static `view latest version`. Optional view
`moderated_group_content` at `group/%group/moderated`.
