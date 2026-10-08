Adds per-workflow, per-state `view`/`update`/`delete` permissions for content-moderated entities, so you can restrict who may act on entities while they sit in a given moderation state (e.g. only editors may edit content still in "Draft").

---

The module implements `hook_entity_access()`: for any entity that Content Moderation treats as moderated (`content_moderation.moderation_information` service), and for the `view`, `update`, and `delete` operations, it looks up the entity's *current* moderation state and requires a matching permission named `workflow <workflow_id> - <operation> entities in <state_id> state`. The permission set is generated dynamically by `PermissionsGenerator::getPermissions()` (registered via `permission_callbacks` in the `.permissions.yml`), iterating every `Workflow` config entity × every state × the three operations, so the exact permissions available depend on the workflows configured on the site. The access check is **additive and fail-safe**: it returns `AccessResult::forbidden()` when the account lacks the required permission and `AccessResult::neutral()` otherwise, so it can only ever *deny* access on top of core's own checks — it never grants access a user would not otherwise have. There is no settings form (`configure` is null), no config schema, and no Drush; the only surface is the generated permissions on `admin/people/permissions`. Depends only on `workflows` (Content Moderation must be providing the moderated entity for the hook to fire). Note the gating keys off the entity's current stored state, not the transition being attempted, and — like all `hook_entity_access` — it does not fire on code paths that bypass entity access (e.g. Views without an access filter, some listing/render contexts).

---

- Prevent non-editors from editing nodes that are still in the "Draft" moderation state.
- Hide entities in an "Archived" state from most roles by withholding the per-state `view` permission.
- Let only senior editors delete content that is in a "Needs review" state.
- Grant a "Reviewer" role `update` on "Draft" content but not on "Published" content.
- Lock published content from edits by everyone except a publisher role via the `update ... in published state` permission.
- Give a translator role `update` rights only while content sits in an intermediate state.
- Restrict `delete` of content in any non-archived state to administrators.
- Model a two-tier editorial flow where each state exposes a distinct edit permission.
- Combine with core Content Moderation transition permissions to gate both who can edit *and* who can transition.
- Apply the same state-based rules across multiple entity types that share one workflow.
- Use separate workflows (e.g. one for articles, one for pages) with independent per-state permission sets.
- Temporarily freeze editing of content in a "Scheduled" state by revoking its `update` permission.
- Withhold `view` on a "Rejected" state so authors cannot see rejected submissions of others.
- Enforce least-privilege editorial access without writing a custom access module.
- Audit which roles can touch which states by reading the generated permissions matrix.
- Layer state-based restrictions on top of node access modules (the module only adds forbids).
- Prevent editors from deleting anything once it reaches a terminal published state.
- Give a "Legal" role review-only (`view`) access to content in a "Legal review" state.
- Provide different delete rights per state for a compliance workflow.
- Restrict access to moderated media or custom content entities the same way as nodes.
