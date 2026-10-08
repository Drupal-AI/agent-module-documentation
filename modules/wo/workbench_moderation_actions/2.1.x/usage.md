<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WBM actions replaces Drupal core's "Publish content" / "Unpublish content" bulk actions (which don't work correctly with Workbench Moderation) with one bulk action per Workbench Moderation state, so editors can set the moderation state of many nodes at once from the content overview.

---

The module targets [Workbench Moderation](https://www.drupal.org/project/workbench_moderation)
(the contrib moderation system, **not** core Content Moderation). It defines a single Action
plugin, `state_change`, whose `StateChangeDeriver` produces one derivative per **(moderated
entity type × moderation state)** — e.g. `state_change:node__published`,
`state_change:node__archived`. On install (`hook_install`) it deletes the core
`node_publish_action` and `node_unpublish_action` config entities and creates an `action` config
entity for every derivative; on uninstall it restores the two core node actions from the node
module's default config. Executing an action loads the entity's latest revision, sets
`moderation_state` to the derivative's target state, validates the transition and saves it as the
new default revision (respecting Workbench Moderation's transition validation, and skipping
entities that are not moderatable). Access per action is gated by
`StateTransitionValidation::userMayTransition(from, to, account)`. The module also adds per-row
AJAX operation links ("Set to <state>") on moderatable entities via `hook_entity_operation()`,
backed by a CSRF-protected `state_change` route/controller. The derived actions appear in the
**Action** dropdown on `/admin/content` (and any Views Bulk Operations list).

---

- Bulk-move a batch of selected nodes to the "Published" Workbench Moderation state.
- Send many draft nodes to "Archived" in one operation from the content overview.
- Transition a set of pages to "Needs Review" before an editorial deadline.
- Replace core's broken Publish/Unpublish actions on a Workbench Moderation site.
- Give editors a single-click "Set to <state>" AJAX link on each moderatable content row.
- Apply a moderation-state change to hundreds of nodes via Views Bulk Operations.
- Roll a group of articles back to "Draft" for re-editing.
- Enforce transition rules during bulk changes (invalid transitions are blocked per user).
- Let a reviewer approve (publish) a queue of submitted content at once.
- Bulk-unpublish outdated content by moving it to an unpublished moderation state.
- Provide state-change actions automatically for every moderated entity type, not just nodes.
- Skip non-moderated entities safely when running a bulk state change over a mixed selection.
- Support scheduler/advanced_scheduler by clearing a stale `publish_on` when bulk publishing.
- Preserve translations correctly when bulk-changing the moderation state of translated nodes.
- Clean up a content backlog by archiving everything in an old state in one pass.
- Offer moderation transitions as operations links for quick single-item changes.
- Integrate state changes into custom admin views listing moderated content.
- Restore core publish/unpublish actions cleanly by uninstalling the module.
- Bulk-promote reviewed content to published during a site launch.
- Standardize editorial batch operations around Workbench Moderation states.
