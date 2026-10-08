<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Workbench Moderation adds editorial moderation states (Draft, Needs Review, Published, Archived) and configurable transitions between them to any revisionable content entity bundle, so content can move through a publishing workflow with forward (draft) revisions kept separate from the live published version.

---

The module defines two config entity types — `moderation_state` (id, label, `published`, `default_revision`) and `moderation_state_transition` (id, label, `stateFrom`, `stateTo`, weight) — and ships four default states and ten default transitions. Moderation is turned on **per bundle** by a third-party setting on the bundle's config entity (e.g. `node.type.<bundle>` → `third_party.workbench_moderation` with `enabled`, `allowed_moderation_states`, `default_moderation_state`); enabling it forces revisions on and adds a `moderation_state` base field plus a "Latest version" tab to the entity. A `moderation_state` value chosen on the edit form drives whether a save creates a new default (published) revision or a forward draft revision, tracked in a `workbench_moderation_revision_tracker` table via the `revision_tracker` service. `StateTransitionValidation` limits which transitions a user may perform, gated by dynamic `use <transition> transition` permissions (plus static permissions like `view any unpublished content`, `view latest version`, `administer moderation states`/`... transitions`). It dispatches a `WorkbenchModerationEvents::STATE_TRANSITION` event on each moderated save, provides Views integration (a "Latest revision" filter and moderation fields), and manages admin UIs at `/admin/structure/workbench-moderation` for states and transitions. It depends on core `views` and `options`. (Note: this is the contrib predecessor of core Content Moderation; new sites usually prefer core, but many existing sites still run it.)

---

- Add a Draft → Needs Review → Published editorial workflow to the Article content type.
- Keep an unpublished draft of an already-published page without taking the live version down.
- Require a second person to move content from Needs Review to Published (separation of duties).
- Archive outdated content with the Published → Archived transition instead of deleting it.
- Restrict who can publish by granting only the `use draft_published transition` permission.
- Let reviewers see the latest forward (draft) revision via the "Latest version" tab.
- Set a bundle's default moderation state for new content (e.g. always start as Draft).
- Limit which moderation states are allowed on a specific content type.
- Add custom moderation states (e.g. "Legal review") as `moderation_state` config entities.
- Define custom transitions between your states with `moderation_state_transition` entities.
- Grant `view any unpublished content` to editors so they can see drafts across the site.
- Build an editorial dashboard View filtered to the latest revision needing review.
- React to publish/unpublish in code by subscribing to the STATE_TRANSITION event.
- Enforce that moderated content types always keep revisions on.
- Give a content type both published and unpublished allowed states via bundle settings.
- Model a two-step approval for legal or compliance content.
- Prevent inline (quick) editing on moderated entities to protect the workflow.
- Track which revision is the current draft for each entity via the revision tracker.
- Use the moderation form to change an entity's state without a full node edit.
- Expose moderation state as a Views field/filter in content lists.
- Migrate an existing site's editorial process onto explicit states and transitions.
- Allow certain roles to moderate content they cannot otherwise edit (`moderate entities that cannot edit`).
- Configure per-transition permissions so each workflow step maps to a role.
- Keep published URLs stable while drafts are edited in the background.
