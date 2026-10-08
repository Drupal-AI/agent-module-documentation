<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Change requests (change_requests) — agent index

Captures a user's node edits as a separate field-by-field **`patch`** content entity (a
pull-request-style proposed edit) instead of writing them to the node; reviewers view the diff
and later merge/apply the patch, producing a new node revision. Package `RulesFinder`.
Core `^9.3 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.1.9.

## Dependencies

- Drupal `node` (core).
- `drupal/changed_fields` (**Changed Field API**) — detects which node fields changed.
- Composer lib `yetanotherape/diff-match-patch` `^1.1` — text diff/patch/merge (Google DMP port).

## What it provides

- **Entity** `patch` (`src/Entity/Patch.php`): base table `patch`; stores target node ref
  (`rid`/`rtype`/`rbundle`/`rvid`), creator `uid`, `status` (int; see
  `src/Events/ChangeRequests.php`: 1 proposed/active, 2 conflicted, 3 applied, 4 declined,
  0 disabled), `message`, and a `map` field `patch` holding per-field diffs. Handlers: access,
  view builder, views data, route provider, forms (default/edit/apply/delete).
- **Plugin type** `FieldPatchPlugin` (annotation `src/Annotation/FieldPatchPlugin.php`, manager
  `plugin.manager.field_patch_plugin`, base `src/Plugin/FieldPatchPluginBase.php`). One plugin per
  field-type family under `src/Plugin/FieldPatchPlugin/` (Text, TextSummary, Data, Boolean, List,
  Link, DateTime, Daterange, Reference, File, Image). Alter hook
  `change_requests_field_patch_plugin_info`.
- **Services**: `change_requests.diff` (DiffService — diff-match-patch adapter),
  `change_requests.access_service` (node-form gating logic), `change_requests.attach_service`,
  `change_requests.breadcrumb`, `plugin.manager.field_patch_plugin`.
- **Permissions** (`change_requests.permissions.yml`): `add patch entities`, `view patch entities`,
  `view unpublished patch entities`, `edit patch entities`, `apply patch entities`,
  `apply own patch entities`, `change status of patch entities`, `delete patch entities`,
  `bypass patch creation`, `administer patch entities`.
- **Config** object `change_requests.config` (settings form
  `change_requests.change_requests_config` at `/admin/config/content/change_requests`).
- **Computed field** `cr_count` on managed node bundles (count of referencing patches).

## Routes

- `/node/{node}/patches` — per-node change-request overview (`PatchesOverview`; perm
  `view patch entities`).
- `/patch/{patch}` `/patch/{patch}/edit` `/patch/{patch}/delete` — entity view/edit/delete
  (from `PatchHtmlRouteProvider`, standard `_entity_access`).
- `/patch/{patch}/apply` — apply/merge form (`PatchApplyForm`; custom `_access_patch_apply`).
- `/ajax/patch/{patch}` — render a patch in a modal (`PatchAjaxController`; perm
  `view patch entities`).

## How it works (node → patch → apply)

`hook_node_presave` → `AccessService::startPatchCreateProcess()` decides whether to divert the
save; if so a `changed_fields` `EntitySubject` notifies `NodeObserver`, which builds per-field
diffs, saves a `patch`, and resets the node fields back to their original values. Reviewers apply
via `PatchApplyForm::submitForm()`, which writes patched values into the latest node revision and
saves it. See the solution docs.

## Solution docs

- Entity model, statuses, workflow, routes & permissions →
  [api/patch-entity.md](api/patch-entity.md)
- The `FieldPatchPlugin` plugin type, plugin manager, diff/merge internals →
  [plugins/field-patch.md](plugins/field-patch.md)
- Settings form, config object & schema, node-form behaviour →
  [config/settings.md](config/settings.md)
