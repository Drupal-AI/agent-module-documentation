<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `patch` entity, workflow, routes & permissions

## The `patch` content entity (`src/Entity/Patch.php`)

`@ContentEntityType(id="patch")`, base_table `patch`, `admin_permission = "administer patch
entities"`. It is **not** revisionable and is a standalone entity that *references* a node — it is
not a node revision. Key base fields (`baseFieldDefinitions()`):

- `rid` (entity_reference → node, read-only) — the target node.
- `rtype` / `rbundle` (string) — target entity type id (`node`) and bundle.
- `rvid` (int) — the node revision id the patch was **created from** (its "origin").
- `uid` (entity_reference → user) — the patch creator.
- `status` (small int) — see constants below.
- `patch` (`map`, read-only) — the actual per-field diff payload
  (`{field_name: [ {property: diff}, ... ]}`); accessed via `getPatchField()`.
- `message` (string_long) — the log message; also used as the entity `label()`.
- `created` / `changed` / `uuid` / `id`.

Statuses (`src/Events/ChangeRequests.php`, `ChangeRequests::CR_STATUS_*`):
`0` disabled, `1` active/**proposed** (default), `2` conflicted, `3` **applied/patched**,
`4` declined. `getStatus()` / `getStatusLiteral()` map ids to strings; theme `cr_status`.

Handlers: `access` = `PatchAccessControlHandler`, `view_builder` = `PatchViewBuilder`,
`route_provider.html` = `PatchHtmlRouteProvider` (extends `AdminHtmlRouteProvider`, also registers
the settings-form route), forms `default`/`edit` = `PatchForm`, `apply` = `PatchApplyForm`,
`delete` = `PatchDeleteForm`. Link templates: `canonical` `/patch/{patch}`, `apply-form`
`/patch/{patch}/apply`, `edit-form` `/patch/{patch}/edit`, `delete-form` `/patch/{patch}/delete`.

Helpers: `originalEntity()` (loads target node), `originalEntityRevision('current'|'latest'|
'origin'|<rid>)`, `originalEntityRevisionOld()` (the origin revision), `getOrigRevisionIds()`,
`getViewHeaderData()`, `getCacheTagsToInvalidate()` (adds `patch_list:<type>:<id>` and
`<type>:<id>` tags).

## Creation flow (node edit → patch)

1. `change_requests_node_presave()` (`.module`) asks `AccessService::startPatchCreateProcess()`
   whether to divert this save (route is node edit form, bundle enabled, user has
   `add patch entities`, and either the user cannot bypass or ticked the "create_patch" checkbox).
2. If yes, a `changed_fields\EntitySubject($node)` is created and `NodeObserver` attached, then
   `notify()`.
3. `NodeObserver::update()` (runs only when `$node->isNewRevision()`): builds `getNodeDiff()`
   per-field via the plugin manager, creates/loads an active `patch` for that node (status 1,
   `rvid=0` placeholder set on create), sets `rvid` = original revision id, `patch` = diff,
   `message`, `uid` = current user, and saves it. **Then it resets the changed node fields back to
   their original values** so the node itself is left unchanged, rewrites the node `revision_log`
   to point at the new patch, and shows a "change request saved / pending" message.
4. Optional: `?attach_to=<entity_type>/<id>/<field>` makes `AttachService::attachPatchTo()` append
   the new patch id to that entity-reference (target_type `patch`) field.

## Apply / merge flow (`src/Form/PatchApplyForm.php`)

- `buildForm()` renders, per patched field: the intended change (left, via the field's
  `FieldPatchPlugin::getFieldPatchView()`), and the **latest** node revision's real field widget
  with the patch already applied (right, editable), so a reviewer fixes merge conflicts inline.
  Merge percentage/feedback comes from diff-match-patch (`DiffService::applyPatchText`).
- `submitForm()` loads `originalEntityRevision('latest')`, writes each submitted field value into
  it (filtered through the plugin's `prepareDataDb()` / `validateDataIntegrity()`), sets a new
  revision with a log message crediting the patch author, saves the node, then sets the patch
  `status` to `CR_STATUS_PATCHED` (3) and redirects to the node.

## Overview & AJAX

- `PatchesOverview::overview($node)` (`/node/{node}/patches`) — table of all patches for the node
  (newest first) with per-row View/Apply/Edit/Delete operations, each gated by
  `$entity->access(op)`. `hook_menu_local_tasks_alter` hides the tab for non-managed bundles and
  appends the active-patch count badge from `cr_count`.
- `PatchAjaxController::getPatchAjax($patch)` (`/ajax/patch/{patch}`) — renders the patch entity
  (view mode `full`) inside an `OpenModalDialogCommand`.

## Routes & required permissions

| Route | Path | Requirement |
|---|---|---|
| `change_requests.patches_overview` | `/node/{node}/patches` | perm `view patch entities` |
| `entity.patch.canonical` | `/patch/{patch}` | `_entity_access: patch.view` |
| `entity.patch.edit_form` | `/patch/{patch}/edit` | `_entity_access: patch.update` |
| `entity.patch.delete_form` | `/patch/{patch}/delete` | `_entity_access: patch.delete` |
| `entity.patch.apply_form` | `/patch/{patch}/apply` | `_access_patch_apply: apply` |
| `change_requests.patch_ajax_controller_getPatchAjax` | `/ajax/patch/{patch}` | perm `view patch entities` |
| `change_requests.change_requests_config` | `/admin/config/content/change_requests` | perm `administer patch entities` |

## Access handler (`PatchAccessControlHandler::checkAccess`)

- `view` → perm `view patch entities`; `update` → `edit patch entities`; `delete` →
  `delete patch entities`; create → `add patch entities`.
- `apply` → **forbidden** unless the patch `status` is active (1); then if the current user is the
  patch creator it requires `apply own patch entities`, otherwise `apply patch entities`.
- Custom checker `PatchApplyAccessCheck` (service `change_requests.patch_apply_access_service`,
  tag `_access_patch_apply`) simply delegates to `$patch->access('apply')`.

Permissions summary: `add patch entities` (create; unrestricted), `view patch entities`,
`view unpublished patch entities`, `edit patch entities`, `apply patch entities` (restricted),
`apply own patch entities` (restricted), `change status of patch entities` (restricted),
`delete patch entities` (restricted), `bypass patch creation` (restricted — save nodes directly),
`administer patch entities` (restricted — settings form). `hook_requirements` /
`_change_requests_check_permissions()` raise a status-report error if a role with
`add patch entities` lacks `edit any <bundle> content` for an enabled bundle.
