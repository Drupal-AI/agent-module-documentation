# WSE integration behaviour — forms, entities, routes, cron

What WSE changes about a site once enabled. Relevant if you build forms/entities that must
coexist with workspaces, or integrate a module with WSE. Hooks are OOP hooks (`#[Hook(...)]`
attribute classes under `src/Hook/`).

## Forms — the safe-forms / "submit to Live" mechanism (`WseFormHooks`)

- While a workspace is active, **every** form that a workspace cannot track is altered
  (`hook_form_alter`, `Order::Last`): a hidden `wse_bypass_workspace` field is added and a
  client-side confirmation dialog (`wse/form-submit-dialog` library) warns the editor that
  submitting will write to **Live**. When that field is posted, `WseWorkspaceManager` reports
  no active workspace for the request, so core saves to Live. Existing access checks are
  unchanged — the field only chooses which workspace context the write lands in.
- A form is **exempt** (submits silently inside the workspace, no dialog) when it is marked
  workspace-safe. WSE marks safe (`hook_form_alter`, `Order::First`):
  `node_revision_revert_confirm`, `node_revision_delete_confirm`, plus every form ID listed in
  `wse.settings:safe_forms`. In code you can also implement
  `Drupal\Core\Form\WorkspaceSafeFormInterface` or set `$form_state->set('workspace_safe', TRUE)`.
- `hook_form_workspace_publish_form_alter` adds the "Clone workspace details…" checkbox and
  redirects to the workspace collection after publishing.

**To let your custom form save inside a workspace**: add its form ID to `safe_forms`, or make
its form class implement `WorkspaceSafeFormInterface`. Only do this for forms whose changes a
workspace can actually track — otherwise the data is written straight to Live.

## Entities (`WseEntityTypeHooks`, `WseEntityHooks`)

- `hook_entity_type_alter`: swaps the workspace list builder (open/closed filtering); for every
  workspace-supported entity type adds a `WseClosedWorkspace` constraint (blocks edits in a
  closed workspace) and `move-to-workspace` / `discard-changes` link templates; for unsupported
  types adds a `WseUnsupportedEntityType` constraint.
- `hook_entity_type_build`: marks `crop`, `paragraph`, `embedded_paragraphs`, `file`, `variant`,
  `events_logging` as ignored (CRUD allowed in a workspace without tracking).
- `hook_entity_base_field_info`: installs the `status` (open/closed) base field on `workspace`.
- `hook_field_info_alter` / `hook_validation_constraint_alter`: replaces core's
  `EntityReferenceSupportedNewEntities` and `EntityUntranslatableFields` constraints with
  WSE-aware versions.
- `hook_entity_extra_field_info` / `hook_entity_view`: adds the read-only
  `entity_workspace_status` pseudo-field (published/draft badge) for entity types listed in
  `entity_workspace_status` config.
- `hook_entity_access`: for revisionable supported entities, **forbids** `revert`/`revert
  revision`/`delete revision` unless the active workspace is the one tracking that entity
  (adds a `workspace` cache context). This only restricts access; it never grants.
- `hook_entity_field_access`: forbids the workspace `parent` field when
  `disable_sub_workspaces` is on.

## Routes added/altered (`RouteSubscriber`, runs after `diff`, weight `-100`)

- Adds `_workspace_status: open` to `entity.workspace.activate_form` and
  `entity.workspace.publish_form`; swaps the publish form to `WseWorkspacePublishForm`.
- For every workspace-supported entity type with a canonical/edit route, adds:
  - `entity.{type}.move_to_workspace` at `…/move-to-workspace/{source_workspace}`
    (`MoveEntityForm`, requires `_entity_access: source_workspace.update`).
  - `entity.{type}.discard_changes` at `…/discard-changes/{source_workspace}`
    (`DiscardEntityForm`, requires `_entity_access: source_workspace.update`).
  - `entity.{type}.workspace.revisions_diff` (only if `diff` enabled) requires
    `_entity_access: {type}.view`.
  - Replaces the version-history controller with a workspace-aware one.
- Static routes (`wse.routing.yml`): `wse.settings`, `wse.switch_to_live`
  (`/wse/switch-to-live`, redirects to front — see [../blocks/switch-to-live.md](../blocks/switch-to-live.md)),
  `entity.workspace.revert_form` (`administer workspaces` + `_workspace_status: closed`).

## Cron & queue (`WseOverrideHooks`, `WorkspaceRevisionCleaner`)

- `hook_cron`: replaces core workspaces' cron (`#[RemoveHook]`) to avoid cleaning up revisions
  for deleted closed workspaces; runs core's cleanup inside a `trash` "ignore" context when the
  `trash` module is present.
- QueueWorker `wse_revision_cleaner` deletes intermediary revisions queued by
  `squash_on_publish`, honouring `squash_on_publish_interval` (each item stores a
  `process_time`).

## Outbound URLs (`WsePathProcessor`)

When `append_current_workspace_to_url` is true and a workspace is active, appends
`?workspace=<id>` to internal outbound links (skips external URLs and links that already carry
a `workspace` query). `WorkspaceSwitchSubscriber` strips the `workspace` query param on switch
and records recently-used workspaces in the per-user `wse` tempstore.
