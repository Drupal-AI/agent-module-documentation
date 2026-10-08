<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Moderation Owner Permissions adds an "own content" companion permission for every Content Moderation workflow transition, so a role can move its own content through a transition without holding core's global permission for that transition on all content.

---

Drupal core's Content Moderation grants transition permissions globally: `use editorial transition publish` lets a user publish **any** content they can edit, with no "own content" equivalent like node editing has. This module fills that gap by generating, for each transition of each `content_moderation` workflow, a permission named `use <workflow_id> transition <transition_id> for own content` (for example `use editorial transition publish for own content`). Install it with `composer require drupal/content_moderation_owner_permissions` and enable it (`drush en content_moderation_owner_permissions`); it depends only on core `content_moderation`. There is no settings page — configuration is entirely on `/admin/people/permissions`, where the new permissions appear grouped under the module (one per transition, so the exact list depends on the workflows you have configured; rebuild caches after changing workflows if the list looks stale). The classic pattern is to grant a role broad edit access (e.g. **edit any article**) together with an own-content transition permission such as `use editorial transition publish for own content`, while **removing** the global `use editorial transition publish`, so authors can create drafts of anything but only publish work they created. Under the hood the module decorates core's `content_moderation.state_transition_validation` service so these own-content permissions are honoured both in the moderation-state select shown on edit forms and when the entity is saved. Don't forget to also set the appropriate node (or other entity) edit permissions so the users can actually reach the content.

---

- Let content authors publish only their own content while editing anyone's.
- Give a role "edit any" access plus own-content publish rights.
- Remove the global publish permission and grant the own-content one instead.
- Scope a specific workflow transition to content the user created.
- Let authors move their own drafts from Draft to In review.
- Allow archiving of a user's own content without global archive rights.
- Model a "junior editor drafts everything, publishes own work" role.
- Add per-transition own-content permissions to the editorial workflow.
- Extend the same pattern to a custom Content Moderation workflow.
- Keep global transition permissions restricted to trusted editors.
- Combine owner-scoped transitions with core's global transition permissions.
- Grant `use <workflow> transition <transition> for own content` on the permissions page.
- Delegate self-service moderation to the content's own creator.
- Support LocalGov Drupal editorial roles that self-moderate.
- Let community authors submit and revise their own contributions.
- Configure per-role which transitions a user may run on their own content.
- Enable the module only where a content_moderation workflow is in use.
- Rebuild caches after adding a workflow so its own-content permissions appear.
- Assign own-content transition rights with `drush role:perm:add`.
- Audit which roles hold own-content transition permissions.
- Pair with node/entity edit permissions so users can reach their content.
