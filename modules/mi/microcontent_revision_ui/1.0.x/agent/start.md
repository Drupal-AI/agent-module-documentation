<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Microcontent Revision UI - agent index

Adds revision history/view/revert UI to `microcontent` entities. Depends on `microcontent`. No config/services.

Key facts (`microcontent_revision_ui.module`):
- `hook_entity_type_alter()` adds core `RevisionHtmlRouteProvider`, link templates `revision`,
  `version-history`, `revision-revert-form`, and the `revision-revert` form (`RevisionRevertForm`).
- `hook_ENTITY_TYPE_access()` maps ops to perms: `view any microcontent history` / `view any microcontent
  revisions` / `revert any microcontent revisions` / `delete any microcontent revisions`; else neutral.
- Revision routes are permission-gated (no anon access). Version dir `1.0.x`.
